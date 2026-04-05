import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:lowgos_dashboard/features/laws/domain/usecases/delete_law_use_case.dart';
import '../../features/laws/data/datasources/law_material_remote_datasource.dart';
import '../../features/laws/data/repositories/law_material_repository_impl.dart';
import '../../features/laws/domain/repositories/law_material_repository.dart';
import '../../features/laws/domain/usecases/add_law_material_use_case.dart';
import '../../features/laws/domain/usecases/delete_law_material_use_case.dart';
import '../../features/laws/domain/usecases/get_law_materials_count_use_case.dart';
import '../../features/laws/domain/usecases/get_law_materials_use_case.dart';
import '../../features/laws/domain/usecases/update_law_material_use_case.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_admin.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc/auth_cubit.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/get_dashboard_stats.dart';
import '../../features/dashboard/domain/usecases/get_users.dart';
import '../../features/dashboard/domain/usecases/search_users.dart';
import '../../features/dashboard/domain/usecases/delete_user.dart';
import '../../features/dashboard/presentation/bloc/dashboard_cubit.dart';
import '../../features/laws/data/datasources/laws_remote_data_source.dart';
import '../../features/laws/data/repositories/laws_repository_impl.dart';
import '../../features/laws/domain/repositories/laws_repository.dart';
import '../../features/laws/domain/usecases/get_laws_use_case.dart';
import '../../features/laws/domain/usecases/get_laws_count_use_case.dart';
import '../../features/laws/domain/usecases/add_law_use_case.dart';
import '../../features/laws/presentation/bloc/laws_cubit.dart';
import '../../features/laws/presentation/bloc/law_materials_cubit.dart';
import '../../features/users/presentation/bloc/users_cubit.dart';

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
  // Data sources
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetDashboardStats(getIt()));
  getIt.registerLazySingleton(() => GetUsers(getIt()));
  getIt.registerLazySingleton(() => SearchUsers(getIt()));
  getIt.registerLazySingleton(() => DeleteUser(getIt()));

  // Bloc
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
  // Data sources
  getIt.registerLazySingleton<LawsRemoteDataSource>(
    () => LawsRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<LawsRepository>(
    () => LawsRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetLawsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLawsCountUseCase(getIt()));
  getIt.registerLazySingleton(() => AddLawUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteLawUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => LawsCubit(
      getLaws: getIt(),
      getLawsCount: getIt(),
      addLaw: getIt(),
      deleteLaw: getIt(),
    ),
  );

  // Features - Law Materials
  // Data sources
  getIt.registerLazySingleton<LawMaterialRemoteDataSource>(
    () => LawMaterialRemoteDataSourceImpl(firestore: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<LawMaterialRepository>(
    () => LawMaterialRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => AddLawMaterialUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLawMaterialsUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteLawMaterialUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateLawMaterialUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLawMaterialsCountUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => LawMaterialsCubit(
      addLawMaterial: getIt(),
      getLawMaterials: getIt(),
      deleteLawMaterial: getIt(),
      updateLawMaterial: getIt(),
      getLawMaterialsCount: getIt(),
    ),
  );
}
