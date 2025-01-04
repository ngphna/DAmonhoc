import 'package:flutter/material.dart';

Widget buildMenu() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Menu",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        Divider(color: Colors.green),
        buildMenuItem("Trái cây Việt Nam"),
        buildMenuItem("Trái cây nhập khẩu"),
        buildMenuItem("Trái cây Thái Lan"),
        buildMenuItem("Mâm ngũ quả"),
        buildMenuItem("Giỏ quà Tết"),
      ],
    ),
  );
}

Widget buildMenuItem(String title) {
  return InkWell(
    onTap: () {
      // Xử lý sự kiện khi chọn item menu
      print("Bạn chọn $title");
      //Navigator.pop(context);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    ),
  );
}
