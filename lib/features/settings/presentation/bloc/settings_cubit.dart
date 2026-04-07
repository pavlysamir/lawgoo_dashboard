import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_admin_usecase.dart';
import '../../domain/usecases/delete_admin_usecase.dart';
import '../../domain/usecases/get_admins_usecase.dart';
import '../../domain/usecases/toggle_admin_status_usecase.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final CreateAdminUseCase createAdminUseCase;
  final GetAdminsUseCase getAdminsUseCase;
  final ToggleAdminStatusUseCase toggleAdminStatusUseCase;
  final DeleteAdminUseCase deleteAdminUseCase;

  SettingsCubit({
    required this.createAdminUseCase,
    required this.getAdminsUseCase,
    required this.toggleAdminStatusUseCase,
    required this.deleteAdminUseCase,
  }) : super(const SettingsState.initial());

  Future<void> init() async {
    emit(const SettingsState.loading());
    await _fetchAdmins();
  }

  Future<void> _fetchAdmins() async {
    final result = await getAdminsUseCase();

    result.fold(
      (failure) => emit(SettingsState.error(failure)),
      (admins) => emit(SettingsState.success(admins: admins)),
    );
  }

  Future<void> createAdmin({
    required String name,
    required String email,
    required String password,
  }) async {
    state.maybeWhen(
      success: (admins, isCreating, error) {
        emit(SettingsState.success(admins: admins, isCreating: true));
      },
      orElse: () {},
    );

    final result = await createAdminUseCase(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        state.maybeWhen(
          success: (admins, isCreating, error) {
            emit(SettingsState.success(admins: admins, isCreating: false, error: failure));
          },
          orElse: () => emit(SettingsState.error(failure)),
        );
      },
      (_) async {
        await _fetchAdmins();
      },
    );
  }

  Future<void> toggleAdminStatus(String adminId, bool isActive) async {
    final result = await toggleAdminStatusUseCase(adminId, isActive);

    result.fold(
      (failure) {
        state.maybeWhen(
          success: (admins, isCreating, error) {
            emit(SettingsState.success(admins: admins, error: failure));
          },
          orElse: () {},
        );
      },
      (_) async {
        await _fetchAdmins();
      },
    );
  }

  Future<void> deleteAdmin(String adminId) async {
    final result = await deleteAdminUseCase(adminId);

    result.fold(
      (failure) {
        state.maybeWhen(
          success: (admins, isCreating, error) {
            emit(SettingsState.success(admins: admins, error: failure));
          },
          orElse: () {},
        );
      },
      (_) async {
        await _fetchAdmins();
      },
    );
  }
}
