import 'package:doan_hk2/DangNhap.dart';
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
      
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/nen.jpg'),
          fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Đăng ký",
              style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // Màu chữ trắng để nổi bật trên nền
                  ),
              ),
            const SizedBox(height: 30,),
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
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DangNhap()
                  ),
                );
              },
              child: const Text("Đăng ký")
              ),

                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DangNhap()
                      ),
                    );
                  }, 
                  child: Text("Bạn đã có tài khoản ?")
                  ),
          ],
        ),
            ),
        )
      )
    );
  }
}