import 'package:doan_hk2/DangNhap.dart';
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
        decoration: const BoxDecoration(
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
                  "Mật khẩu mới",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // Màu chữ trắng để nổi bật trên nền
                  ),
                ),

                const SizedBox(height: 50),
                const Text(
                  "Nhập mật khẩu mới",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Màu chữ trắng để nổi bật trên nền
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    border: OutlineInputBorder(),
                  ),

                ),
                const SizedBox(height: 20),
                const Text(
                  "Nhập lại mật khẩu",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Màu chữ trắng để nổi bật trên nền
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Nhập lại mật khẩu",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DangNhap(),
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
