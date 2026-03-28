import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class UserTable extends StatelessWidget {
  final List<UserEntity> users;
  final bool isLoading;

  const UserTable({
    super.key,
    required this.users,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _HeaderCell(text: 'العمليات', flex: 1),
                _HeaderCell(text: 'تاريخ الانضمام', flex: 2),
                _HeaderCell(text: 'عدد المستويات المكتملة', flex: 2),
                _HeaderCell(text: 'البريد الالكتروني', flex: 3),
                _HeaderCell(text: 'المستخدم', flex: 3),
              ],
            ),
          ),
          const Divider(height: 1),
          // Table Body
          if (isLoading && users.isEmpty)
            const Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Operations
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete_outline, color: Colors.grey),
                        ),
                      ),
                      // Join Date
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${user.createdAt.day} أكتوبر',
                              style: const TextStyle(fontFamily: 'Cairo', fontSize: 13),
                            ),
                            Text(
                              '${user.createdAt.year}',
                              style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      // Completed Levels
                      Expanded(
                        flex: 2,
                        child: Text(
                          user.countCompletedLevels.toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Email
                      Expanded(
                        flex: 3,
                        child: Text(
                          user.email,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ),
                      // User Info
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'ID: #USR-${user.id.substring(0, min(user.id.length, 4))}',
                                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: user.profileImage != null
                                  ? NetworkImage(user.profileImage!)
                                  : null,
                              child: user.profileImage == null
                                  ? const Icon(Icons.person)
                                  : null,
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
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final int flex;

  const _HeaderCell({required this.text, required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Cairo',
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

int min(int a, int b) => a < b ? a : b;
