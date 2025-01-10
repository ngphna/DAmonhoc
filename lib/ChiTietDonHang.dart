import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DuyetDon.dart';

class Chitietdonhang extends StatefulWidget
{
  const Chitietdonhang({super.key});

  @override
  State<StatefulWidget> createState() => ChitietdonhangState();
}
class ChitietdonhangState extends State<Chitietdonhang>
{
  List<Map<String, dynamic>> orders = [
    {"id": 1, "customer": "Nguyen Van A", "total": 500000, "status": "Pending"},
    {"id": 2, "customer": "Tran Thi B", "total": 300000, "status": "Pending"},
  ];

  void approveOrder(int id) {
    setState(() {
      orders = orders.map((order) {
        if (order['id'] == id) {
          order['status'] = "Approved";
        }
        return order;
      }).toList();
    });
  }

  void cancelOrder(int id) {
    setState(() {
      orders = orders.map((order) {
        if (order['id'] == id) {
          order['status'] = "Cancelled";
        }
        return order;
      }).toList();
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
                builder: (context) => DuyetDon(),
              ),
            );
          },
          child: const Text(
            "Fruit Paradise",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.green,
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
      body: const Column(
        children: [
          Text('Chi tiết đơn hàng',
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),

        ],
      ),
    );
  }
}