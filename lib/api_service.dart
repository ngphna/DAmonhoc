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
  Future<List<dynamic>> fetchProducts(int danhMucId) async {
  try {
    // Gửi yêu cầu GET tới API với tham số DanhMucID
    final response = await http.get(Uri.parse("${apiUrl}trangchu.php?DanhMucID=$danhMucId"));

    // Kiểm tra mã trạng thái HTTP
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Kiểm tra nếu API trả về dữ liệu hợp lệ
      if (data['success'] == true) {
        return data['data'] ?? []; // Trả về danh sách sản phẩm hoặc danh sách rỗng
      } else {
        throw Exception(data['message'] ?? "Không có sản phẩm nào!");
      }
    } else {
      throw Exception("Failed to load products: ${response.statusCode}");
    }
  } catch (e) {
    // Xử lý lỗi khi gặp vấn đề trong quá trình fetch dữ liệu
    throw Exception("Error fetching products: $e");
  }
}}