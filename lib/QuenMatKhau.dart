import 'package:doan_hk2/MatKhauMoi.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';

class Quenmatkhau extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuenmatkhauState();
}

class QuenmatkhauState extends State<Quenmatkhau> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/nen.jpg'), // Đường dẫn đến ảnh nền trong thư mục assets
            fit: BoxFit.cover, // Căng đầy màn hình
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Padding xung quanh toàn bộ Column
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Quên mật khẩu",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // Màu chữ trắng để nổi bật trên nền
                  ),
                ),

                const SizedBox(height: 50),
                const Text(
                  "Nhập Email lấy lại mật khẩu",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Màu chữ trắng để nổi bật trên nền
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),

                ),
                const SizedBox(height: 20),
                const Text(
                  "Nhập mã xác nhận",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Màu chữ trắng để nổi bật trên nền
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Mã xác nhận",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Matkhaumoi(),
                      ),
                    );
                  },
                  child: const Text("Hoàn tất"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
