import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientTop, AppColors.gradientBottom],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            children: [
              SideMenu(
                selectedIndex: _selectedTab,
                onTabChanged: (index) => setState(() => _selectedTab = index),
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
                            success:
                                (
                                  stats,
                                  users,
                                  isPaginating,
                                  failure,
                                  currentPage,
                                ) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StatCard(
                                        title: 'إجمالي المستخدمين',
                                        count:
                                            stats.totalUsers?.toString() ??
                                            '...',
                                        icon: 'assets/icons/users_icon.svg',
                                        isSelected: _selectedStat == 0,
                                        onTap: () =>
                                            setState(() => _selectedStat = 0),
                                        badgeText: '12% +',
                                        badgeColor: Colors.blue,
                                      ),
                                      StatCard(
                                        title: 'الأسئلة والتمارين',
                                        count:
                                            stats.totalQuestions?.toString() ??
                                            '...',
                                        icon: 'assets/icons/questions_icon.svg',
                                        isSelected: _selectedStat == 1,
                                        onTap: () =>
                                            setState(() => _selectedStat = 1),
                                        badgeText: 'بدون تغيير',
                                        badgeColor: Colors.orange,
                                      ),
                                      StatCard(
                                        title: 'المواد القانونية',
                                        count:
                                            stats.totalMaterials?.toString() ??
                                            '...',
                                        icon: 'assets/icons/laws_icon.svg',
                                        isSelected: _selectedStat == 2,
                                        onTap: () =>
                                            setState(() => _selectedStat = 2),
                                        badgeText: '5+ اليوم',
                                        badgeColor: Colors.green,
                                      ),
                                      StatCard(
                                        title: 'إعدادات النظام',
                                        count: stats.isSystemActive
                                            ? 'نشطة'
                                            : 'متوقفة',
                                        icon: 'assets/icons/settings_icon.svg',
                                        isSelected: _selectedStat == 3,
                                        onTap: () =>
                                            setState(() => _selectedStat = 3),
                                        highlightColor: stats.isSystemActive
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                    ],
                                  );
                                },
                            orElse: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      // Search Bar
                      DashboardSearchBar(
                        onSearch: (q) =>
                            context.read<DashboardCubit>().search(q),
                      ),
                      const SizedBox(height: 24),
                      // Users Table
                      Expanded(
                        child: BlocBuilder<DashboardCubit, DashboardState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              success:
                                  (
                                    stats,
                                    users,
                                    isPaginating,
                                    failure,
                                    currentPage,
                                  ) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: UserTable(users: users),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        // Pagination
                                        _buildPagination(currentPage),
                                      ],
                                    );
                                  },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (f) => Center(child: Text(f.message)),
                              orElse: () => const SizedBox.shrink(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Side Menu (Right side)
            ],
          ),
        ),
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
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Cairo',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
