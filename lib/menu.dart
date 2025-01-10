import 'package:flutter/material.dart';
import 'package:doan_hk2/api_service.dart';

Widget buildMenu() {
  final LoginService _loginService = LoginService();
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: FutureBuilder<List<String>>(
      future: _loginService.fetchCategories(),  // Lấy dữ liệu từ API
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có danh mục nào.'));
        } else {
          final categories = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Menu",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const Divider(color: Colors.green),
              for (var category in categories)
                buildMenuItem(category),
            ],
          );
        }
      },
    ),
  );
}

Widget buildMenuItem(String title) {
  return InkWell(
    onTap: () {
      // Xử lý sự kiện khi chọn item menu
      print("Bạn chọn $title");
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
    ),
  );
}