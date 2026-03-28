import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/assets/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class TopBar extends StatelessWidget {
  final String adminName;
  final VoidCallback onLogout;

  const TopBar({super.key, required this.adminName, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                adminName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SvgPicture.asset(AppAssets.logoIcon, width: 40),

          Row(
            children: [
              IconButton(
                onPressed: onLogout,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                  size: 20,
                ),
              ),
              const Text(
                'تسجيل الخروج',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontFamily: 'Cairo',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
