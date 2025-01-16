import 'package:doan_hk2/DangNhap.dart';

import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/itemdamua.dart';
import 'package:doan_hk2/ThanhToan.dart';
import 'nutmau.dart';
import 'package:flutter/material.dart';
import 'itemthanhtoan.dart';
import 'trangchu.dart';
import 'hopghichu.dart';
import 'menu.dart';
import 'TrangTimKiem.dart';
import 'api_service.dart';
import 'product_item_model.dart';

class DonhangTT extends StatefulWidget {
  const DonhangTT({super.key});

  @override
  _DonhangTTState createState() => _DonhangTTState();
}

class _DonhangTTState extends State<DonhangTT> {
  LoginService cartService = LoginService();
  String? username;

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
      List<ProductItemModel> loadedProducts =
          await cartService.fetchCartProducts();
      setState(() {
        productsInCart = loadedProducts;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết đơn hàng"),
        ),
        body: Expanded(
          child: ListView.builder(
            itemCount: productsInCart.length,
            itemBuilder: (context, index) {
              return Expanded(
                child: ProductItems(
                  product: productsInCart[index],
                ),
              );
            },
          ),
        ),
      
    );
  }
}
