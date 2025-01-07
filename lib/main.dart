import 'package:doan_hk2/DangKy.dart';
import 'package:doan_hk2/DangNhap.dart';
import 'package:flutter/material.dart';
import 'package:doan_hk2/text.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      initialRoute: '/DangNhap',
      routes: {
        '/DangNhap':(context)=> DangNhap(),
        '/DangKy':(context)=>DangKy(),
        '/Thanhtoan':(context)=>Thanhtoan()
      },
    );
  }
}
