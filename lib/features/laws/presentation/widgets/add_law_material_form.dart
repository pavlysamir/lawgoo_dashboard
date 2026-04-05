import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/law_material_entity.dart';
import '../bloc/law_materials_cubit.dart';
import '../bloc/law_materials_state.dart';

class AddLawMaterialForm extends StatefulWidget {
  final String lawId;
  final LawMaterialEntity? editingMaterial;

  const AddLawMaterialForm({
    super.key,
    required this.lawId,
    this.editingMaterial,
  });

  @override
  State<AddLawMaterialForm> createState() => _AddLawMaterialFormState();
}

class _AddLawMaterialFormState extends State<AddLawMaterialForm> {
  late final TextEditingController _contentController;
  late final TextEditingController _orderController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.editingMaterial?.content ?? '');
    _orderController = TextEditingController(text: widget.editingMaterial?.order.toString() ?? '');
  }

  @override
  void didUpdateWidget(covariant AddLawMaterialForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.editingMaterial != oldWidget.editingMaterial) {
      _contentController.text = widget.editingMaterial?.content ?? '';
      _orderController.text = widget.editingMaterial?.order.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              const Icon(Icons.description_outlined, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'المواد القانونية',
                style: AppTextStyles.font16SemiBoldBlack.copyWith(fontFamily: 'Cairo'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Field
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'رقم المادة',
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _orderController,
                      hintText: 'مثال: 1',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Content Field
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'نص المادة',
                      style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _contentController,
                      hintText: 'أدخل نص المادة القانونية هنا بالتفصيل...',
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Submit Button
          BlocBuilder<LawMaterialsCubit, LawMaterialsState>(
            builder: (context, state) {
              final isSubmitting = state.maybeMap(
                success: (s) => s.isAddingMaterial || s.isUpdatingMaterial,
                orElse: () => false,
              );

              return ElevatedButton.icon(
                onPressed: isSubmitting ? null : _handleSubmit,
                icon: isSubmitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Icon(widget.editingMaterial != null ? Icons.save_outlined : Icons.add, size: 18),
                label: Text(
                  widget.editingMaterial != null ? 'تعديل المادة' : 'إضافة مادة',
                  style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      style: const TextStyle(fontFamily: 'Cairo', fontSize: 13),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: AppColors.grey50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary.withAlpha(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary.withAlpha(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  void _handleSubmit() {
    final content = _contentController.text.trim();
    final orderStr = _orderController.text.trim();
    final order = int.tryParse(orderStr);

    if (content.isEmpty || order == null) return;

    if (widget.editingMaterial != null) {
      context.read<LawMaterialsCubit>().updateExistingMaterial(content, order);
    } else {
      context.read<LawMaterialsCubit>().addNewMaterial(content, order);
    }
  }
}
