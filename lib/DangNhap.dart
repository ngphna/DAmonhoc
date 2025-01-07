import 'package:doan_hk2/DangKy.dart';
import 'package:doan_hk2/QuenMatKhau.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';

class DangNhap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DangNhapState();
}

class DangNhapState extends State<DangNhap> {
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
                  "Đăng nhập",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // Màu chữ trắng để nổi bật trên nền
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                
                ),
                const SizedBox(height: 20),
                TextField(
                    decoration: InputDecoration(
                      labelText: "Mật khẩu",
                      border: OutlineInputBorder(),
                    ),
                  ),
              
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                  builder: (context) => Trangchu(),
                  ),
                );
                  },
                  child: const Text("Đăng nhập"),
                ),

                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Quenmatkhau()
                      ),
                    );
                  }, 
                  child: Text("Quên mật khẩu ?")
                  ),

                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                        builder: (context) => DangKy()
                        ),
                    );
                  }, 
                  child: Text("Bạn chưa có tài khoản đăng ký tại đây ")
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
