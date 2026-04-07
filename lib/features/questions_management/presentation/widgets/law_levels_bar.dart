import 'package:flutter/material.dart';
import 'package:lowgos_dashboard/core/utils/app_colors.dart';

class LawLevelsBar extends StatelessWidget {
  final int totalLevels;
  final int selectedLevel;
  final Function(int) onLevelChanged;

  const LawLevelsBar({
    super.key,
    required this.totalLevels,
    required this.selectedLevel,
    required this.onLevelChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: totalLevels,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final level = index + 1;
          final isSelected = level == selectedLevel;
          return InkWell(
            onTap: () => onLevelChanged(level),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.grey200,
                ),
              ),
              child: Text(
                'المستوى ${level == 1 ? 'الأول' : level == 2 ? 'الثاني' : level == 3 ? 'الثالث' : level.toString()}',
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.grey600,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
