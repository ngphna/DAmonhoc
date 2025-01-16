import 'package:doan_hk2/DangKy.dart';
import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/model/chitietdonhang_model.dart';
import 'package:doan_hk2/view/ChiTietDonHang.dart';
import 'package:doan_hk2/view/DonHangChoXacNhan.dart';

import 'package:doan_hk2/DuyetDon.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/ThanhToan.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/trangchu.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DangNhap(),
    );
  }
}
