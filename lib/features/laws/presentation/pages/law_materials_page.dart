import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/law_entity.dart';
import '../bloc/law_materials_cubit.dart';
import '../bloc/law_materials_state.dart';
import '../widgets/add_law_material_form.dart';
import '../widgets/law_material_item.dart';
import '../widgets/law_material_pagination.dart';

class LawMaterialsPage extends StatelessWidget {
  final LawEntity law;
  final VoidCallback onBack;

  const LawMaterialsPage({super.key, required this.law, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LawMaterialsCubit>()..init(law.id),
      child: BlocConsumer<LawMaterialsCubit, LawMaterialsState>(
        listener: (context, state) {
          state.maybeMap(
            success: (s) {
              if (s.operationFailure != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(s.operationFailure!.message),
                    backgroundColor: AppColors.redAccent,
                  ),
                );
              }
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Header with Back Button
              _buildHeader(context),
              const SizedBox(height: 24),
              // Content
              Expanded(
                child: state.map(
                  initial: (_) => const SizedBox.shrink(),
                  loading: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e) => Center(child: Text(e.failure.message)),
                  success: (s) => _buildContent(context, s),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Total count badge (optional, based on design)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'الكل: ${law.materialsCount}',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: 'Cairo',
            ),
          ),
        ),
        // Title and Back Icon
        Row(
          children: [
            Text(
              law.name,
              style: AppTextStyles.font20BoldBlack.copyWith(
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_forward_ios, size: 20),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, dynamic state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Form Section
          AddLawMaterialForm(
            lawId: law.id,
            editingMaterial: state.editingMaterial,
          ),
          const SizedBox(height: 40),
          // Archive Title & Search
          _buildSearchSection(context, state.searchQuery),
          const SizedBox(height: 24),
          // Materials List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.materials.length,
            itemBuilder: (context, index) {
              final material = state.materials[index];
              return LawMaterialItem(
                material: material,
                onEdit: () => context
                    .read<LawMaterialsCubit>()
                    .setEditingMaterial(material),
                onDelete: () => _showDeleteDialog(context, material),
              );
            },
          ),
          if (state.materials.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'لا توجد مواد قانونية حالياً',
                  style: TextStyle(color: Colors.grey, fontFamily: 'Cairo'),
                ),
              ),
            ),
          const SizedBox(height: 24),
          // Pagination
          LawMaterialPagination(
            currentPage: state.currentPage,
            totalItems: state.totalMaterials,
            itemsPerPage: state.itemsPerPage,
            onPageChanged: (page) =>
                context.read<LawMaterialsCubit>().changePage(page),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSearchSection(BuildContext context, String? query) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title
        Row(
          children: [
            Text(
              'الأرشيف القانوني',
              style: AppTextStyles.font18BoldBlack.copyWith(
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        // Search bar
        SizedBox(
          width: 300,
          child: TextField(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            onChanged: (q) => context.read<LawMaterialsCubit>().search(q),
            decoration: InputDecoration(
              hintText: 'ابحث عن اسم المادة أو رقمها',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontFamily: 'Cairo',
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 20,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, dynamic material) {
    final cubit = context.read<LawMaterialsCubit>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'حذف المادة',
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: Text(
          'هل أنت متأكد من حذف المادة رقم ${material.order}؟',
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          TextButton(
            onPressed: () {
              cubit.deleteMaterialById(material.id);
              Navigator.pop(context);
            },
            child: const Text(
              'حذف',
              style: TextStyle(color: Colors.red, fontFamily: 'Cairo'),
            ),
          ),
        ],
      ),
    );
  }
}
