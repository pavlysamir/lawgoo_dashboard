import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../../dashboard/domain/entities/user_entity.dart';

part 'users_state.freezed.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState.initial() = _Initial;
  const factory UsersState.loading() = _Loading;
  const factory UsersState.success({
    required List<UserEntity> users,
    @Default(false) bool isPaginating,
    Failure? paginationFailure,
    @Default(1) int currentPage,
    @Default(false) bool isSearching,
  }) = _Success;
  const factory UsersState.error(Failure failure) = _Error;
}
