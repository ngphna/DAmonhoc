import 'dart:ffi';

import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class ProductList extends StatefulWidget {
  final int danhMucId; // Thêm tham số danhMucId vào constructor

  const ProductList({super.key, required this.danhMucId}); // Nhận danhMucId từ constructor

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<dynamic> products = [];
  bool isLoading = true;
  final loginService = LoginService();

  @override
  void initState() {
    super.initState();
    // Gọi phương thức fetchProducts và truyền vào danhMucId từ widget
    fetchProducts(widget.danhMucId);
  }

  Future<void> fetchProducts(int danhMucId) async {
    try {
      final fetchedProducts = await loginService.fetchProducts(danhMucId);

      setState(() {
        products = fetchedProducts.isNotEmpty ? fetchedProducts : [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi tải dữ liệu: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (products.isEmpty) {
      return const Center(child: Text("Không có sản phẩm nào!"));
    }

    return 
    
    Expanded(
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
                    name: product['TenSanPham'],
                    
                    price: product['Gia'],
                    image: product['Image'],
                    status: product['TrangThai'] ?? 'Còn hàng',
                    mota: product['MoTa'] ?? 'Không có mô tả',
                    soluong: product['SoLuong'] ?? '1',
                  ),
                ),
              );
            },
            child:
            
            
             Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                      child: Image.asset(

                        product['Image']!,

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(

                      product['TenSanPham']!,
                      style: TextStyle(fontWeight: FontWeight.bold),

                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(

                    product['Gia']!.toString(),
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
  final int price;
  final String image;
  final String status;
  final String mota;
  final int soluong;
  

  const ProductDetail({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.status,
    required this.mota,
    required this.soluong,

  });

  @override
  _ProductDetailState createState() => _ProductDetailState();
}
class _ProductDetailState extends State<ProductDetail> {
  bool isAddedToCart = false; // Biến trạng thái để kiểm tra sản phẩm đã được thêm vào giỏ hàng
  late int currentQuantity; // Số lượng hiện tại
  late int totalPrice; // Tổng giá trị

  @override
  void initState() {
    super.initState();
    // Khởi tạo số lượng và giá ban đầu
    currentQuantity = widget.soluong;
    totalPrice = widget.price * currentQuantity;
  }

  void _updateQuantity(bool isIncrement) {
    setState(() {
      // Nếu là tăng và số lượng > 0
      if (isIncrement) {
        currentQuantity++;
      } else {
        // Nếu là giảm nhưng số lượng phải lớn hơn 1
        if (currentQuantity > 1) {
          currentQuantity--;
        }
      }
      // Cập nhật giá tổng khi số lượng thay đổi
      totalPrice = widget.price * currentQuantity;
    });
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 20),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Giá mỗi sản phẩm: ${widget.price}",
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 20),
              Text(
                "Trạng thái: ${widget.status}",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Số lượng:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => _updateQuantity(false), // Giảm số lượng
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            '$currentQuantity', // Hiển thị số lượng hiện tại
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () => _updateQuantity(true), // Tăng số lượng
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Tổng giá: $totalPrice", // Hiển thị giá tổng
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAddedToCart = true;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Đã thêm ${widget.name} vào giỏ hàng!"),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isAddedToCart ? Colors.grey : Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text(
                  isAddedToCart ? "Đã thêm" : "Thêm vào giỏ hàng",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.mota,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}