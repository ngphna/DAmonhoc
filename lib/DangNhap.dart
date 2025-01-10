import 'package:doan_hk2/nutmau.dart';
import 'package:flutter/material.dart';
import 'api_service.dart'; // Gọi file xử lý API PHP
import 'package:doan_hk2/DangKy.dart';
import 'package:doan_hk2/QuenMatKhau.dart';
import 'package:doan_hk2/trangchu.dart';

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
  bool _xem=true;

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
        MaterialPageRoute(builder: (context) => const Trangchu()),
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
    return 
    Scaffold(
      body: Container(

       
        child:
        Column(children: [
       
        Expanded(child:
         Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(  
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: [

                  
                  const SizedBox(height: 30),

                   Text(
                    "Đăng Nhập",
                    style: TextStyle(fontSize:40, fontWeight: FontWeight.bold, color: Colors.white,),
                  ),
                  SizedBox(height: 5,),
                   Container(
                    height: 100,
                    
                    child: 
                   
                  Image.asset('assets/anh.gif'),
                  ),
                  SizedBox(height: 5,),

                  TextField(
                    controller: _usernameController,
                    decoration:  InputDecoration(
                      labelText: "Tên đăng nhập",
                      
                      
                      border: OutlineInputBorder(
                      ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.white,)
                      // ),
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide:BorderSide(color: Colors.purple),
                      // )
                      
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: _xem,
                    decoration:  InputDecoration(
                      labelText: "Mật khẩu",
                      border: OutlineInputBorder(
                        
                      ),
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
                      ? const CircularProgressIndicator() // Hiển thị vòng quay loading
                      :CustomButton(
                        text: "Đăng Nhập",
                          onPressed: _handleLogin,
                         
                        ),
                        SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Quenmatkhau()),
                      );
                    },
                    child: const Text("Quên mật khẩu?"),
                  ),
                  TextButton(
                    onPressed: () {
                       Navigator.pushReplacement(
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
      backgroundColor:Color.fromRGBO(151, 214, 242, 1),
   );
    
  }
}
