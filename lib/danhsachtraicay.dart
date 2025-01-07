import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<Map<String, String>> products = [
    {'name': 'Cam siêu ngọt', 'price': '130.000 đ', 'image': 'assets/tải xuống.jpg'},
    {'name': 'Táo', 'price': '30.000 đ', 'image': 'assets/tải xuống (3).jpg'},
    {'name': 'Nho', 'price': '200.000 đ', 'image': 'assets/tải xuống (1).jpg'},
    {'name': 'Xoài thái', 'price': '25.000 đ', 'image': 'assets/tải xuống (2).jpg'},
    {'name': 'Sầu riêng', 'price': '100.000 đ', 'image': 'assets/tải xuống (5).jpg'},
    {'name': 'Ổi ruột hồng', 'price': '35.000 đ', 'image': 'assets/tải xuống (4).jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Số cột
          crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
          mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
          childAspectRatio: 0.75, // Tỉ lệ chiều cao/chiều rộng
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 4,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                    child: Image.asset(
                      product['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['name']!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  product['price']!,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
