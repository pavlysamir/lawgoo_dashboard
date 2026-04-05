import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/law_material_entity.dart';

class LawMaterialItem extends StatelessWidget {
  final LawMaterialEntity material;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LawMaterialItem({
    super.key,
    required this.material,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  material.order.toString(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  'مادة',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),

          // Material Text
          Expanded(
            flex: 8,
            child: Text(
              material.content,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font14Regular.copyWith(fontFamily: 'Cairo'),
            ),
          ),

          const Spacer(),

          // Actions
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: AppColors.redAccent),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_note, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
