import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lowgos_dashboard/features/auth/domain/usecases/logout_usecase.dart';
import '../../domain/usecases/login_admin.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginAdmin loginAdmin;
  final LogOutUseCase logOutUseCase;

  AuthCubit({required this.loginAdmin, required this.logOutUseCase})
      : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());

    final result = await loginAdmin(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (_) => emit(const AuthState.success()),
    );
  }

  Future<void> logOut() async {
    emit(const AuthState.logoutLoading());

    final result = await logOutUseCase();

    result.fold(
      (failure) => emit(AuthState.error(failure)),
      (_) => emit(const AuthState.logoutSuccess()),
    );
  }
}
