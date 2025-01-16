import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/model/chitietdonhang_model.dart';
import 'package:doan_hk2/view/DanhSachDonHang.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final String tenDangNhap;
  final int donHangID;

  CartPage({required this.tenDangNhap, required this.donHangID});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<ChiTietDH>> futureCartItems;

  @override
  void initState() {
    super.initState();
    futureCartItems = LoginService().fetchCartItems(widget.tenDangNhap, widget.donHangID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi Tiết Đơn Hàng'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DanhSachDonHang(),
              ),
            );
            }, 
            
          )
        ], 
      ),
      body: FutureBuilder<List<ChiTietDH>>(
        future: futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('Không có chi tiết đơn hàng.'));
          } else {
            final cartItems = snapshot.data!;
            // Lấy thông tin người nhận từ mục đầu tiên (giả định thông tin này giống nhau cho toàn bộ đơn hàng)
            final firstItem = cartItems.first;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Phần thông tin người nhận
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Thông Tin Người Nhận', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Tên: ${firstItem.tenNguoiNhan ?? "Không xác định"}'),
                      Text('SĐT: ${firstItem.sdt ?? "Không xác định"}'),
                      Text('Địa chỉ: ${firstItem.diaChi ?? "Không xác định"}'),
                    ],
                  ),
                ),
                Divider(),
                // Phần danh sách sản phẩm
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.asset(
                            item.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.tenSanPham),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Số lượng: ${item.soLuong}'),
                              Text('Giá: ${item.gia.toStringAsFixed(2)} VND'),
                              Text('Tổng: ${(item.soLuong * item.gia).toStringAsFixed(2)} VND'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
