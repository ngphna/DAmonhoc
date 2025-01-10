import 'package:flutter/material.dart';

class ProductItemds extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final int price;
  

  const ProductItemds({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    
  });

  @override
  _ProductItemStates createState() => _ProductItemStates();
}

class _ProductItemStates extends State<ProductItemds> {
 

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
         side: const BorderSide(
      color: Colors.black, // Màu viền
      width: 0.5, // Độ dày viền
    ),
      ),
     
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Hình ảnh sản phẩm
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              // Thông tin sản phẩm
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Giá: ${widget.price.toStringAsFixed(0)} đ',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
               
        ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromRGBO(249, 147, 14, 1), // Màu nền của nút
    foregroundColor: Colors.white, // Màu văn bản của nút
  ),
  child: const Text("Mua Lại"),
)

            ],
          ),
        ),
      );
  }
}
