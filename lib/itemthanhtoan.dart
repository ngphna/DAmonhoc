import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final int price;
  final Function(int quantity) onQuantityChanged;

  const ProductItem({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int _quantity = 1;

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
    widget.onQuantityChanged(_quantity); // Gọi callback để cập nhật giỏ hàng
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
      widget.onQuantityChanged(_quantity); // Gọi callback để cập nhật giỏ hàng
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
         side: BorderSide(
      color: Colors.black, // Màu viền
      width: 0.5, // Độ dày viền
    ),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
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
                  '$_quantity',
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
