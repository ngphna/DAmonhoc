import 'dart:async';

import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    _timer.cancel(); // Hủy Timer khi không cần thiết
    _pageController.dispose(); // Hủy controller để giải phóng bộ nhớ
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0; // Quay lại trang đầu tiên
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
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
          child: Text(
            "Fruit Paradise",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        actions: [
          // Thêm PopupMenuButton bên phải AppBar
          PopupMenuButton<String>(
            icon: Icon(Icons.settings, color: Colors.white),
            onSelected: (value) {
              // Xử lý khi chọn menu
              if (value == "Dangxuat") {
                Navigator.of(context, rootNavigator: true).pop();// đóng các modalbottomsheet để trách việc có nhiều modalbottomsheet mở cùng lúc
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) => DangNhap(),
                );
              } else if (value == "cart") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Giohang(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: "Dangxuat",
                child: Text("Đăng xuất"),
              ),
              PopupMenuItem(
                value: "cart",
                child: Text("Giỏ hàng"),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Thanh tìm kiếm
            Row(
              children: [
                // Icon menu bên trái
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.lightGreen),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
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
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                // Icon giỏ hàng
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart_outlined, color: Colors.lightGreen),
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
            SizedBox(height: 10,),
            Container(
              height: 150,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  Image.asset('assets/0106_hinh-nen-4k-may-tinh33.jpg', fit: BoxFit.cover),
                  Image.asset('assets/anime-girl-windows-11-4k-wallpaper-uhdpaper.com-320@2@b.jpg', fit: BoxFit.cover),
                  Image.asset('assets/anime-one-piece-monkey-d-luffy-wallpaper-preview.jpg', fit: BoxFit.cover),
                ],
              ),
            ),
            Row(
              children: [
                //Spacer(),
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
          ],
        ),
      ),
      backgroundColor: Colors.white, // Màu nền toàn bộ màn hình
    );
  }
}