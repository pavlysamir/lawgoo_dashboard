import 'package:flutter/material.dart';

class DashboardSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const DashboardSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        textAlign: TextAlign.right,
        onChanged: onSearch,
        decoration: const InputDecoration(
          hintText: 'ابحث عن مستخدم بالاسم، البريد أو المعرف...',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Cairo',
            fontSize: 14,
          ),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }
}
