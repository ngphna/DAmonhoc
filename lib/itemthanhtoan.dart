import 'package:flutter/material.dart';
import 'product_item_model.dart';
import 'api_service.dart';

// hiện trong giỏ hànghàng
class ProductItem extends StatefulWidget {
  final ProductItemModel product;
  final ValueChanged<int> onQuantityChanged;

  const ProductItem({
    super.key,
    required this.product,
    required this.onQuantityChanged,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final LoginService cartService = LoginService(); // Dịch vụ gọi API
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Gọi để lấy tên đăng nhập
  }

  Future<void> _loadUsername() async {
    try {
      String? loadedUsername = await cartService.getUsername();
      setState(() {
        username = loadedUsername; // Cập nhật state với tên đăng nhập
      });
    } catch (e) {
      debugPrint('Lỗi khi tải username: $e');
    }
  }

  void _increaseQuantity() async {
    if (username == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lỗi: Không tìm thấy tên đăng nhập!')),
      );
      return;
    }

    try {
      // Gọi API để thêm vào giỏ hàng
      await cartService.themGioHang(username!, widget.product.id, 1);
      setState(() {
        widget.product.quantity++; // Cập nhật số lượng sản phẩm
        widget.onQuantityChanged(widget.product.quantity);
      });
    } catch (e) {
      debugPrint('Lỗi khi thêm vào giỏ hàng: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Lỗi: Không thể thêm sản phẩm vào giỏ hàng!')),
      );
    }
  }

  void _decreaseQuantity() async {
    if (username == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lỗi: Không tìm thấy tên đăng nhập!')),
      );
      return;
    }

    try {
      // Gọi API để thêm vào giỏ hàng
      if (widget.product.quantity > 1) {
        await cartService.themGioHang(username!, widget.product.id, -1);
        setState(() {
          widget.product.quantity--; // Cập nhật số lượng sản phẩm
          widget.onQuantityChanged(widget.product.quantity);
        });
      }
    } catch (e) {
      debugPrint('Lỗi khi thêm vào giỏ hàng: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Lỗi: Không thể thêm sản phẩm vào giỏ hàng!')),
      );
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
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text('Giá: ${widget.product.price.toStringAsFixed(0)} đ',
                      style: const TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _decreaseQuantity,
                  icon: const Icon(Icons.remove),
                ),
                Text('${widget.product.quantity}',
                    style: const TextStyle(fontSize: 16)),
                Text(widget.product.donvi),
                IconButton(
                  onPressed: _increaseQuantity,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// hiẹn trong thanh toán
class ProductItems extends StatefulWidget {
  final ProductItemModel product;

  const ProductItems({
    super.key,
    required this.product,
  });

  @override
  _ProductItemsState createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> {
  final LoginService cartService = LoginService(); // Dịch vụ gọi API
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Gọi để lấy tên đăng nhập
  }

  Future<void> _loadUsername() async {
    try {
      String? loadedUsername = await cartService.getUsername();
      setState(() {
        username = loadedUsername; // Cập nhật state với tên đăng nhập
      });
    } catch (e) {
      debugPrint('Lỗi khi tải username: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product.productName.isEmpty) {
      return const Center(
        child: Text("Không có thông tin sản phẩm."),
      );
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
                  Text(
                    widget.product.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Giá: ${widget.product.price.toStringAsFixed(0)} đ',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  ' ${widget.product.quantity}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
