import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.logoutLoading() = _LogoutLoading;
  const factory AuthState.success() = _Success;
  const factory AuthState.logoutSuccess() = _LogoutSuccess;
  const factory AuthState.error(Failure failure) = _Error;
}
