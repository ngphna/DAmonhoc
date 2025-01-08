import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  final String apiUrl = "http://localhost/api/";

  // Đăng nhập
  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("${apiUrl}login.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['success'];
    } else {
      return false;
    }
  }

  // Đăng ký
   Future<bool> register(String username, String password, String email, String phone) async {
    final response = await http.post(
      Uri.parse("${apiUrl}register.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "email": email,
        "phone": phone
      }),
    );
    
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['success'];
    } else {
      return false;
    }
  }
}
