import 'package:doan_hk2/model/chitietdonhang_model.dart';
import 'package:doan_hk2/model/diachi_model.dart';
import 'package:doan_hk2/model/donhang_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'product_item_model.dart';
import 'package:doan_hk2/khuyenmai.dart';

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
            id:item['SanPhamID'],
            
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
}//khuyenmai
Future<List<KhuyenMai>> fetchPromotions() async {
    try {
      final response = await http.get(Uri.parse("${apiUrl}khuyenmai.php"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          List<KhuyenMai> promotions = (data['data'] as List)
              .map((item) => KhuyenMai.fromJson(item))
              .toList();
          return promotions;
        } else {
          throw Exception("Không có khuyến mãi nào!");
        }
      } else {
        throw Exception("Lỗi kết nối: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Lỗi khi tải khuyến mãi: $e");
    }
  }
  //Hàm lấy địa chỉ giao
  Future<List<Address>> fetchAddresses(String username) async {
  final response = await http.get(Uri.parse('${apiUrl}diachigiao.php?username=$username'));

  if (response.statusCode == 200) {
    print("JSON từ API: ${response.body}"); // Debug JSON trả về
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Address.fromJson(json)).toList();
  } else {
    throw Exception("Failed to load addresses");
  }
}
//Hàm lấy địa chỉ giao
  Future<List<Address>> layDiaChiID(int id) async {
  final response = await http.get(Uri.parse('${apiUrl}diachigiao.php?id=$id'));

  if (response.statusCode == 200) {
    print("JSON từ API: ${response.body}"); // Debug JSON trả về
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Address.fromJson(json)).toList();
  } else {
    throw Exception("Failed to load addresses");
  }
}
//Hàm post diachigiao
Future<void> addAddress(Address address) async {
  final url = Uri.parse('${apiUrl}themdiachigiao.php'); // Địa chỉ API của bạn

  // Chuyển đối tượng Address thành JSON
  final Map<String, dynamic> addressJson = address.toJson();

  // Gửi yêu cầu POST
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(addressJson),  // Chuyển dữ liệu thành JSON
    );

    // Kiểm tra mã trạng thái HTTP
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData['success'] == true) {
        print('Địa chỉ đã được thêm thành công');
      } else {
        print('Lỗi khi thêm địa chỉ: ${responseData['message']}');
      }
    } else {
      print('Lỗi HTTP: ${response.statusCode}');
    }
  } catch (e) {
    // Xử lý lỗi nếu không thể kết nối với API
    print("Lỗi kết nối: $e");
  }
}

// Hàm lấy dữ liệu đơn hàng theo TenDangNhap
  Future<List<Order>> fetchOrdersByUsername(String tenDangNhap) async {
    final response = await http.get(Uri.parse('${apiUrl}donhang.php?TenDangNhap=$tenDangNhap'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((orderJson) => Order.fromJson(orderJson)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }


//Hàm get don hang
Future<List<Order>> getDonHang() async {
  final response = await http.get(Uri.parse('${apiUrl}getdonhang.php'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['success']) {
      return (data['orders'] as List)
          .map((orderJson) => Order.fromJson(orderJson))
          .toList();
    } else {
      throw Exception(data['message']);
    }
  } else {
    throw Exception('Failed to load orders');
  }
}
//Hàm hiện chi tiết đơn hàng
Future<List<ChiTietDH>> fetchCartItems(String tenDangNhap, int donHangID) async {
    final response = await http.get(
      Uri.parse('${apiUrl}chitietdonhang.php?TenDangNhap=$tenDangNhap&DonHangID=$donHangID'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Kiểm tra nếu trường 'orderDetails' tồn tại và không phải null
      if (data['orderDetails'] != null) {
        // Phân tích danh sách chi tiết đơn hàng
        List<dynamic> orderDetails = data['orderDetails'];
        return orderDetails.map((item) => ChiTietDH.fromJson(item)).toList();
      } else {
        throw Exception('Không có chi tiết đơn hàng.');
      }
    } else {
      throw Exception('Không thể tải dữ liệu.');
    }
  }
  //Hàm hủy đơn hàng
  Future<Map<String, dynamic>> cancelOrder(int orderId) async {
    final url = Uri.parse('${apiUrl}/huydonhang.php');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'orderID': orderId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data; // Phản hồi từ API
      } else {
        return {
          'success': false,
          'message': 'Lỗi HTTP: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối: $e',
      };
    }
  }
  Future<List<Order>> fetchOrders() async {
  final response = await http.get(Uri.parse('${apiUrl}admindonhang.php'));

  if (response.statusCode == 200) {
    // Parse JSON thành Map
    Map<String, dynamic> responseData = json.decode(response.body);
    
    // Kiểm tra key "orders" tồn tại
    if (responseData.containsKey('data')) {
      List<dynamic> ordersData = responseData['data'];
      
      // Convert mỗi phần tử trong danh sách thành đối tượng Order
      return ordersData.map((orderJson) => Order.fromJson(orderJson)).toList();
    } else {
      throw Exception('Key "orders" not found in the response');
    }
  } else {
    throw Exception('Failed to load orders with status code ${response.statusCode}');
  }
}

  //Hàm đổi trạng thái đơn hàng
  Future<bool> updateOrderStatus(int donHangID, String newStatus) async {
  final response = await http.post(
    Uri.parse('${apiUrl}updateOrderStatus.php'),
    body: {
      'DonHangID': donHangID.toString(),
      'TrangThai': newStatus,
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['success'] == true;
  } else {
    throw Exception('Failed to update order status.');
  }
}
}
