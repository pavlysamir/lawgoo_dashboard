import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lowgos_dashboard/core/services/injection_container.dart';
import 'package:lowgos_dashboard/core/widgets/gradient_background.dart';
import 'package:lowgos_dashboard/features/laws/domain/entities/law_entity.dart';
import 'package:lowgos_dashboard/features/laws/presentation/bloc/laws_cubit.dart';
import 'package:lowgos_dashboard/features/laws/presentation/pages/law_materials_page.dart';
import 'package:lowgos_dashboard/features/laws/presentation/pages/laws_page.dart';
import 'package:lowgos_dashboard/features/users/presentation/bloc/users_cubit.dart';
import 'package:lowgos_dashboard/features/users/presentation/pages/users_page.dart';
import 'package:lowgos_dashboard/features/questions_management/presentation/bloc/questions_management_cubit.dart';
import 'package:lowgos_dashboard/features/questions_management/presentation/pages/questions_management_page.dart';
import 'package:lowgos_dashboard/features/questions_management/presentation/pages/add_questions_page.dart';
import 'package:lowgos_dashboard/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:lowgos_dashboard/features/settings/presentation/pages/settings_page.dart';
import '../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../../core/utils/app_colors.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/side_menu.dart';
import '../widgets/stat_card.dart';
import '../widgets/top_bar.dart';
import '../widgets/user_table.dart';
import '../widgets/search_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedTab = 0;
  int _selectedStat = 0;
  LawEntity? _selectedLawForMaterials;
  LawEntity? _selectedLawForQuestions;
  bool _isAddingQuestions = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            logoutSuccess: () {
              context.go('/login');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تسجيل الخروج بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            error: (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('فشل تسجيل الخروج: ${failure.message}'),
                  backgroundColor: AppColors.redAccent,
                ),
              );
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          body: GradientBackground(
            child: Row(
              children: [
                SideMenu(
                  selectedIndex: _selectedTab,
                  onTabChanged: (index) => setState(() {
                    _selectedTab = index;
                    _selectedLawForMaterials = null;
                    _selectedLawForQuestions = null;
                    _isAddingQuestions = false;
                  }),
                ),
                // Main Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopBar(adminName: 'أ/ صبري منير', onLogout: () {}),
                        const SizedBox(height: 40),
                        if (_selectedTab == 0)
                          _buildDashboardContent(context)
                        else if (_selectedTab == 1)
                          Expanded(
                            child: BlocProvider(
                              create: (context) => getIt<UsersCubit>()..init(),
                              child: const UsersPage(),
                            ),
                          )
                        else if (_selectedTab == 2)
                          Expanded(
                            child: _isAddingQuestions && _selectedLawForQuestions != null
                                ? AddQuestionsPage(
                                    law: _selectedLawForQuestions!,
                                    onBack: () => setState(() {
                                      _isAddingQuestions = false;
                                      _selectedLawForQuestions = null;
                                    }),
                                  )
                                : BlocProvider(
                                    create: (context) => getIt<QuestionsManagementCubit>()..init(),
                                    child: QuestionsManagementPage(
                                      onAddQuestions: (law) => setState(() {
                                        _selectedLawForQuestions = law;
                                        _isAddingQuestions = true;
                                      }),
                                    ),
                                  ),
                          )
                        else if (_selectedTab == 3)
                          Expanded(
                            child: _selectedLawForMaterials == null
                                ? BlocProvider(
                                    create: (context) => getIt<LawsCubit>()..init(),
                                    child: LawsPage(
                                      onAddMaterials: (law) {
                                        setState(() => _selectedLawForMaterials = law);
                                      },
                                    ),
                                  )
                                : LawMaterialsPage(
                                    law: _selectedLawForMaterials!,
                                    onBack: () => setState(() => _selectedLawForMaterials = null),
                                  ),
                          )
                        else if (_selectedTab == 4)
                          Expanded(
                            child: BlocProvider(
                              create: (context) => getIt<SettingsCubit>()..init(),
                              child: const SettingsPage(),
                            ),
                          )
                        else
                          const Expanded(
                            child: Center(
                              child: Text(
                                'قريباً...',
                                style: TextStyle(fontFamily: 'Cairo'),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مرحباً بك مجدداً 👋',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              color: AppColors.primary,
            ),
          ),
          const Text(
            'إليك ما يحدث في Lowgos اليوم.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 32),
          // Stats Row
          BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return state.maybeWhen(
                success: (stats, users, isPaginating, failure, currentPage) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatCard(
                        title: 'إجمالي المستخدمين',
                        count: stats.totalUsers?.toString() ?? '...',
                        icon: 'assets/icons/users_icon.svg',
                        isSelected: _selectedStat == 0,
                        onTap: () => setState(() => _selectedStat = 0),
                        badgeText: '12% +',
                        badgeColor: Colors.blue,
                      ),
                      StatCard(
                        title: 'الأسئلة والتمارين',
                        count: stats.totalQuestions?.toString() ?? '...',
                        icon: 'assets/icons/questions_icon.svg',
                        isSelected: _selectedStat == 1,
                        onTap: () => setState(() => _selectedStat = 1),
                        badgeText: 'بدون تغيير',
                        badgeColor: Colors.orange,
                      ),
                      StatCard(
                        title: 'المواد القانونية',
                        count: stats.totalMaterials?.toString() ?? '...',
                        icon: 'assets/icons/laws_icon.svg',
                        isSelected: _selectedStat == 2,
                        onTap: () => setState(() => _selectedStat = 2),
                        badgeText: '5+ اليوم',
                        badgeColor: Colors.green,
                      ),
                      StatCard(
                        title: 'إعدادات النظام',
                        count: stats.isSystemActive ? 'نشطة' : 'متوقفة',
                        icon: 'assets/icons/settings_icon.svg',
                        isSelected: _selectedStat == 3,
                        onTap: () => setState(() => _selectedStat = 3),
                        highlightColor: stats.isSystemActive
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ],
                  );
                },
                orElse: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
          const SizedBox(height: 40),
          // Search Bar
          DashboardSearchBar(
            onSearch: (q) => context.read<DashboardCubit>().search(q),
          ),
          const SizedBox(height: 24),
          // Users Table
          Expanded(
            child: BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                return state.maybeWhen(
                  success: (stats, users, isPaginating, failure, currentPage) {
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: UserTable(
                              users: users,
                              onDelete: (user) => context
                                  .read<DashboardCubit>()
                                  .deleteUser(user.id),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Pagination
                        _buildPagination(currentPage),
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (f) => Center(child: Text(f.message)),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left)),
        ...List.generate(5, (index) {
          int page = index + 1;
          bool isSelected = page == currentPage;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              page.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontFamily: 'Cairo',
              ),
            ),
          );
        }),
        const Text('...', style: TextStyle(color: Colors.grey)),
        const SizedBox(width: 8),
        const Text('9', style: TextStyle(fontFamily: 'Cairo')),
        IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right)),
        const Spacer(),
        const Text(
          'عرض 4 مستخدمين من إجمالي 45',
          style: TextStyle(color: Colors.grey, fontFamily: 'Cairo', fontSize: 12),
        ),
      ],
    );
  }
}
