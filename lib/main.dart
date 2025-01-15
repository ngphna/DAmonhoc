import 'package:doan_hk2/DangKy.dart';
import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/DonHangChoXacNhan.dart';

import 'package:doan_hk2/DuyetDon.dart';
import 'package:doan_hk2/Giohang.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      home: DangNhap(),
    
    
    );
  }
}
