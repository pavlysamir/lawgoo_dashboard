import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_admin.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginAdmin loginAdmin;

  AuthCubit({required this.loginAdmin}) : super(const AuthState.initial());

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
}
