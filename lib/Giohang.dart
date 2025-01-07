import 'package:doan_hk2/itemdamua.dart';
import 'nutmau.dart';
import 'package:flutter/material.dart';
import 'itemthanhtoan.dart';
import 'trangchu.dart';
import 'hopghichu.dart';
import 'text.dart';

class Giohang extends StatefulWidget {
  @override
  _GiohangState createState() => _GiohangState();
}

class _GiohangState extends State<Giohang> {
  List<ProductItem> productsInCart = [
    ProductItem(
        imageUrl: 'https://via.placeholder.com/150',
        productName: "Cam Sieu Ngot",
        price: 1,
        onQuantityChanged: (quantity, totalPrice) {}),
    ProductItem(
        imageUrl: 'https://via.placeholder.com/150',
        productName: "Táo Đỏ",
        price: 2,
        onQuantityChanged: (quantity, totalPrice) {}),
    ProductItem(
        imageUrl: 'https://via.placeholder.com/150',
        productName: "Chuối",
        price: 1,
        onQuantityChanged: (quantity, totalPrice) {}),
  ];

  void _removeProduct(int index) {
    setState(() {
      productsInCart.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Số lượng tab
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Trangchu(),
                ),
              );
            },
            child: Text(
              "Fruit Paradise",
              style: TextStyle(color: Colors.black),
            ),
          ),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.lightGreen),
                    onPressed: () {
                      // Hành động khi nhấn menu
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
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
                        icon: Icon(Icons.shopping_cart_outlined,
                            color: Colors.lightGreen),
                        onPressed: () {
                          // Hành động khi nhấn giỏ hàng
                        },
                      ),
                      Positioned(
                        right: 0,
                        top: -2,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            productsInCart.length.toString(),
                            style: TextStyle(
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
                child: TabBar(
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.orange,
                  tabs: [
                    Tab(text: 'Chờ Thanh Toán'),
                    Tab(text: 'Đã Mua'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          ),
                        ),
                        SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            itemCount: productsInCart.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(productsInCart[index].productName),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  _removeProduct(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Đã xóa ${productsInCart[index].productName}')),
                                  );
                                },
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                ),
                                child: productsInCart[index],
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: NoteBox(
                            hintText: "Nhập nội dung ghi chú...",
                            onSaved: (text) {
                              print("Nội dung ghi chú: $text");
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Tổng cộng:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              selectionColor: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${productsInCart.fold(0, (sum, item) => sum + item.price)}đ',
                              style: TextStyle(
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
                                          builder: (context) => Trangchu()
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
                                          builder: (context) => Thanhtoan()
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )),
                      ],
                    ),
                    ListView(
                      children: [
                        ProductItemds(
                            imageUrl: 'https://via.placeholder.com/150',
                            productName: "Cam Sieu ngot",
                            price: 1),
                        ProductItemds(
                            imageUrl: 'https://via.placeholder.com/150',
                            productName: "Cam Sieu ngot",
                            price: 2)
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
