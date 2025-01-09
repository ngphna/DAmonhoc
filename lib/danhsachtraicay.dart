import 'dart:ffi';

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
    {'name': 'Cam siêu ngọt', 'price': '130.000 đ', 'image': 'assets/tải xuống.jpg','status':'Còn hàng','mota':'Cam là loại trái cây có múi giàu vitamin C, vị ngọt thanh hoặc chua nhẹ, vỏ mỏng và hương thơm dịu. Cam không chỉ giúp tăng cường hệ miễn dịch mà còn hỗ trợ làm đẹp da và bổ sung năng lượng tức thì.','soluong':'1'},
    {'name': 'Táo', 'price': '30.000 đ', 'image': 'assets/tải xuống (3).jpg','status':'Còn hàng','mota':'Táo là loại trái cây phổ biến, có nhiều loại với màu sắc và hương vị khác nhau, từ ngọt đến chua. Táo giòn, thơm, và rất giàu chất xơ, vitamin C và chất chống oxy hóa.','soluong':'1'},
    {'name': 'Nho', 'price': '200.000 đ', 'image': 'assets/tải xuống (1).jpg','status':'Còn hàng','mota':' Nho là trái cây nhỏ, căng mọng với nhiều màu sắc như xanh, đỏ, tím. Vị của nho ngọt đậm hoặc ngọt nhẹ kèm chút chua, mang lại cảm giác tươi mát. Nho giàu chất chống oxy hóa và cung cấp năng lượng nhanh chóng.','soluong':'1'},
    {'name': 'Xoài thái', 'price': '25.000 đ', 'image': 'assets/tải xuống (2).jpg','status':'Còn hàng','mota':'Xoài là loại trái cây nhiệt đới được yêu thích với thịt quả mềm mịn, thơm ngọt và mọng nước. Khi chín, xoài có màu vàng rực rỡ; còn khi xanh, xoài thường chua nhẹ.','soluong':'1'},
    {'name': 'Sầu riêng', 'price': '100.000 đ', 'image': 'assets/tải xuống (5).jpg','status':'Còn hàng','mota':' Sầu riêng được mệnh danh là "vua của các loại trái cây" nhờ hương vị độc đáo. Thịt sầu riêng mềm, béo ngậy, ngọt đậm và thơm đặc trưng.','soluong':'1'},
    {'name': 'Ổi ruột hồng', 'price': '35.000 đ', 'image': 'assets/tải xuống (4).jpg','status':'Còn hàng','mota':'Ổi là loại trái cây quen thuộc với vị ngọt thanh, giòn và thơm mát. Ổi có thể có ruột trắng hoặc ruột hồng, chứa nhiều vitamin C, chất xơ, và ít calo, phù hợp cho người muốn giữ dáng.','soluong':'1'},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal, 
       
        
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
                    status: product['status']!,
                    mota: product['mota']!,
                    soluong: product['soluong']!,
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
  final String status;
  final String mota;
  final String soluong;

  const ProductDetail({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.status,
    required this.mota,
    required this.soluong,
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
            Text(
              "Trạng thái: ${widget.status}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Số lượng:',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded( // Mở rộng chiều ngang cho thanh điều chỉnh số lượng
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 10), // Thêm khoảng cách bên trái
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Phân bổ đều các phần tử
                      children: [
                        IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '1', // Hiển thị số lượng
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
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
            SizedBox(height: 20),
            Text(
              widget.mota,
              style: TextStyle(fontSize: 18,color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}