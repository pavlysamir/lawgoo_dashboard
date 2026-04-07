import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SaveQuestionsPopup extends StatelessWidget {
  const SaveQuestionsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: Colors.green, size: 48),
            ),
            const SizedBox(height: 24),
            Text(
              'تم حفظ التعديلات بنجاح',
              style: AppTextStyles.font20BoldBlack.copyWith(fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 12),
            const Text(
              'تم تحديث بياناتك بنجاح في النظام ويمكنك الآن الاستمرار في العمل.',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Cairo', color: AppColors.grey600, fontSize: 13),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey100, style: BorderStyle.solid),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_done_outlined, color: AppColors.grey400, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'مزامنة البيانات مكتملة',
                    style: TextStyle(fontFamily: 'Cairo', color: AppColors.grey400, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'إغلاق',
                  style: TextStyle(fontFamily: 'Cairo', color: AppColors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
