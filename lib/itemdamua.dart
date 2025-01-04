import 'package:flutter/material.dart';

class ProductItemds extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final int price;
  

  const ProductItemds({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    
  }) : super(key: key);

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
              SizedBox(width: 10),
              // Thông tin sản phẩm
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
               
        ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromRGBO(249, 147, 14, 1), // Màu nền của nút
    foregroundColor: Colors.white, // Màu văn bản của nút
  ),
  child: Text("Mua Lại"),
)

            ],
          ),
        ),
      );
  }
}
