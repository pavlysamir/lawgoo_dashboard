import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/assets/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_asset_image.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: GradientBackground(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              state.whenOrNull(
                success: () {
                  context.go('/dashboard');
                },
                error: (failure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(failure.message)));
                },
              );
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return Row(
                    children: [
                      Expanded(flex: 1, child: _buildFormSection(context)),
                      Expanded(flex: 1, child: _buildImageSection()),
                    ],
                  );
                } else {
                  return Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _buildFormSection(context),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: const CustomAssetImage(
            AppAssets.loginImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomAssetImage(
                    AppAssets.logoImage,
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'مرحباً بك في لوحة التحكم',
                    style: AppTextStyles.font28Bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'من خلال لوحة التحكم يمكنك إدارة المحتوى القانوني للتطبيق، إضافة الأسئلة، تنظيم مستويات القوانين، ومتابعة تطوير تجربة التعلم للمستخدمين',
                    style: AppTextStyles.font16RegularGrey,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'بريد إلكتروني ',
                          style: AppTextStyles.font16SemiBoldBlack,
                        ),
                        Text(
                          '*',
                          style: AppTextStyles.font16SemiBoldBlack.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'me@email.com',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء إدخال البريد الإلكتروني';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'كلمة المرور ',
                          style: AppTextStyles.font16SemiBoldBlack,
                        ),
                        Text(
                          '*',
                          style: AppTextStyles.font16SemiBoldBlack.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    hintText: '........',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'برجاء إدخال كلمة المرور';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );

                        return ElevatedButton(
                          onPressed: isLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'تسجيل الدخول',
                                  style: AppTextStyles.font16BoldWhite,
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
