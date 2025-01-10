import 'package:doan_hk2/ChiTietDonHang.dart';
import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Giohang.dart';
import 'menu.dart';

class DuyetDon extends StatefulWidget
{
  const DuyetDon({super.key});

  @override
  State<StatefulWidget> createState() => DuyetDonState();
}
class DuyetDonState extends State<DuyetDon>
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
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            child: ListTile(
              title: Text("Họ và tên: ${order['customer']}"),
              subtitle: Text("Tổng: ${order['total']} VND\n Trạng thái: ${order['status']}"),
              onTap: ()=>Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Chitietdonhang(),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: order['status'] == "Chờ Duyệt"
                        ? () => approveOrder(order['id'])
                        : null,
                    child: const Text("Duyệt"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: order['status'] == "Chờ Duyệt"
                        ? () => cancelOrder(order['id'])
                        : null,
                    child: const Text("Hủy"),
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