import 'dart:async';
import 'package:flutter/material.dart';
import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/menu.dart';
import 'danhsachtraicay.dart';
import 'itemthanhtoan.dart';
import 'giothieu.dart';

class Trangchu extends StatefulWidget {
  const Trangchu({super.key});

  @override
  State<Trangchu> createState() => _TrangchuState();
}

class _TrangchuState extends State<Trangchu> {
  final PageController _pageController = PageController();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Trangchu(),
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
                    builder: (context) => const Thongtincanhan(),
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
        ],
      ),
     body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.lightGreen),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) => buildMenu(),
                );
              },
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.lightGreen),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.search, color: Colors.lightGreen),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm sản phẩm',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, color: Colors.lightGreen),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Giohang(),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 0,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${productsInCart.fold(0, (sum, item) => sum + (item.quantity))}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
  height: 150,
  child:AutoScrollCarouselView(),
),

// Định nghĩa danh sách ảnh

        const SizedBox(height: 10),
        
        const SizedBox(height: 16),
         Center(child: Text(
          "Trái Cây Việt Nam",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100,color: Colors.lightGreen,),
        ),),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ProductList(danhMucId: 1),
        ),
        const SizedBox(height: 16),
        const  
        Center(child:  Text(
          "Trái Cây Nhiệt Đới",
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w100,color: Colors.lightGreen,),
        ),),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ProductList(danhMucId: 2),
        ),
        const SizedBox(height: 16),
        Center(child:  Text(
          "Trái Cây Thái Lan ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100,color: Colors.lightGreen,),
        ),),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ProductList(danhMucId: 3),
        ),
        const SizedBox(height: 16),
         Center(child: Text(
          "Trái Cây Trung Quốc",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100,color: Colors.lightGreen,),
        ),),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ProductList(danhMucId: 6),
        ),
      ],
    ),
  ),
),


      backgroundColor: Colors.white,
    );
  }
}
