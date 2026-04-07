import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lowgos_dashboard/core/utils/app_colors.dart';
import 'package:lowgos_dashboard/core/utils/app_text_styles.dart';
import 'package:lowgos_dashboard/core/widgets/custom_text_form_field.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/settings_state.dart';

class AddAdminForm extends StatefulWidget {
  const AddAdminForm({super.key});

  @override
  State<AddAdminForm> createState() => _AddAdminFormState();
}

class _AddAdminFormState extends State<AddAdminForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person_add_outlined, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'إضافة حساب مسؤول جديد',
                  style: AppTextStyles.font18BoldBlack.copyWith(fontFamily: 'Cairo'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('الاسم', style: TextStyle(fontFamily: 'Cairo')),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _nameController,
                        hintText: 'أدخل الاسم',
                        validator: (value) =>
                            value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('البريد الإلكتروني', style: TextStyle(fontFamily: 'Cairo')),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: 'example@system.com',
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
                          if (!value.contains('@')) return 'بريد إلكتروني غير صالح';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('كلمة المرور', style: TextStyle(fontFamily: 'Cairo')),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: '********',
                        obscureText: true,
                        suffixIcon: const Icon(Icons.lock_outline, size: 20),
                        validator: (value) => value != null && value.length < 6
                            ? 'يجب أن تكون 6 أحرف على الأقل'
                            : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    bool isLoading = state.maybeWhen(
                      success: (admins, isCreating, error) => isCreating,
                      orElse: () => false,
                    );

                    return Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: ElevatedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<SettingsCubit>().createAdmin(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                  _nameController.clear();
                                  _emailController.clear();
                                  _passwordController.clear();
                                }
                              },
                        icon: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.person_add, color: Colors.white),
                        label: const Text(
                          'إنشاء الحساب',
                          style: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل وتتضمن أرقاماً ورموزاً.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
