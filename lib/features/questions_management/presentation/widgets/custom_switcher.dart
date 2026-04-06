import 'package:flutter/material.dart';
import 'package:lowgos_dashboard/core/utils/app_colors.dart';

class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 35,
        height: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: value ? AppColors.primary : AppColors.white,
          border: Border.all(
            color: value ? AppColors.primary : AppColors.grey200,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              left: value ? 16 : 2,
              right: value ? 2 : 16,
              top: 2,
              bottom: 2,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: value ? AppColors.white : AppColors.grey200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
