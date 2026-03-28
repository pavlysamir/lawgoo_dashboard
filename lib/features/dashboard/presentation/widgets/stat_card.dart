import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String count;
  final String icon;
  final String? badgeText;
  final Color? badgeColor;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? highlightColor;

  const StatCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
    this.highlightColor,
    this.badgeText,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 180,
        height: 180,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? (highlightColor ?? AppColors.primary)
              : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: isSelected ? null : Border.all(color: Colors.grey.shade100),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (highlightColor ?? AppColors.primary).withAlpha(30),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (badgeText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withAlpha(50)
                          : (badgeColor ?? Colors.green.withAlpha(30)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badgeText!,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withAlpha(30)
                        : Colors.grey.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    icon,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      isSelected ? Colors.white : Colors.black87,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white70 : Colors.grey,
                fontSize: 12,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
