import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'product_item_model.dart';
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
      if (responseData['success']) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('TenDangNhap', username);
        return true;
      }
    }
    return false;
  }
  // Lấy TenDangNhap từ SharedPreferences
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('TenDangNhap');
  }
  // Đăng xuất
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('TenDangNhap');
  }

  // Lấy thông tin người dùng dựa theo TenDangNhap
  Future<Map<String, dynamic>?> fetchCurrentUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('TenDangNhap');
    if (username == null) return null;

    final response = await http.post(
      Uri.parse("${apiUrl}thongtincanhan.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return data['data'];
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception("Lỗi server: ${response.statusCode}");
    }
  }

  // Cập nhật thông tin cá nhân theo TenDangNhap
  Future<void> updateUserInfo(Map<String, dynamic> updatedInfo) async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('TenDangNhap');

    if (username == null || username.isEmpty) {
      throw Exception("Thiếu username. Vui lòng đăng nhập lại.");
    }

    updatedInfo['username'] = username;

    final response = await http.post(
      Uri.parse("${apiUrl}thongtincanhan.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updatedInfo),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (!data['success']) {
        throw Exception("Cập nhật thất bại: ${data['message']}");
      }
    } else {
      throw Exception("Lỗi server: ${response.statusCode}");
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
}
// Tìm kiếm sản phẩm theo tên
Future<List<dynamic>> tkSanPham(String name) async {
  try {
    // Gửi yêu cầu GET tới API với tham số tìm kiếm 'search'
    final response = await http.get(Uri.parse('${apiUrl}timkiemSP.php?search=$name'));

    // Kiểm tra mã trạng thái HTTP
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Kiểm tra nếu API trả về dữ liệu hợp lệ
      if (data['success'] == true) {
        return data['data'] ?? []; // Trả về danh sách sản phẩm hoặc danh sách rỗng
      } else {
        throw Exception(data['message'] ?? "Không có sản phẩm nào phù hợp với tên '$name'.");
      }
    } else {
      throw Exception("Failed to load products: ${response.statusCode}");
    }
  } catch (e) {
    // Xử lý lỗi khi gặp vấn đề trong quá trình fetch dữ liệu
    throw Exception("Error fetching products: $e");
  }
}
 // Lấy giỏ hàng từ server theo TenDangNhap
 // Hàm fetchProductInfo trả về dữ liệu từ API
  Future<Map<String, dynamic>> fetchProductInfo() async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}giohang.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"SanPhamID": 1}),  // Thay đổi ID theo sản phẩm cần lấy
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception("Lỗi từ server: ${responseData['message']}");
        }
      } else {
        throw Exception("Lỗi server: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Lỗi kết nối: $error");
    }
  }
  Future<List<ProductItemModel>> fetchCartProducts() async {
  final prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('TenDangNhap');

  if (username == null || username.isEmpty) {
    throw Exception("Lỗi: Người dùng chưa đăng nhập hoặc thiếu TenDangNhap.");
  }

  try {
    final response = await http.post(
      Uri.parse("${apiUrl}giohang.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"TenDangNhap": username}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        return (responseData['data'] as List).map((item) {
          return ProductItemModel(
            imageUrl: item['Image'],
            productName: item['TenSanPham'],
            price: item['Gia'],
            quantity: item['SoLuong'],
          );
        }).toList();
      } else {
        throw Exception("Không có sản phẩm trong giỏ hàng.");
      }
    } else {
      throw Exception("Lỗi server: Mã trạng thái ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Lỗi kết nối hoặc xử lý dữ liệu: $e");
  }
}
//Thêm vào giỏ hàng
Future<void> themGioHang(String username, int productId, int quantity) async {
  final url = Uri.parse('${apiUrl}themgiohang.php');

  try {
    // Thực hiện gửi yêu cầu POST
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'TenDangNhap': username,  // Không cần mã hóa tên đăng nhập
        'SanPhamID': productId,
        'SoLuong': quantity,
      }),
    );

    // Kiểm tra mã trạng thái HTTP
    if (response.statusCode == 200) {
      try {
        // Giải mã JSON từ phản hồi
        final data = jsonDecode(response.body);
        
        // Kiểm tra trạng thái của API
        if (data['status'] == 'success') {
          print('Thêm sản phẩm vào giỏ hàng thành công: ${data['message']}');
        } else {
          print('Lỗi khi thêm sản phẩm: ${data['message']}');
        }
      } catch (e) {
        print("Lỗi khi giải mã JSON: $e");
      }
    } else {
      // Xử lý các mã lỗi HTTP khác (không phải 200 OK)
      print('Lỗi HTTP: ${response.statusCode}');
    }
  } catch (e) {
    // Xử lý lỗi nếu không thể kết nối với API
    print("Lỗi kết nối: $e");
  }
}

}
