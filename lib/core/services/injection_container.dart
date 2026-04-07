import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

// Auth
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_admin.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';

// Dashboard
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/get_dashboard_stats.dart';
import '../../features/dashboard/domain/usecases/get_users.dart';
import '../../features/dashboard/domain/usecases/search_users.dart';
import '../../features/dashboard/domain/usecases/delete_user.dart';
import '../../features/dashboard/presentation/bloc/dashboard_cubit.dart';

// Laws
import '../../features/laws/data/datasources/laws_remote_data_source.dart';
import '../../features/laws/data/repositories/laws_repository_impl.dart';
import '../../features/laws/domain/repositories/laws_repository.dart';
import '../../features/laws/domain/usecases/get_laws_use_case.dart';
import '../../features/laws/domain/usecases/get_laws_count_use_case.dart';
import '../../features/laws/domain/usecases/add_law_use_case.dart';
import '../../features/laws/domain/usecases/delete_law_use_case.dart';
import '../../features/laws/domain/usecases/toggle_law_active_use_case.dart';
import '../../features/laws/presentation/bloc/laws_cubit.dart';

// Law Materials
import '../../features/laws/data/datasources/law_material_remote_datasource.dart';
import '../../features/laws/data/repositories/law_material_repository_impl.dart';
import '../../features/laws/domain/repositories/law_material_repository.dart';
import '../../features/laws/domain/usecases/add_law_material_use_case.dart';
import '../../features/laws/domain/usecases/delete_law_material_use_case.dart';
import '../../features/laws/domain/usecases/get_law_materials_count_use_case.dart';
import '../../features/laws/domain/usecases/get_law_materials_use_case.dart';
import '../../features/laws/domain/usecases/update_law_material_use_case.dart';
import '../../features/laws/presentation/bloc/law_materials_cubit.dart';

// Users
import '../../features/users/presentation/bloc/users_cubit.dart';

// Questions Management
import '../../features/questions_management/data/datasources/questions_remote_data_source.dart';
import '../../features/questions_management/data/repositories/questions_repository_impl.dart';
import '../../features/questions_management/domain/repositories/questions_repository.dart';
import '../../features/questions_management/domain/usecases/add_question_usecase.dart';
import '../../features/questions_management/domain/usecases/delete_question_usecase.dart';
import '../../features/questions_management/domain/usecases/get_questions_usecase.dart';
import '../../features/questions_management/domain/usecases/share_question_usecase.dart';
import '../../features/questions_management/domain/usecases/toggle_question_status_usecase.dart';
import '../../features/questions_management/domain/usecases/update_question_usecase.dart';
import '../../features/questions_management/presentation/bloc/questions_cubit.dart';
import 'package:lowgos_dashboard/features/questions_management/presentation/bloc/questions_management_cubit.dart';

// Settings
import '../../features/settings/data/datasources/settings_remote_data_source.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/create_admin_usecase.dart';
import '../../features/settings/domain/usecases/get_admins_usecase.dart';
import '../../features/settings/domain/usecases/toggle_admin_status_usecase.dart';
import '../../features/settings/domain/usecases/delete_admin_usecase.dart';
import '../../features/settings/presentation/bloc/settings_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  // Features - Auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => LoginAdmin(getIt()));
  getIt.registerLazySingleton(() => LogOutUseCase(getIt()));
  getIt.registerFactory(() => AuthCubit(loginAdmin: getIt(), logOutUseCase: getIt()));

  // Features - Dashboard
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(firestore: getIt()),
  );
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => GetDashboardStats(getIt()));
  getIt.registerLazySingleton(() => GetUsers(getIt()));
  getIt.registerLazySingleton(() => SearchUsers(getIt()));
  getIt.registerLazySingleton(() => DeleteUser(getIt()));
  getIt.registerFactory(
    () => DashboardCubit(
      getDashboardStats: getIt(),
      getUsers: getIt(),
      searchUsers: getIt(),
      deleteUser: getIt(),
    ),
  );
  getIt.registerFactory(
    () => UsersCubit(
      getUsers: getIt(),
      searchUsers: getIt(),
      deleteUser: getIt(),
    ),
  );

  // Features - Laws
  getIt.registerLazySingleton<LawsRemoteDataSource>(
    () => LawsRemoteDataSourceImpl(firestore: getIt()),
  );
  getIt.registerLazySingleton<LawsRepository>(
    () => LawsRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => GetLawsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLawsCountUseCase(getIt()));
  getIt.registerLazySingleton(() => AddLawUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteLawUseCase(getIt()));
  getIt.registerLazySingleton(() => ToggleLawActiveUseCase(getIt()));
  getIt.registerFactory(
    () => LawsCubit(
      getLaws: getIt(),
      getLawsCount: getIt(),
      addLaw: getIt(),
      deleteLaw: getIt(),
    ),
  );
  getIt.registerFactory(
    () => QuestionsManagementCubit(
      getLaws: getIt(),
      getLawsCount: getIt(),
      toggleLawActive: getIt(),
    ),
  );

  // Features - Law Materials
  getIt.registerLazySingleton<LawMaterialRemoteDataSource>(
    () => LawMaterialRemoteDataSourceImpl(firestore: getIt()),
  );
  getIt.registerLazySingleton<LawMaterialRepository>(
    () => LawMaterialRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => AddLawMaterialUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLawMaterialsUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteLawMaterialUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateLawMaterialUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLawMaterialsCountUseCase(getIt()));
  getIt.registerFactory(
    () => LawMaterialsCubit(
      addLawMaterial: getIt(),
      getLawMaterials: getIt(),
      deleteLawMaterial: getIt(),
      updateLawMaterial: getIt(),
      getLawMaterialsCount: getIt(),
    ),
  );

  // Features - Questions Management
  getIt.registerLazySingleton<QuestionsRemoteDataSource>(
    () => QuestionsRemoteDataSourceImpl(firestore: getIt()),
  );
  getIt.registerLazySingleton<QuestionsRepository>(
    () => QuestionsRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => AddQuestionUseCase(getIt()));
  getIt.registerLazySingleton(() => GetQuestionsUseCase(getIt()));
  getIt.registerLazySingleton(() => ToggleQuestionStatusUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteQuestionUseCase(getIt()));
  getIt.registerLazySingleton(() => ShareQuestionUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateQuestionUseCase(getIt()));
  getIt.registerFactory(
    () => QuestionsCubit(
      addQuestion: getIt(),
      getQuestions: getIt(),
      toggleStatus: getIt(),
      deleteQuestion: getIt(),
      shareQuestion: getIt(),
      updateQuestion: getIt(),
      getLaws: getIt(),
      getLawMaterials: getIt(),
    ),
  );

  // Features - Settings
  getIt.registerLazySingleton<SettingsRemoteDataSource>(
    () => SettingsRemoteDataSourceImpl(firestore: getIt(), mainAuth: getIt()),
  );
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton(() => CreateAdminUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAdminsUseCase(getIt()));
  getIt.registerLazySingleton(() => ToggleAdminStatusUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteAdminUseCase(getIt()));
  getIt.registerFactory(
    () => SettingsCubit(
      createAdminUseCase: getIt(),
      getAdminsUseCase: getIt(),
      toggleAdminStatusUseCase: getIt(),
      deleteAdminUseCase: getIt(),
    ),
  );
}
