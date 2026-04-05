import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class LawMaterialPagination extends StatelessWidget {
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;
  final Function(int) onPageChanged;

  const LawMaterialPagination({
    super.key,
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final int totalPages = (totalItems / itemsPerPage).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Page Info
        Text(
          'عرض $itemsPerPage مواد من إجمالي $totalItems',
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Cairo',
            fontSize: 12,
          ),
        ),
        // Page Buttons
        Row(
          children: [
            IconButton(
              onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
              icon: const Icon(Icons.chevron_left, size: 20),
            ),
            ..._buildPageNumbers(totalPages),
            IconButton(
              onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
              icon: const Icon(Icons.chevron_right, size: 20),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildPageNumbers(int totalPages) {
    List<Widget> buttons = [];
    
    // Simplified logic: show 1, 2, 3, ..., last
    for (int i = 1; i <= totalPages; i++) {
      if (i <= 3 || i == totalPages) {
        buttons.add(_buildPageButton(i));
      } else if (i == 4) {
        buttons.add(const Text('...', style: TextStyle(color: Colors.grey)));
      }
    }
    
    return buttons;
  }

  Widget _buildPageButton(int page) {
    bool isSelected = page == currentPage;
    return GestureDetector(
      onTap: () => onPageChanged(page),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Text(
          page.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontFamily: 'Cairo',
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
