import 'dart:async';

import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'danhsachtraicay.dart';
import 'itemthanhtoan.dart';

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
                            padding:
                                EdgeInsets.symmetric(horizontal: 12.0),
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
                        icon: const Icon(Icons.shopping_cart_outlined,
                            color: Colors.lightGreen),
                        onPressed: () {
                           Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Giohang(),
                          ),
                        );
                          // Hành động khi nhấn giỏ hàng
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
            const SizedBox(height: 10,),
            SizedBox(
              height: 200,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index){
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  Image.asset('assets/XoaiXanh.jpg', fit: BoxFit.cover),
                  Image.asset('assets/OiHong.jpg', fit: BoxFit.cover),
                  Image.asset('assets/Tao.jpg', fit: BoxFit.cover),
                ],
              ),
            ),
            const SizedBox(height: 10,),
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
                  child: const Text("Lọc"),
                ),
                const SizedBox(width: 8),
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
                  child: const Text("Sắp xếp"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ProductList(),
          ],
        ),
      ),
      
      backgroundColor: Colors.white,
    );
  }
}