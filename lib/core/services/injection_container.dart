import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

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
}
