import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lowgos_dashboard/core/utils/app_colors.dart';
import 'package:lowgos_dashboard/core/utils/app_text_styles.dart';
import '../bloc/settings_cubit.dart';
import '../../../dashboard/domain/entities/user_entity.dart';

class AdminListTable extends StatelessWidget {
  final List<UserEntity> admins;

  const AdminListTable({super.key, required this.admins});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                  const Icon(Icons.people_outline, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'قائمة المسؤولين الحاليين',
                    style: AppTextStyles.font18BoldBlack.copyWith(
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              // Search bar placeholder as seen in UI
              SizedBox(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'البحث عن مسؤول...',
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Cairo',
                    ),
                    prefixIcon: const Icon(Icons.search, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.grey200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.grey200),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: const BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Text('المسؤول', style: _HeaderStyle()),
                ),
                Expanded(flex: 2, child: Text('الحالة', style: _HeaderStyle())),
                Expanded(
                  flex: 1,
                  child: Text('الإجراءات', style: _HeaderStyle()),
                ),
              ],
            ),
          ),
          // Table Body
          admins.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Center(
                    child: Text(
                      'لا يوجد مسؤولين حالياً',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: admins.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final admin = admins[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          // Admin Info
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  admin.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                Text(
                                  admin.email,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Status
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: admin.isActive
                                        ? Colors.green.withOpacity(0.1)
                                        : Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: admin.isActive
                                              ? Colors.green
                                              : Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        admin.isActive ? 'نشط' : 'غير نشط',
                                        style: TextStyle(
                                          color: admin.isActive
                                              ? Colors.green
                                              : Colors.grey[700],
                                          fontSize: 12,
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Actions
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<SettingsCubit>()
                                        .toggleAdminStatus(
                                          admin.id,
                                          !admin.isActive,
                                        );
                                  },
                                  icon: const Icon(Icons.edit_note, size: 20),
                                  color: Colors.grey[600],
                                ),
                                IconButton(
                                  onPressed: () {
                                    _showDeleteDialog(context, admin);
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 20,
                                  ),
                                  color: AppColors.redAccent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, UserEntity admin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف مسؤول', style: TextStyle(fontFamily: 'Cairo')),
        content: Text(
          'هل أنت متأكد من حذف ${admin.name}؟',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Use the context of the calling widget
              FocusScope.of(
                context,
              ).unfocus(); // Example of potential context issue
              // The cubit should be accessed from the parent context
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

class _HeaderStyle extends TextStyle {
  const _HeaderStyle()
    : super(
        color: Colors.grey,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: 'Cairo',
      );
}
