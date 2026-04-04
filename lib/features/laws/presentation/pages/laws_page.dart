import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../bloc/laws_cubit.dart';
import '../bloc/laws_state.dart';
import '../widgets/law_card.dart';
import '../widgets/add_law_section.dart';

class LawsPage extends StatelessWidget {
  const LawsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LawsCubit, LawsState>(
      listener: (context, state) {
        state.maybeMap(
          success: (s) {
            if (s.addLawFailure != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(s.addLawFailure!.message),
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
        print('LawsPage width: $width'); // Debugging line

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
                itemCount: laws.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildAddLawCard(context);
                  }
                  final law = laws[index - 1];
                  final colors = [
                    const Color(0xFF114AC0),
                    const Color(0xFFFF9800),
                    const Color(0xFFF44336),
                    const Color(0xFF4CAF50),
                  ];
                  final color = colors[(index - 1) % colors.length];

                  return LawCard(
                    law: law,
                    accentColor: color,
                    onDelete: () {},
                    onAddMaterials: () {},
                  );
                },
              ),
              if (state.showAddForm) ...[
                const SizedBox(height: 48),
                AddLawSection(
                  isLoading: state.isAddingLaw,
                  onSave: (name, levels) {
                    context.read<LawsCubit>().addNewLaw(name, levels);
                  },
                ),
              ],
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
          'القوانين الحالية',
          style: AppTextStyles.font20BoldBlack.copyWith(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 16 : 20,
          ),
        ),
        const SizedBox(width: 12),
        Icon(Icons.balance, color: AppColors.primary, size: isMobile ? 22 : 28),
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
      children: [badgesRow, titleRow],
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

  Widget _buildAddLawCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<LawsCubit>().toggleAddForm(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withAlpha(20), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Scale icon and text based on available card height
            final cardHeight = constraints.maxHeight;
            final isCompact = cardHeight < 140;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(isCompact ? 10 : 14),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.note_add_outlined,
                    size: isCompact ? 28 : 38,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: isCompact ? 8 : 14),
                Text(
                  'إضافة قانون جديد',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: isCompact ? 13 : 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isCompact ? 6 : 10),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isCompact ? 14 : 20,
                    vertical: isCompact ? 6 : 9,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha(50),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'ابدأ الآن',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isCompact ? 11 : 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
