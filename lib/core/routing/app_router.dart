import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lowgos_dashboard/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:lowgos_dashboard/features/auth/presentation/pages/auth_page.dart';

import '../../features/dashboard/presentation/bloc/dashboard_cubit.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../services/injection_container.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const AuthPage(),
        ),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<DashboardCubit>()..init()),
            BlocProvider(create: (_) => getIt<AuthCubit>()),
          ],
          child: const DashboardPage(),
        ),
      ),
    ],
  );
}
