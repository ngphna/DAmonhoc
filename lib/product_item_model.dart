// product_item_model.dart
class ProductItemModel {
  final String imageUrl;
  final String productName;
  final int price;
  int quantity;
  int id;

  ProductItemModel({
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.quantity = 1,
    this.id =0
  });
}
