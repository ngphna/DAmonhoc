import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';
import "TrangTimKiem.dart";
import 'Giohang.dart';
import 'menu.dart';
import 'itemthanhtoan.dart';

class ProductList extends StatefulWidget {
  final int danhMucId; // Thêm tham số danhMucId vào constructor

  const ProductList(
      {super.key, required this.danhMucId}); // Nhận danhMucId từ constructor

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<dynamic> products = [];
  bool isLoading = true;
  final loginService = LoginService();

  @override
  void initState() {
    super.initState();
    // Gọi phương thức fetchProducts và truyền vào danhMucId từ widget
    fetchProducts(widget.danhMucId);
  }

  Future<void> fetchProducts(int danhMucId) async {
    try {
      final fetchedProducts = await loginService.fetchProducts(danhMucId);

      setState(() {
        products = fetchedProducts.isNotEmpty ? fetchedProducts : [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi tải dữ liệu: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (products.isEmpty) {
      return const Center(child: Text("Không có sản phẩm nào!"));
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetail(
                  name: product['TenSanPham'],
                  price: product['Gia'],
                  image: product['Image'],
                  status: product['TrangThai'] ?? 'Còn hàng',
                  mota: product['MoTa'] ?? 'Không có mô tả',
                  soluong: product['SoLuong'] ?? '1',
                  id: product['SanPhamID'],
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 4,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8.0)),
                    child: Image.asset(
                      product['Image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['TenSanPham']!,
                    style: TextStyle(fontWeight: FontWeight.w100, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      product['Gia']!.toString(),
                      style: TextStyle(color: Colors.orange, fontSize: 20),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      "đ",
                      style: TextStyle(
                          fontWeight: FontWeight.w100,
                          color: Colors.orange,
                          fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProductDetail extends StatefulWidget {
  final String name;
  final int price;
  final String image;
  final String status;
  final String mota;
  final int soluong;
  final int id;

  const ProductDetail({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.status,
    required this.mota,
    required this.soluong,
    required this.id,
  });

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  LoginService cartService = LoginService();
  String? username;
  bool isAddedToCart =
      false; // Biến trạng thái để kiểm tra sản phẩm đã được thêm vào giỏ hàng
  late int currentQuantity; // Số lượng hiện tại
  late int totalPrice; // Tổng giá trị
  final TextEditingController tk_sp = TextEditingController();

  //Hàm tìm kiếm sản phẩm
  void TK_SanPham() async {
    final searchQuery = tk_sp.text.trim();

    if (searchQuery.isEmpty) {
      // Nếu không có từ khóa tìm kiếm
      return;
    }

    try {
      // Gọi API để tìm kiếm sản phẩm theo tên
      List<dynamic> searchResults = await LoginService().tkSanPham(searchQuery);

      // Chuyển đến trang tìm kiếm kết quả
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrangTimKiem(searchResults: searchResults),
        ),
      );
    } catch (e) {
      // Xử lý lỗi nếu không tìm thấy hoặc có vấn đề khi gọi API
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Lỗi: $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
    // Khởi tạo số lượng và giá ban đầu
    currentQuantity = widget.soluong;
    totalPrice = widget.price * currentQuantity;
  }

  // Phương thức bất đồng bộ để tải tên đăng nhập
  Future<void> _loadUsername() async {
    // Khởi tạo đối tượng cartService trong phương thức bất đồng bộ
    LoginService cartService = LoginService();
    // Lấy tên đăng nhập bằng phương thức getUsername
    String? loadedUsername = await cartService.getUsername();
    setState(() {
      username = loadedUsername; // Cập nhật lại state với tên đăng nhập
    });
  }

  void _updateQuantity(bool isIncrement) {
    setState(() {
      // Nếu là tăng và số lượng > 0
      if (isIncrement) {
        currentQuantity++;
      } else {
        // Nếu là giảm nhưng số lượng phải lớn hơn 1
        if (currentQuantity > 1) {
          currentQuantity--;
        }
      }
      // Cập nhật giá tổng khi số lượng thay đổi
      totalPrice = widget.price * currentQuantity;
    });
  }

  String trangthai(String value) {
    if (value == "ConHang") {
      return "Còn Hàng";
    } else {
      return "Hết Hàng";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Trangchu(),
              ),
            );
          },
          child: const Text(
            "Fruit Paradise",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.white),
            onSelected: (value) {
              if (value == "Dangxuat") {
                Navigator.of(context, rootNavigator: true).pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) => DangNhap(),
                );
              } else if (value == "Thongtin") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Thongtincanhan(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: "Dangxuat",
                child: Text("Đăng xuất"),
              ),
              const PopupMenuItem(
                value: "Thongtin",
                child: Text("Thông tin cá nhân"),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.lightGreen),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) => buildMenu(),
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.lightGreen),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(Icons.search, color: Colors.lightGreen),
                          ),
                          Expanded(
                            child: TextField(
                              controller: tk_sp,
                              decoration: const InputDecoration(
                                hintText: 'Tìm sản phẩm',
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) {
                                TK_SanPham(); // Gọi hàm tìm kiếm khi nhấn Enter
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined,
                            color: Colors.lightGreen),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Giohang(),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 0,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          // child: Text(
                          //   '${productsInCart.fold(0, (sum, item) => sum + (item.quantity))}',
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 12,
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.image,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Giá: ${widget.price} đ",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Trạng thái: ${trangthai(widget.status)}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Số lượng:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () =>
                                _updateQuantity(false), // Giảm số lượng
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            '$currentQuantity', // Hiển thị số lượng hiện tại
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () =>
                                _updateQuantity(true), // Tăng số lượng
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Tổng giá: $totalPrice đ", // Hiển thị giá tổng
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
              const SizedBox(height: 20),
              Text(
                "Mô Tả: ${widget.mota}",
                style: const TextStyle(fontSize: 20, color: Colors.grey),
                softWrap: true,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAddedToCart = true;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Đã thêm ${widget.name} vào giỏ hàng!"),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    // Phương thức gọi themGioHang từ CartService
                    cartService.themGioHang(
                        username ?? "", widget.id, currentQuantity);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isAddedToCart ? Colors.grey : Colors.lightGreen,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  child: Text(
                    isAddedToCart ? "Đã thêm" : "Thêm vào giỏ hàng",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
