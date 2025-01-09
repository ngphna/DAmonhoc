import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final int price;
  int quantity;
  final ValueChanged<int> onQuantityChanged;

  ProductItem({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.quantity = 1,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  void _increaseQuantity() {
    setState(() {
      widget.quantity++;
      widget.onQuantityChanged(widget.quantity);
    });
  }

  void _decreaseQuantity() {
    if (widget.quantity > 1) {
      setState(() {
        widget.quantity--;
        widget.onQuantityChanged(widget.quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.black.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Giá: ${widget.price.toStringAsFixed(0)} đ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _decreaseQuantity,
                  icon: Icon(Icons.remove),
                ),
                Text(
                  '${widget.quantity}',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: _increaseQuantity,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
List<ProductItem> productsInCart = [
    ProductItem(
      imageUrl: 'assets/tải xuống (1).jpg',
      productName: "Cam Siêu Ngọt",
      price: 10000,
      onQuantityChanged: (quantity) {},
    ),
    ProductItem(
      imageUrl: 'assets/tải xuống (3).jpg',
      productName: "Táo Đỏ",
      price: 20000,
      onQuantityChanged: (quantity) {},
    ),
    ProductItem(
      imageUrl:'assets/tải xuống.jpg',
      productName: "Chuối",
      price: 15000,
      onQuantityChanged: (quantity) {},
    ),
  ];
