import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Trangchu extends StatefulWidget {
  const Trangchu({super.key});

  @override
  State<Trangchu> createState() => _TrangchuState();
}

class _TrangchuState extends State<Trangchu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      style: TextStyle(color: Colors.white),
    ),
  ),
  backgroundColor: Colors.green,
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
                    // Positioned(
                    //   right: 6,
                    //   top: 6,
                    //   child: Container(
                    //     padding: EdgeInsets.all(4),
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: Text(
                    //       '1', // Số lượng sản phẩm
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
      backgroundColor: Colors.white, // Màu nền toàn bộ màn hình
    );
  }
}
