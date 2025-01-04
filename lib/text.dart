import 'package:doan_hk2/itemthanhtoan.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';

class Giohang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Số lượng tab
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen, // Màu nền thanh AppBar
          elevation: 0, // Xóa bóng của AppBar
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
          centerTitle: false, // Canh trái tiêu đề
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Thanh tìm kiếm
              Row(
                children: [
                  // Icon menu
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
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  // Icon giỏ hàng
                  Stack(
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart_outlined, color: Colors.lightGreen),
                        onPressed: () {
                          // Hành động khi nhấn giỏ hàng
                        },
                      ),
                      // Huy hiệu số lượng sản phẩm
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '1', // Số lượng sản phẩm
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
              SizedBox(height: 15),
              // TabBar
              Container(
                color: Colors.white, // Màu nền cho TabBar
                child: TabBar(
                  labelColor: Colors.orange, // Màu chữ tab được chọn
                  unselectedLabelColor: Colors.black, // Màu chữ tab không được chọn
                  indicatorColor: Colors.orange, // Màu chỉ báo dưới tab
                  tabs: [
                    Tab(text: 'Chờ Thanh Toán'),
                    Tab(text: 'Đã Mua'),
                  ],
                ),
              ),
              // TabBarView hiển thị nội dung của từng tab
              Expanded(
                child: TabBarView(
                  children: [
                    // Tab "Chờ Thanh Toán"
                    ListView(
                      children: [
                       ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "Cam sieu ngot", price: 1, onQuantityChanged: (quantity) {} ),
                       ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "táo đỏ", price: 2, onQuantityChanged: (quantity) {} ),
                        ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "Cam sieu ngot", price: 1, onQuantityChanged: (quantity) {} ),
                       ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "táo đỏ", price: 2, onQuantityChanged: (quantity) {} ),
                        ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "Cam sieu ngot", price: 1, onQuantityChanged: (quantity) {} ),
                       ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "táo đỏ", price: 2, onQuantityChanged: (quantity) {} ),
                        ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "Cam sieu ngot", price: 1, onQuantityChanged: (quantity) {} ),
                       ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "táo đỏ", price: 2, onQuantityChanged: (quantity) {} ),
                        ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "Cam sieu ngot", price: 1, onQuantityChanged: (quantity) {} ),
                       ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "táo đỏ", price: 2, onQuantityChanged: (quantity) {} ),
                        ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "Cam sieu ngot", price: 1, onQuantityChanged: (quantity) {} ),
                       ProductItem(imageUrl: 'https://via.placeholder.com/150', productName: "táo đỏ", price: 2, onQuantityChanged: (quantity) {} ),
                       
                      ],
                    ),
                    // Tab "Đã Mua"
                    ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.shopping_cart),
                          title: Text('Sản phẩm 3'),
                          subtitle: Text('Giá: 1200đ'),
                          trailing: Icon(Icons.check_box),
                        ),
                        ListTile(
                          leading: Icon(Icons.shopping_cart),
                          title: Text('Sản phẩm 4'),
                          subtitle: Text('Giá: 2000đ'),
                          trailing: Icon(Icons.check_box),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white, // Màu nền toàn bộ màn hình
      ),
    );
  }
}
