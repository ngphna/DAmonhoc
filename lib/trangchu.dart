import 'dart:async';
import 'package:flutter/material.dart';
import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/menu.dart';
import 'danhsachtraicay.dart';
import 'nutmau.dart';
import 'itemthanhtoan.dart';

class Trangchu extends StatefulWidget {
  Trangchu({super.key});

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
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _currentPage = (_currentPage + 1) % 3;
      });
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

  Widget _buildIconButton(Icon icon, VoidCallback onPressed) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
    );
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
          PopupMenuButton<String>(
            icon: Icon(Icons.settings, color: Colors.white),
            onSelected: (value) {
              if (value == "Dangxuat") {
                Navigator.of(context, rootNavigator: true).pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
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
              PopupMenuItem(
                value: "Dangxuat",
                child: Text("Đăng xuất"),
              ),
              PopupMenuItem(
                value: "Thongtin",
                child: Text("Thông tin cá nhân"),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView( // Bao toàn bộ body trong SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Stack(children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.lightGreen),
                    onPressed: () {
                        showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) => buildMenu(),
                    );
                      // Hành động khi nhấn menu
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
                        icon: Icon(Icons.shopping_cart_outlined,
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
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${productsInCart.fold(0, (sum, item) => sum + (item.quantity))}',
                            style: TextStyle(
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
             ],),
              
              SizedBox(height: 5,),
              Container(
                height: 200,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    Image.asset('assets/tải xuống.jpg', fit: BoxFit.fill),
                    Image.asset('assets/tải xuống (3).jpg', fit: BoxFit.fill),
                    Image.asset('assets/tải xuống (1).jpg', fit: BoxFit.fill),
                  ],
                ),
              ),
              SizedBox(height: 10),
              
              Container(
                height: 300,  // Ensure the list has a height
                child: ProductList(),
              ),
               SizedBox(height: 10),
              
              Container(child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
Text("Thế API",
style: TextStyle(fontSize: 20,color: Colors.orange,),

)

              
            ],),),
              
              Container(
                height: 300,  // Ensure the list has a height
                child: ProductList(),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
