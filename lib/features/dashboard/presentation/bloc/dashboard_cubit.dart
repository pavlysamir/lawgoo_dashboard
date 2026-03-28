import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_dashboard_stats.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/search_users.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardStats getDashboardStats;
  final GetUsers getUsers;
  final SearchUsers searchUsers;

  Timer? _searchTimer;

  DashboardCubit({
    required this.getDashboardStats,
    required this.getUsers,
    required this.searchUsers,
  }) : super(const DashboardState.initial());

  Future<void> init() async {
    emit(const DashboardState.loading());
    
    final statsResult = await getDashboardStats();
    final usersResult = await getUsers(limit: 4);

    statsResult.fold(
      (failure) => emit(DashboardState.error(failure)),
      (stats) {
        usersResult.fold(
          (failure) => emit(DashboardState.error(failure)),
          (users) => emit(DashboardState.success(stats: stats, users: users)),
        );
      },
    );
  }

  Future<void> fetchNextPage() async {
    await state.maybeMap(
      success: (successState) async {
        if (successState.isPaginating) return;

        emit(successState.copyWith(isPaginating: true, paginationFailure: null));

        final lastUser = successState.users.isNotEmpty ? successState.users.last : null;
        final result = await getUsers(limit: 4, lastUser: lastUser);

        result.fold(
          (failure) => emit(successState.copyWith(
            isPaginating: false,
            paginationFailure: failure,
          )),
          (newUsers) {
            emit(successState.copyWith(
              isPaginating: false,
              users: [...successState.users, ...newUsers],
              currentPage: successState.currentPage + 1,
            ));
          },
        );
      },
      orElse: () async {},
    );
  }

  Future<void> search(String query) async {
    _searchTimer?.cancel();
    
    if (query.isEmpty) {
      await _resetSearch();
      return;
    }

    _searchTimer = Timer(const Duration(milliseconds: 500), () async {
      final result = await searchUsers(query);
      
      state.maybeMap(
        success: (successState) {
          result.fold(
            (failure) => emit(DashboardState.error(failure)),
            (users) => emit(successState.copyWith(users: users)),
          );
        },
        orElse: () {},
      );
    });
  }

  Future<void> _resetSearch() async {
    await state.maybeMap(
      success: (successState) async {
        // Only fetch users, keep existing stats
        final usersResult = await getUsers(limit: 4);

        usersResult.fold(
          (failure) => emit(DashboardState.error(failure)),
          (users) => emit(successState.copyWith(users: users, currentPage: 1)),
        );
      },
      orElse: () async {
        await init();
      },
    );
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
