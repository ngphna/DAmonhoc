import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/DonHangChoXacNhan.dart';
import 'package:doan_hk2/DonHangDaXacNhan.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/itemdamua.dart';
import 'package:doan_hk2/ThanhToan.dart';
import 'nutmau.dart';
import 'package:flutter/material.dart';
import 'itemthanhtoan.dart';
import 'trangchu.dart';
import 'hopghichu.dart';
import 'menu.dart';
import 'TrangTimKiem.dart';
import 'api_service.dart';
import 'product_item_model.dart';

class Giohang extends StatefulWidget {
  const Giohang({super.key});

  @override
  _GiohangState createState() => _GiohangState();
}

class _GiohangState extends State<Giohang> {
  LoginService cartService = LoginService();
  String? username;
  final TextEditingController tk_sp = TextEditingController();
  List<ProductItemModel> productsInCart = [];

  @override
  void initState() {
    super.initState();
    _loadCartProducts();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    // Lấy tên đăng nhập
    String? loadedUsername = await cartService.getUsername();
    setState(() {
      username = loadedUsername; // Cập nhật lại state với tên đăng nhập
    });
  }

  void _loadCartProducts() async {
    try {
      List<ProductItemModel> loadedProducts =
          await cartService.fetchCartProducts();
      setState(() {
        productsInCart = loadedProducts;
      });
    } catch (e) {}
  }

  // Hàm tìm kiếm sản phẩm
  void TK_SanPham() async {
    final searchQuery = tk_sp.text.trim();

    if (searchQuery.isEmpty) {
      return; // Nếu không có từ khóa tìm kiếm
    }

    try {
      List<dynamic> searchResults = await cartService.tkSanPham(searchQuery);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrangTimKiem(searchResults: searchResults),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Lỗi: $e")));
    }
  }

  final PageController _pageController = PageController();

  // Hàm xóa sản phẩm khỏi giỏ hàng và đồng bộ hóa với server
  void _removeProduct(int index) async {
    setState(() {
      // Xóa sản phẩm khỏi danh sách giỏ hàng
      ProductItemModel product = productsInCart[index];
      productsInCart.removeAt(index);

      // Gọi API để xóa sản phẩm khỏi giỏ hàng trên server
      cartService.themGioHang(username ?? "", product.id, -product.quantity);
    });
  }

  // Hàm thay đổi số lượng sản phẩm và đồng bộ hóa với server
  void _updateProductQuantity(int index, int newQuantity) async {
    setState(() {
      productsInCart[index].quantity = newQuantity;
    });

    // Gọi API để cập nhật số lượng sản phẩm trên server
    cartService.themGioHang(
      username ?? "",
      productsInCart[index].id,
      newQuantity - productsInCart[index].quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Số lượng tab
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
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
          centerTitle: false,
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
          child: Column(
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: InkWell(
                                onTap: () {
                                  TK_SanPham();
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Colors.lightGreen,
                                )),
                          ),
                          Expanded(
                            child: TextField(
                              controller: tk_sp,
                              decoration: InputDecoration(
                                hintText: 'Tìm sản phẩm',
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) {
                                TK_SanPham();
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
                          child: Text(
                            '${productsInCart.fold(0, (sum, item) => sum + item.quantity)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                child: const TabBar(
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.orange,
                  tabs: [
                    Tab(text: 'Chờ Thanh Toán'),
                    Tab(text: 'Chờ Duyệt'),
                    Tab(text: 'Đang Giao'),
                    Tab(text: 'Đã Mua'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            itemCount: productsInCart.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(productsInCart[index].productName),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) async {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Xác nhận"),
                                        content: const Text(
                                            "Bạn có chắc chắn muốn xóa sản phẩm này?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text("Hủy"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text("Xóa"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                onDismissed: (direction) {
                                  _removeProduct(index);
                                },
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 16.0),
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                ),
                                child: ProductItem(
                                  product: productsInCart[index],
                                  onQuantityChanged: (newQuantity) {
                                    _updateProductQuantity(index, newQuantity);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: NoteBox(
                            hintText: "Ghi chú đơn hàng ...",
                            onSaved: (text) {
                              print("Nội dung ghi chú: $text");
                            },
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Tổng cộng:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${productsInCart.fold(0, (sum, item) => sum + (item.price * item.quantity))}đ',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomButton(
                                text: "Mua Tiếp",
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Trangchu(),
                                    ),
                                  );
                                },
                              ),
                              CustomButton(
                                text: "Thanh toán",
                                onPressed: () {
                                  if (productsInCart.length > 0) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Thanhtoan()));
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Thông báo"),
                                          content: Text("Bạn Chưa Có Sản Phẩm"),
                                          actions: [
                                            TextButton(
                                              child: Text("Ok"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Đóng dialog
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListView(
                      children: [
                        // Màn hình đơn hàng
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Danh sách đơn hàng:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 400, // Giới hạn chiều cao
                          child: DonHangChoXacNhan(),
                        ),
                      ],
                    ),
                    ListView(
                      children: [
                        // Màn hình đơn hàng
                        const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Danh sách đơn hàng:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 400, // Giới hạn chiều cao
                          child: DonHangDaXacNhan(),
                        ),
                      ],
                    ),
                    ListView(
                      children: const [
                        ProductItemds(
                            imageUrl: 'https://via.placeholder.com/150',
                            productName: "Cam Sieu ngot",
                            price: 1),
                        ProductItemds(
                            imageUrl: 'https://via.placeholder.com/150',
                            productName: "Cam Sieu ngot",
                            price: 2),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
