import 'package:doan_hk2/MatKhauMoi.dart';
import 'package:doan_hk2/nutmau.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';

class Quenmatkhau extends StatefulWidget {
  const Quenmatkhau({super.key});

  @override
  State<StatefulWidget> createState() => QuenmatkhauState();
}

class QuenmatkhauState extends State<Quenmatkhau> {
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
                Text(
                  "Lấy Lại Mật Khẩu",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w100,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Nhập Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                    text: "Xác Nhận",
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Matkhaumoi(),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
