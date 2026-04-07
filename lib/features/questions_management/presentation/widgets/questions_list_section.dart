import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../domain/entities/question.dart';
import 'custom_switcher.dart';

class QuestionsListSection extends StatelessWidget {
  final List<Question> questions;
  final Function(String, bool) onToggleStatus;
  final Function(String) onDelete;
  final Function(Question) onEdit;
  final Function(String) onSearch;

  const QuestionsListSection({
    super.key,
    required this.questions,
    required this.onToggleStatus,
    required this.onDelete,
    required this.onEdit,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('قائمة الاسئلة الحالية', style: AppTextStyles.font18BoldBlack),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.grey50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.grey200),
                  ),
                  child: TextField(
                    onChanged: onSearch,
                    decoration: const InputDecoration(
                      hintText: 'ابحث عن نص السؤال',
                      hintStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.grey400),
                      icon: Icon(Icons.search, size: 20, color: AppColors.grey400),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          DataTable(
            horizontalMargin: 0,
            columnSpacing: 24,
            columns: const [
              DataColumn(label: Text('حالة السؤال', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
              DataColumn(label: Text('نص السؤال', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
              DataColumn(label: Text('الصعوبة', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
              DataColumn(label: Text('النوع', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
              DataColumn(label: Text('إجراءات', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold))),
            ],
            rows: questions.map((q) {
              return DataRow(
                cells: [
                  DataCell(
                    CustomSwitcher(
                      value: q.isActive,
                      onChanged: (val) => onToggleStatus(q.questionId!, val),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 300,
                      child: Text(
                        q.questionText,
                        style: const TextStyle(fontFamily: 'Cairo', fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(_buildDifficultyChip(q.difficulty)),
                  DataCell(_buildTypeChip(q.type)),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => onEdit(q),
                          icon: const Icon(Icons.edit_outlined, color: AppColors.grey600, size: 20),
                        ),
                        IconButton(
                          onPressed: () => onDelete(q.questionId!),
                          icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    Color color;
    String text;
    if (difficulty == 'easy') {
      color = Colors.green;
      text = 'سهل';
    } else if (difficulty == 'medium') {
      color = Colors.orange;
      text = 'متوسط';
    } else {
      color = Colors.red;
      text = 'صعب';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontFamily: 'Cairo', fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type == 'mcq' ? 'مقالي' : type == 'case' ? 'قضية' : 'آخر',
        style: const TextStyle(color: AppColors.grey600, fontFamily: 'Cairo', fontSize: 12),
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'عرض 4 مواد من إجمالي 45',
          style: TextStyle(fontFamily: 'Cairo', color: AppColors.grey500, fontSize: 12),
        ),
        Row(
          children: [
            _buildPageArrow(Icons.arrow_back_ios, isEnabled: false),
            _buildPageNumber(1, isSelected: true),
            _buildPageNumber(2),
            _buildPageNumber(3),
            const Text('...', style: TextStyle(color: Colors.grey)),
            _buildPageNumber(9),
            _buildPageArrow(Icons.arrow_forward_ios, isEnabled: true),
          ],
        ),
      ],
    );
  }

  Widget _buildPageNumber(int page, {bool isSelected = false}) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          page.toString(),
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.grey600,
            fontFamily: 'Cairo',
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildPageArrow(IconData icon, {required bool isEnabled}) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.grey200),
      ),
      child: Icon(icon, size: 12, color: isEnabled ? AppColors.grey600 : AppColors.grey200),
    );
  }
}
