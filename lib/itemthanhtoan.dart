import 'package:flutter/material.dart';
import 'product_item_model.dart';
import 'api_service.dart';

class ProductItem extends StatefulWidget {
  final ProductItemModel product;
  final ValueChanged<int> onQuantityChanged;

  ProductItem({
    super.key,
    required this.product,
    required this.onQuantityChanged,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  void _increaseQuantity() {
    setState(() {
      widget.product.quantity++;
      widget.onQuantityChanged(widget.product.quantity);
    });
  }

  void _decreaseQuantity() {
    if (widget.product.quantity > 1) {
      setState(() {
        widget.product.quantity--;
        widget.onQuantityChanged(widget.product.quantity);
      });
    }
  }

 @override
Widget build(BuildContext context) {
  if (widget.product.productName.isEmpty) {
    return const Center(child: Text("Không có thông tin sản phẩm."));
  }
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: Colors.black.withOpacity(0.2), width: 0.5),
    ),
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              widget.product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.productName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('Giá: ${widget.product.price.toStringAsFixed(0)} đ',
                    style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(onPressed: _decreaseQuantity, icon: const Icon(Icons.remove)),
              Text('${widget.product.quantity}', style: const TextStyle(fontSize: 16)),
              IconButton(onPressed: _increaseQuantity, icon: const Icon(Icons.add)),
            ],
          ),
        ],
      ),
    ),
  );
}

}
