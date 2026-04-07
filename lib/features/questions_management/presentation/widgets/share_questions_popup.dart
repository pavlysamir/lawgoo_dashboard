import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class ShareQuestionsPopup extends StatelessWidget {
  final String lawName;
  final VoidCallback onShare;

  const ShareQuestionsPopup({
    super.key,
    required this.lawName,
    required this.onShare,
  });

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
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.description_outlined, color: AppColors.primary, size: 48),
            ),
            const SizedBox(height: 24),
            Text(
              'تأكيد النشر',
              style: AppTextStyles.font20BoldBlack.copyWith(fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 12),
            const Text(
              'هل أنت متأكد من نشر هذا القانون على التطبيق؟ سيصبح متاحاً لجميع المستخدمين فوراً.',
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
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.description, color: AppColors.primary, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lawName, style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 14)),
                      const Text('آخر تعديل: منذ ساعتين', style: TextStyle(fontFamily: 'Cairo', color: AppColors.grey400, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  onShare();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.send, color: AppColors.white, size: 18),
                label: const Text(
                  'نشر الآن',
                  style: TextStyle(fontFamily: 'Cairo', color: AppColors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'إلغاء',
                  style: TextStyle(fontFamily: 'Cairo', color: AppColors.grey400, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
