import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../laws/domain/entities/law_entity.dart';

class AddQuestionsPage extends StatelessWidget {
  final LawEntity law;
  final VoidCallback onBack;

  const AddQuestionsPage({super.key, required this.law, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(height: 24),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_task_outlined,
                size: 80,
                color: AppColors.primary.withAlpha(50),
              ),
              const SizedBox(height: 24),
              Text(
                'إضافة أسئلة جديدة',
                style: AppTextStyles.font20BoldBlack.copyWith(
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'سيتم توفير واجهة إضافة الأسئلة قريباً بناءً على التصميم الجديد.',
                style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
