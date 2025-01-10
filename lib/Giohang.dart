import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/Thongtincanhan.dart';
import 'package:doan_hk2/itemdamua.dart';
import 'package:doan_hk2/text.dart';
import 'nutmau.dart';
import 'package:flutter/material.dart';
import 'itemthanhtoan.dart';
import 'trangchu.dart';
import 'hopghichu.dart';
import 'menu.dart';

class Giohang extends StatefulWidget {
  const Giohang({super.key});

  @override
  _GiohangState createState() => _GiohangState();
}

class _GiohangState extends State<Giohang> {
  
  void _removeProduct(int index) {
    setState(() {
      productsInCart.removeAt(index);
    });
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
              // Xử lý khi chọn menu
              if (value == "Dangxuat") {
                Navigator.of(context, rootNavigator: true).pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                      child: const Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 12.0),
                            child: Icon(Icons.search, color: Colors.lightGreen),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Tìm sản phẩm',
                                border: InputBorder.none,
                              ),
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
                          
                          // Hành động khi nhấn giỏ hàng
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
                            '${productsInCart.fold(0, (sum, item) => sum + (item.quantity))}',
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
                                    padding:
                                        EdgeInsets.only(right: 16.0),
                                    child: Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                ),
                                child: ProductItem(
                                  imageUrl: productsInCart[index].imageUrl,
                                  productName:
                                      productsInCart[index].productName,
                                  price: productsInCart[index].price,
                                  quantity: productsInCart[index].quantity,
                                  onQuantityChanged: (newQuantity) {
                                    setState(() {
                                      productsInCart[index].quantity =
                                          newQuantity;
                                    });
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
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Thanhtoan(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListView(
                      children: const [
                        Text("Chờ Duyệt"),
                      ],
                    ),
                    ListView(
                      children: const [
                        Text("Chờ Giao"),
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
