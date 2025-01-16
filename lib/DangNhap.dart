import 'package:doan_hk2/nutmau.dart';
import 'package:flutter/material.dart';
import 'api_service.dart'; // Gọi file xử lý API PHP
import 'package:doan_hk2/DangKy.dart';
import 'package:doan_hk2/QuenMatKhau.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:doan_hk2/duyetdon.dart'; // Thêm import cho trang duyetdon

class DangNhap extends StatefulWidget {
  const DangNhap({super.key});

  @override
  State<StatefulWidget> createState() => DangNhapState();
}

class DangNhapState extends State<DangNhap> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  bool _isLoading = false;
  bool _xem = true;

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

      // Kiểm tra tên đăng nhập
      if (_usernameController.text.trim() == "Nam") {
        // Chuyển đến trang duyetdon nếu tên đăng nhập là "thuc"
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DuyetDon()),
        );
      } else {
        // Chuyển đến trang chính nếu không phải "thuc"
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Trangchu()),
        );
      }

      // Thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công!')),
      );
    } else {
      if (!mounted) return;

      // Thông báo sai thông tin đăng nhập
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sai thông tin đăng nhập!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "Đăng Nhập",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 100,
                        child: Image.asset('assets/anh.gif'),
                      ),
                      const SizedBox(height: 5),
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
                        obscureText: _xem,
                        decoration: InputDecoration(
                          labelText: "Mật khẩu",
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _xem ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _xem = !_xem; // Đổi trạng thái hiển thị
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              text: "Đăng Nhập",
                              onPressed: _handleLogin,
                            ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Quenmatkhau()),
                          );
                        },
                        child: const Text("Quên mật khẩu?"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DangKy()),
                          );
                        },
                        child: const Text(
                            "Bạn chưa có tài khoản? Đăng ký tại đây"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
      backgroundColor: const Color.fromRGBO(151, 214, 242, 1),
    );
  }
}
