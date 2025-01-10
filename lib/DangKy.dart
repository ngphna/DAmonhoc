import 'package:doan_hk2/nutmau.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'DangNhap.dart';

class DangKy extends StatefulWidget {
  const DangKy({super.key});

  @override
  State<StatefulWidget> createState() => DangKyState();
}

class DangKyState extends State<DangKy> {
  final TextEditingController _usernameController = TextEditingController(); 
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final LoginService _loginService = LoginService();
  bool _isLoading = false;
   

  bool _isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  void _handleRegister() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin!')),
      );
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email không hợp lệ!')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu không trùng khớp!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool success = await _loginService.register(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
      _emailController.text.trim(),
      _phoneController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DangNhap()),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thất bại! Vui lòng thử lại.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     

      body: Container(
       
        child: 
        Column(children: [ 
        Expanded(child:
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
            
             SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                    Text(
                    "Đăng Ký",
                    style: TextStyle(fontSize:40, fontWeight: FontWeight.bold, color: Colors.white,),
                  ),
                  SizedBox(height: 5,),
                   Container(
                    height: 100,
                    
                    child: 
                   
                  Image.asset('assets/anh.gif'),
                  ),
                  SizedBox(height: 5,),
                
                   SizedBox(height: 40),

                  // Thêm trường UserName
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Tên đăng nhập",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: "Số điện thoại",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Mật khẩu",
                      border: OutlineInputBorder(
                        
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Nhập lại mật khẩu",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const CircularProgressIndicator()
                      :CustomButton(text: "Đăng ký", onPressed: _handleRegister),
                      
                      
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DangNhap()),
                      );
                    },
                    child: const Text("Bạn đã có tài khoản? Đăng nhập tại đây.",
                    )
                    
                  ),
                ],
              ),
            ),
          ),
       ), ),],)
      ),
      backgroundColor:Color.fromRGBO(151, 214, 242, 1) ,
    );
  }
}
