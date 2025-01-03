import 'package:flutter/material.dart';

class DangKy extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => DangKyState();
  
}
class DangKyState extends State<DangKy>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TRANG ĐĂNG KÝ"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Đăng ký"),
            const SizedBox(height: 20,),
            const TextField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            const TextField(
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            const TextField(
              decoration: InputDecoration(
                labelText: "Nhập lại mật khẩu",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){}, 
              child: const Text("Đăng ký")
              ),
          ],
        ),
      ),
    );
  }
}