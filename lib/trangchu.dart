import 'dart:async';
import 'package:doan_hk2/TrangTimKiem.dart';
import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/view/DanhSachDonHang.dart';
import 'package:flutter/material.dart';
import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/menu.dart';
import 'danhsachtraicay.dart';
import 'itemthanhtoan.dart';
import 'giothieu.dart';
import 'khuyenmai.dart';
import 'product_item_model.dart';

class Trangchu extends StatefulWidget {
  const Trangchu({super.key});

  @override
  State<Trangchu> createState() => _TrangchuState();
}

class _TrangchuState extends State<Trangchu> {
  final TextEditingController tk_sp = TextEditingController();
  LoginService cartService = LoginService();
  String? username;

  List<ProductItemModel> productsInCart = [];
  List<String> categories = []; // Danh sách các danh mục

  @override
  void initState() {
    super.initState();
    _loadCartProducts();
    _loadUsername();
    _loadCategories(); // Tải danh mục từ API
  }

  Future<void> _loadUsername() async {
    String? loadedUsername = await cartService.getUsername();
    setState(() {
      username = loadedUsername;
    });
  }

  void _loadCartProducts() async {
    try {
      List<ProductItemModel> loadedProducts =
          await cartService.fetchCartProducts();
      setState(() {
        productsInCart = loadedProducts;
      });
    } catch (e) {}
  }

  // Tải danh mục từ API
  Future<void> _loadCategories() async {
    try {
      List<String> loadedCategories = await cartService.fetchCategories();
      setState(() {
        categories = loadedCategories;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $e")),
      );
    }
  }

  // Hàm tìm kiếm sản phẩm
  void TK_SanPham() async {
    final searchQuery = tk_sp.text.trim();
    if (searchQuery.isEmpty) {
      return;
    }
    try {
      List<dynamic> searchResults = await LoginService().tkSanPham(searchQuery);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrangTimKiem(searchResults: searchResults),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lỗi: $e")));
    }
  }

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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
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
              } else if (value == "DonHang") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DanhSachDonHang(),
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
              const PopupMenuItem(
                value: "DonHang",
                child: Text("Danh sách đơn hàng của bạn"),
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
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
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
                            child: InkWell(
                                onTap: () {
                                  TK_SanPham();
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Colors.lightGreen,
                                )),
                          ),
                          Expanded(
                            child: TextField(
                              controller: tk_sp,
                              decoration: const InputDecoration(
                                hintText: 'Tìm sản phẩm',
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) {
                                TK_SanPham();
                              },
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
                child: AutoScrollCarouselView(),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: PromotionsScreen(),
              ),
              const SizedBox(height: 16),

              // Lặp qua danh sách danh mục và hiển thị sản phẩm tương ứng
              if (categories.isNotEmpty)
                for (int i = 0; i < categories.length; i++) ...[
                  Center(
                    child: Text(
                      categories[i],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: ProductList(danhMucId: i + 1), // Truyền id danh mục tương ứng
                  ),
                  const SizedBox(height: 16),
                ],
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
