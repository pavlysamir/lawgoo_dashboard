import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lowgos_dashboard/core/utils/app_colors.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/settings_state.dart';
import '../widgets/add_admin_form.dart';
import '../widgets/admin_list_table.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 24),
      children: [
        const AddAdminForm(),
        const SizedBox(height: 32),
        BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (admins, isCreating, error) {
                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.message, style: const TextStyle(fontFamily: 'Cairo')),
                      backgroundColor: AppColors.redAccent,
                    ),
                  );
                }
              },
              error: (failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(failure.message, style: const TextStyle(fontFamily: 'Cairo')),
                    backgroundColor: AppColors.redAccent,
                  ),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (admins, isCreating, error) => AdminListTable(admins: admins),
              error: (failure) => Center(
                child: Column(
                  children: [
                    Text('خطأ: ${failure.message}', style: const TextStyle(fontFamily: 'Cairo')),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<SettingsCubit>().init(),
                      child: const Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Cairo')),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
