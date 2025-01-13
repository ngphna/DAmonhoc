import 'package:doan_hk2/danhsachtraicay.dart';
import 'package:flutter/material.dart';

class Loaddanhmucsp extends StatelessWidget {
  final int danhmucid;

  const Loaddanhmucsp({required this.danhmucid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Hiển thị Dialog sau khi màn hình được dựng xong
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Thông báo"),
            content: Text("Bạn đã chọn danh mục ID: $danhmucid"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Đóng Dialog
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Danh mục sản phẩm')),
      body: Center(
        child: ProductList(danhMucId: danhmucid)
      ),
    );
  }
}
