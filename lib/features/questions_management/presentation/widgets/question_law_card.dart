import 'package:flutter/material.dart';
import 'package:lowgos_dashboard/features/questions_management/presentation/widgets/custom_switcher.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../laws/domain/entities/law_entity.dart';

class QuestionLawCard extends StatelessWidget {
  final LawEntity law;
  final Color accentColor;
  final Function(bool) onToggleActive;
  final VoidCallback onAddQuestions;

  const QuestionLawCard({
    super.key,
    required this.law,
    required this.accentColor,
    required this.onToggleActive,
    required this.onAddQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(right: BorderSide(color: accentColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.description_outlined,
                  color: accentColor,
                  size: 20,
                ),
              ),
              Row(
                children: [
                  CustomSwitcher(
                    value: law.isActive,
                    onChanged: onToggleActive,
                  ),
                  // Switch(
                  //   value: law.isActive,
                  //   onChanged: onToggleActive,
                  //   activeColor: AppColors.primary,
                  //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // ),
                  const SizedBox(width: 8),

                  const Icon(
                    Icons.delete_outline,
                    color: Colors.grey,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            law.name,
            style: AppTextStyles.font18BoldBlack.copyWith(fontFamily: 'Cairo'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'تاريخ الإضافة: ${law.createdAt.day}/${law.createdAt.month}/${law.createdAt.year}',
            style: AppTextStyles.font14Regular.copyWith(
              color: Colors.grey,
              fontFamily: 'Cairo',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مستوى الإنجاز (المستويات)',
                style: AppTextStyles.font14Regular.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  fontSize: 10,
                ),
              ),
              Text(
                '${law.completionPercentage}%',
                style: AppTextStyles.font14Regular.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: law.completionPercentage / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStat('${law.totalLevels} مستويات', Icons.layers_outlined),
              const SizedBox(width: 12),
              _buildStat(
                '${law.materialsCount} مادة',
                Icons.description_outlined,
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAddQuestions,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                elevation: 0,
              ),
              child: const Text(
                'إضافة أسئلة',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }
}
