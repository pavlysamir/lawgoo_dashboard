import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/admin_user.dart';
import '../repositories/auth_repository.dart';

class LoginAdmin {
  final AuthRepository repository;

  LoginAdmin(this.repository);

  Future<Either<Failure, AdminUser>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
