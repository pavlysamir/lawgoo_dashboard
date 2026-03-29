import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../dashboard/presentation/widgets/search_bar.dart';
import '../../../dashboard/presentation/widgets/user_table.dart';
import '../bloc/users_cubit.dart';
import '../bloc/users_state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'قائمة المستخدمين',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'إدارة وبحث كافة المستخدمين المسجلين في النظام.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: 'Cairo',
          ),
        ),
        const SizedBox(height: 32),
        // Search Bar
        DashboardSearchBar(
          onSearch: (q) => context.read<UsersCubit>().search(q),
        ),
        const SizedBox(height: 24),
        // Users Table
        Expanded(
          child: BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) {
              return state.maybeWhen(
                success: (users, isPaginating, failure, currentPage, isSearching) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: UserTable(
                            users: users,
                            isLoading: isSearching,
                            onDelete:
                                (user) => context
                                    .read<UsersCubit>()
                                    .deleteUser(user.id),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Pagination
                      _buildPagination(context, currentPage, users.length),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (f) => Center(child: Text(f.message)),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPagination(BuildContext context, int currentPage, int currentCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {}, // TODO: Implement previous page if needed
          icon: const Icon(Icons.chevron_left),
        ),
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
        IconButton(
          onPressed: () => context.read<UsersCubit>().fetchNextPage(),
          icon: const Icon(Icons.chevron_right),
        ),
        const Spacer(),
        Text(
          'عرض $currentCount مستخدمين',
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Cairo',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
