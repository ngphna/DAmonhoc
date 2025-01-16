import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/nutmau.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';

class Matkhaumoi extends StatefulWidget {
  const Matkhaumoi({super.key});

  @override
  State<StatefulWidget> createState() => MatkhaumoiState();
}

class MatkhaumoiState extends State<Matkhaumoi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.all(20.0), // Padding xung quanh toàn bộ Column
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Mật khẩu mới",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w100,
                    color: Colors.black, // Màu chữ trắng để nổi bật trên nền
                  ),
                ),
                const SizedBox(height: 50),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Nhập lại mật khẩu",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                    text: "Hoàn Tất",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DangNhap(),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
