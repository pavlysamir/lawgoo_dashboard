import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../dashboard/domain/usecases/get_users.dart';
import '../../../dashboard/domain/usecases/search_users.dart';
import 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetUsers getUsers;
  final SearchUsers searchUsers;

  Timer? _searchTimer;
  static const int _limit = 10;

  UsersCubit({
    required this.getUsers,
    required this.searchUsers,
  }) : super(const UsersState.initial());

  Future<void> init() async {
    emit(const UsersState.loading());
    
    final result = await getUsers(limit: _limit);

    result.fold(
      (failure) => emit(UsersState.error(failure)),
      (users) => emit(UsersState.success(users: users)),
    );
  }

  Future<void> fetchNextPage() async {
    await state.maybeMap(
      success: (successState) async {
        if (successState.isPaginating || successState.isSearching) return;

        emit(successState.copyWith(isPaginating: true, paginationFailure: null));

        final lastUser = successState.users.isNotEmpty ? successState.users.last : null;
        final result = await getUsers(limit: _limit, lastUser: lastUser);

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
      state.maybeMap(
        success: (successState) {
          emit(successState.copyWith(isSearching: true));
        },
        orElse: () => emit(const UsersState.loading()),
      );

      final result = await searchUsers(query);
      
      result.fold(
        (failure) => emit(UsersState.error(failure)),
        (users) {
          state.maybeMap(
            success: (successState) {
              emit(successState.copyWith(users: users, isSearching: false));
            },
            orElse: () => emit(UsersState.success(users: users, isSearching: false)),
          );
        },
      );
    });
  }

  Future<void> _resetSearch() async {
    await state.maybeMap(
      success: (successState) async {
        if (!successState.isSearching && successState.currentPage == 1 && successState.users.length <= _limit) {
           // Already in initial state or similar, but let's re-fetch to be sure
        }
        
        emit(const UsersState.loading());
        final usersResult = await getUsers(limit: _limit);

        usersResult.fold(
          (failure) => emit(UsersState.error(failure)),
          (users) => emit(UsersState.success(users: users, currentPage: 1)),
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
