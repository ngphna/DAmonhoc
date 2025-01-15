
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'khuyenmai.dart'; 
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
  final LoginService loginService = LoginService(); // Khởi tạo đối tượng LoginService

  @override
  Widget build(BuildContext context) {
    return 
     FutureBuilder<List<KhuyenMai>>(
        future: loginService.fetchPromotions(), // Gọi hàm fetchPromotions từ LoginService
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Chờ dữ liệu
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}')); // Lỗi khi tải dữ liệu
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final promotions = snapshot.data!; // Lấy danh sách khuyến mãi
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: promotions.length,
              itemBuilder: (context, index) {
                final promotion = promotions[index];
                return 
                
                GestureDetector(
            onTap: () {
              
            },
            child:
            
            
             Card(
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 3,
              color: Color.fromRGBO(117, 192, 234, 1),
              child: 
            //Padding(padding: EdgeInsets.all(16.0),child:  
              Column(
                children: [
                  Expanded(child: 
                     Padding(padding: EdgeInsets.all(5.0),child: 
                  Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [

Text("${promotion.tenKhuyenMai} ", style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold),),

Text("${promotion.ngayBatDau} - ${promotion.ngayKetThuc}",style: TextStyle(color: Colors.white),),
                  ],)),
                  ),
            
            Text("--------------------",style: TextStyle(color: Colors.white,fontSize: 20),),
            Text("Giảm giá: ${promotion.giamGiaPhanTram}% ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
            SizedBox(height: 10,)
            // Thời gian
            
                 
                ],
              ),
            ),
            //),
          );
              },
            );
          } else {
            return Center(child: Text("Không có khuyến mãi nào còn hiệu lực!")); // Không có dữ liệu
          }
        },
      
    );
  }
}

