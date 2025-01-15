import 'dart:async';
import 'package:doan_hk2/TrangTimKiem.dart';
import 'package:doan_hk2/api_service.dart';
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
  //Tìm kiếm sản phẩm
   LoginService cartService = LoginService();
  String? username;
  final TextEditingController tk_sp = TextEditingController();
   List<ProductItemModel> productsInCart = [];

  @override
  void initState() {
    super.initState();
    _loadCartProducts();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    // Lấy tên đăng nhập
    String? loadedUsername = await cartService.getUsername();
    setState(() {
      username = loadedUsername; // Cập nhật lại state với tên đăng nhập
    });
  }

  void _loadCartProducts() async {
    try {
      List<ProductItemModel> loadedProducts = await cartService.fetchCartProducts();
      setState(() {
        productsInCart = loadedProducts;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Lỗi khi tải giỏ hàng: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  // Hàm tìm kiếm sản phẩm

  //Hàm tìm kiếm sản phẩm
  void TK_SanPham() async {
  final searchQuery = tk_sp.text.trim();
  
  if (searchQuery.isEmpty) {
    // Nếu không có từ khóa tìm kiếm
    return;
  }

  try {
    // Gọi API để tìm kiếm sản phẩm theo tên
    List<dynamic> searchResults = await LoginService().tkSanPham(searchQuery);

    // Chuyển đến trang tìm kiếm kết quả
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TrangTimKiem(searchResults: searchResults),
      ),
    );
  } catch (e) {
    // Xử lý lỗi nếu không tìm thấy hoặc có vấn đề khi gọi API
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
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.search, color: Colors.lightGreen),
                    ),
                    Expanded(
                      child: TextField(
                        controller: tk_sp,
                        decoration: const InputDecoration(
                          hintText: 'Tìm sản phẩm',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) {
                          TK_SanPham(); // Gọi hàm tìm kiếm khi nhấn Enter
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
        SizedBox(height: 120,child: PromotionsScreen() ,),
       
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

