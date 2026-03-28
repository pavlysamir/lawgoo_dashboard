import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';


class SideMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const SideMenu({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          bottomLeft: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(-5, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          _buildMenuItem(0, 'لوحة القيادة', 'assets/icons/leader_icon.svg'),
          _buildMenuItem(1, 'المستخدمون', 'assets/icons/users_icon.svg'),
          _buildMenuItem(2, 'الأسئلة', 'assets/icons/questions_icon.svg'),
          _buildMenuItem(3, 'القوانين', 'assets/icons/laws_icon.svg'),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'النظام',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Cairo',
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildMenuItem(4, 'الإعدادات', 'assets/icons/settings_icon.svg'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index, String title, String icon) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : Colors.black54,
                BlendMode.srcIn,
              ),
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}
