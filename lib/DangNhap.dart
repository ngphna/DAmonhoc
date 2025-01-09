import 'package:flutter/material.dart';
import 'api_service.dart'; // Gọi file xử lý API PHP
import 'package:doan_hk2/DangKy.dart';
import 'package:doan_hk2/QuenMatKhau.dart';
import 'package:doan_hk2/trangchu.dart';

class DangNhap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DangNhapState();
}

class DangNhapState extends State<DangNhap> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  bool _isLoading = false; 

  void _handleLogin() async {
    setState(() {
      _isLoading = true; 
    });

    bool success = await _loginService.login(
      _usernameController.text.trim(), 
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Trangchu()),
      );
    } else {
     
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sai thông tin đăng nhập!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/nen.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child:
        Column(children: [
           Text(
                    "Đăng nhập",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Colors.green,
                    ),
                  ),
        Expanded(child:
         Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(  
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: [
                  
                  const SizedBox(height: 30),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Tên đăng nhập",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Mật khẩu",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator() // Hiển thị vòng quay loading
                      : ElevatedButton(
                          onPressed: _handleLogin,
                          child: const Text("Đăng nhập"),
                        ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Quenmatkhau()),
                      );
                    },
                    child: const Text("Quên mật khẩu?"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DangKy()),
                      );
                    },
                    child: const Text("Bạn chưa có tài khoản? Đăng ký tại đây"),
                  ),
                ],
              ),
            ),
          ),
       ), ),],)
      ),
    );
  }
}
