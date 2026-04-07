import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../../dashboard/domain/entities/user_entity.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial() = _Initial;
  const factory SettingsState.loading() = _Loading;
  const factory SettingsState.success({
    required List<UserEntity> admins,
    @Default(false) bool isCreating,
    Failure? error,
  }) = _Success;
  const factory SettingsState.error(Failure failure) = _Error;
}
