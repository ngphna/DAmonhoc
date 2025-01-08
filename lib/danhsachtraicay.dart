import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    name: product['name']!,
                    price: product['price']!,
                    image: product['image']!,
                  ),
                ),
              );
            },
            child: Card(
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
            ),
          );
        },
      ),
    );
  }
}

class ProductDetail extends StatefulWidget {
  final String name;
  final String price;
  final String image;

  const ProductDetail({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isAddedToCart = false; // Biến trạng thái để kiểm tra sản phẩm đã được thêm vào giỏ hàng

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Trangchu(),
              ),
            );
          },
          child: const Text(
            "Fruit Paradise",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        actions: [
          
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.white),
            onSelected: (value) {
              // Xử lý khi chọn menu
              if (value == "Dangxuat") {
                Navigator.of(context, rootNavigator: true).pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) => DangNhap(),
                );
              } else if (value == "Thongtin") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Thongtincanhan(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: "Dangxuat",
                child: Text("Đăng xuất"),
              ),
              const PopupMenuItem(
                value: "Thongtin",
                child: Text("Thông tin cá nhân"),
              ),
            ],
          ),
        ], // Truy cập thông tin từ widget
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.image,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Giá: ${widget.price}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isAddedToCart = true; // Cập nhật trạng thái
                });

                // Hiển thị thông báo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Đã thêm ${widget.name} vào giỏ hàng!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isAddedToCart ? Colors.grey : Colors.orange, // Thay đổi màu khi đã thêm
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: Text(
                isAddedToCart ? "Đã thêm" : "Thêm vào giỏ hàng",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}