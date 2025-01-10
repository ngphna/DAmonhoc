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
  //Danh mục
  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse("${apiUrl}danhmuc.php"));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = json.decode(response.body);

      if (data['success']) {
        List<String> categories = List<String>.from(data['data']);
        return categories;
      } else {
        throw Exception('Không thể tải danh mục');
      }
    } else {
      throw Exception('Lỗi kết nối: ${response.statusCode}');
    }
  }
  //Trang chủ
  Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse("${apiUrl}trangchu.php"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? []; // Trả về danh sách hoặc danh sách rỗng
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
