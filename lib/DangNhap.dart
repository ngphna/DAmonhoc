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
            padding: const EdgeInsets.all(30.0), // Padding xung quanh toàn bộ Column
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
                const SizedBox(height: 50),
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
                  onPressed: () {},
                  child: const Text("Đăng nhập"),
                ),
                const SizedBox(height: 20,),
                TextButton(
                  onPressed: (){

                  }, 
                  child: Text("Quên mật khẩu ?")
                  ),
                  const SizedBox(height: 20,),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/DangKy');
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
