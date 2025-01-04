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
            const SizedBox(height: 10,),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/DangNhap');
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