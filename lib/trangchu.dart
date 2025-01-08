import 'dart:async';

import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'danhsachtraicay.dart';

class Trangchu extends StatefulWidget {
  const Trangchu({super.key});

  @override
  State<Trangchu> createState() => _TrangchuState();
}

class _TrangchuState extends State<Trangchu> {

  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }


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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              height: 200,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  Image.asset('assets/tải xuống.jpg', fit: BoxFit.cover),
                  Image.asset('assets/tải xuống (3).jpg', fit: BoxFit.cover),
                  Image.asset('assets/tải xuống (1).jpg', fit: BoxFit.cover),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Xử lý lọc
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Lọc"),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý sắp xếp
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Sắp xếp"),
                ),
              ],
            ),
            SizedBox(height: 16),
            ProductList(),
          ],
        ),
      ),
      
      backgroundColor: Colors.white,
    );
  }
}