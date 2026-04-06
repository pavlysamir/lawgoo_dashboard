import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../laws/domain/entities/law_entity.dart';
import '../bloc/questions_management_cubit.dart';
import '../bloc/questions_management_state.dart';
import '../widgets/question_law_card.dart';

class QuestionsManagementPage extends StatelessWidget {
  final Function(LawEntity) onAddQuestions;

  const QuestionsManagementPage({super.key, required this.onAddQuestions});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsManagementCubit, QuestionsManagementState>(
      listener: (context, state) {
        state.maybeMap(
          success: (s) {
            if (s.toggleActiveFailure != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(s.toggleActiveFailure!.message),
                  backgroundColor: AppColors.redAccent,
                ),
              );
            }
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          error: (e) => Center(child: Text(e.failure.message)),
          success: (s) => _buildContent(context, s),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, dynamic state) {
    final laws = state.laws;
    final total = state.totalLaws;
    final active = state.activeLaws;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // --- Responsive grid config ---
        final int crossAxisCount;
        final double childAspectRatio;
        final double crossAxisSpacing;
        final double mainAxisSpacing;
        final double horizontalPadding;

        if (width < 600) {
          // Mobile
          crossAxisCount = 1;
          childAspectRatio = 1.1;
          crossAxisSpacing = 0;
          mainAxisSpacing = 16;
          horizontalPadding = 16;
        } else if (width < 900) {
          // Tablet
          crossAxisCount = 2;
          childAspectRatio = 1.1;
          crossAxisSpacing = 24;
          mainAxisSpacing = 20;
          horizontalPadding = 24;
        } else if (width < 1400) {
          // Desktop
          crossAxisCount = 3;
          childAspectRatio = 1.1;
          crossAxisSpacing = 32;
          mainAxisSpacing = 24;
          horizontalPadding = 32;
        } else {
          // Wide desktop
          crossAxisCount = 4;
          childAspectRatio = 1.2;
          crossAxisSpacing = 40;
          mainAxisSpacing = 24;
          horizontalPadding = 40;
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildHeader(context, total, active, width),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  childAspectRatio: childAspectRatio,
                ),
                itemCount: laws.length,
                itemBuilder: (context, index) {
                  final law = laws[index];
                  final colors = [
                    const Color(0xFF114AC0),
                    const Color(0xFFFF9800),
                    const Color(0xFFF44336),
                    const Color(0xFF4CAF50),
                  ];
                  final color = colors[index % colors.length];

                  return QuestionLawCard(
                    law: law,
                    accentColor: color,
                    onToggleActive: (val) {
                      context
                          .read<QuestionsManagementCubit>()
                          .toggleActiveStatus(law.id, val);
                    },
                    onAddQuestions: () => onAddQuestions(law),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    int total,
    int active,
    double width,
  ) {
    final isMobile = width < 600;

    final titleRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'إدارة الأسئلة',
          style: AppTextStyles.font20BoldBlack.copyWith(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 16 : 20,
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          Icons.quiz_outlined,
          color: AppColors.primary,
          size: isMobile ? 22 : 28,
        ),
      ],
    );

    final badgesRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildBadge(
          'الكل: $total',
          Colors.blue.withAlpha(30),
          AppColors.primary,
        ),
        const SizedBox(width: 8),
        _buildBadge('نشط: $active', Colors.green.withAlpha(30), Colors.green),
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [titleRow, const SizedBox(height: 10), badgesRow],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [titleRow, badgesRow],
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
