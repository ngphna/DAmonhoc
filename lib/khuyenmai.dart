
import 'package:doan_hk2/ThanhToan.dart';
import 'package:doan_hk2/nutmau.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'khuyenmai.dart'; 
import 'product_item_model.dart';
class KhuyenMai {
  final int id;
  final String tenKhuyenMai;
  final String moTa;
  final int giamGiaPhanTram;
  final String ngayBatDau;
  final String ngayKetThuc;

  KhuyenMai({
    required this.id,
    required this.tenKhuyenMai,
    required this.moTa,
    required this.giamGiaPhanTram,
    required this.ngayBatDau,
    required this.ngayKetThuc,
  });

  // Phương thức chuyển từ JSON sang đối tượng KhuyenMai
  factory KhuyenMai.fromJson(Map<String, dynamic> json) {
    return KhuyenMai(
      id: json['KhuyenMaiID'],
      tenKhuyenMai: json['TenKhuyenMai'],
      moTa: json['MoTa'] ?? '',
      giamGiaPhanTram: json['GiamGiaPhanTram'],
      ngayBatDau: json['NgayBatDau'],
      ngayKetThuc: json['NgayKetThuc'],
    );
  }
}
// Import đúng model KhuyenMai

class PromotionsScreen extends StatelessWidget {
  final LoginService loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<KhuyenMai>>(
      future: loginService.fetchPromotions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Lỗi: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final promotions = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: promotions.length,
            itemBuilder: (context, index) {
              final promotion = promotions[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PromotionDetailsScreen(
                        promotion: promotion,
                      ),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 3,
                  color: Color.fromRGBO(117, 192, 234, 1),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                promotion.tenKhuyenMai,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${promotion.ngayBatDau} - ${promotion.ngayKetThuc}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "--------------------",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "Giảm giá: ${promotion.giamGiaPhanTram}%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text("Không có khuyến mãi nào còn hiệu lực!"));
        }
      },
    );
  }
}

Widget showkmWidget(BuildContext context) {
  return AlertDialog(
    title: Text(
      "Khuyến Mãi HOT",
      style: TextStyle(color: Colors.lightGreen),
    ),
    content: Container(
      width: double.maxFinite,
      child: SizedBox(
        height: 200,
        child: PromotionsScreen(), // Widget chứa nội dung khuyến mãi
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          
             Navigator.of(context).pop(); // Đóng dialog
            
        },
        child: Text('Đóng'),
      ),
    ],
  );
}

class PromotionDetailsScreen extends StatefulWidget {
  final KhuyenMai promotion;

  PromotionDetailsScreen({required this.promotion});

  @override
  _PromotionDetailsScreenState createState() => _PromotionDetailsScreenState();
}

class _PromotionDetailsScreenState extends State<PromotionDetailsScreen> {
  final LoginService cartService = LoginService();
  String? username;
  List<ProductItemModel> productsInCart = [];

  @override
  void initState() {
    super.initState();
    _loadCartProducts();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    String? loadedUsername = await cartService.getUsername();
    setState(() {
      username = loadedUsername;
    });
  }

  Future<void> _loadCartProducts() async {
    try {
      List<ProductItemModel> loadedProducts = await cartService.fetchCartProducts();
      setState(() {
        productsInCart = loadedProducts;
      });
    } catch (e) {
     
    }
  }

  @override
  Widget build(BuildContext context) {
    final promotion = widget.promotion; // Sử dụng widget để truy cập đối tượng trong StatefulWidget

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              promotion.tenKhuyenMai,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Thời gian: ${promotion.ngayBatDau} - ${promotion.ngayKetThuc}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Text(
              "Giảm giá: ${promotion.giamGiaPhanTram}%",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Mô tả:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              promotion.moTa,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Huỷ",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: "Sử Dụng",
                    onPressed: () {
                      if(productsInCart.length>0){
                        int km=promotion.giamGiaPhanTram??0;
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder:( context)=> Thanhtoan(),
                        settings: RouteSettings(arguments: km)
                        )
                        );
                      }
                      else{
                         showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Thông báo"),
        content: Text("Bạn Chưa Có Sản Phẩm"),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
          ),
         
          
        ],
      );
    },
  );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(117, 192, 234, 1),
    );
  }
}
