import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';
import '../models/admin_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AdminUserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<AdminUserModel> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return AdminUserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
        );
      } else {
        throw const ServerFailure('Failed to login: User is null');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        throw const InvalidCredentialsFailure();
      } else {
        throw ServerFailure(e.message ?? 'Unknown Firebase Error');
      }
    } catch (e) {
      throw ServerFailure('An unexpected error occurred: $e');
    }
  }
}
