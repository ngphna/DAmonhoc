import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/model/chitietdonhang_model.dart';
import 'package:doan_hk2/model/donhang_model.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:doan_hk2/view/ChiTietDonHang.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DanhSachDonHang extends StatefulWidget {
  @override
  DanhSachDonHangState createState() => DanhSachDonHangState();
}

class DanhSachDonHangState extends State<DanhSachDonHang> {
  late Future<List<Order>> orders = Future.value([]); // Giá trị mặc định
  final LoginService orderService = LoginService();
  String? tenDangNhap;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  // Hàm tải TenDangNhap từ SharedPreferences và gọi API
  void _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('TenDangNhap');

    if (username != null && username.isNotEmpty) {
      setState(() {
        tenDangNhap = username;
        orders = orderService.fetchOrdersByUsername(username); // Gọi API
      });
    } else {
      setState(() {
        orders = Future.error('Không tìm thấy tên đăng nhập');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách đơn hàng'),
        automaticallyImplyLeading: false,// Bỏ nút back
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Trangchu(),
              ),
            );
            }, 
            
          )
        ], 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (tenDangNhap != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Tên đăng nhập: $tenDangNhap',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            Expanded(
              child: FutureBuilder<List<Order>>(
                future: orders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Có lỗi xảy ra: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Không có đơn hàng nào'));
                  } else {
                    final allOrders = snapshot.data!;
                    return ListView.builder(
                      itemCount: allOrders.length, // Hiển thị tất cả đơn hàng
                      itemBuilder: (context, index) {
                        final order = allOrders[index];
                        return ListTile(
                          title: Text('Đơn hàng #${order.donHangID}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ngày đặt: ${order.ngayDat.toLocal()}'),
                              Text('Trạng thái: ${order.trangThai}'),
                            ],
                          ),
                          trailing: Text('${order.tongTien} VND'),
                          onTap: (){
                            // Chuyển đến trang chi tiết đơn hàng
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(tenDangNhap:'$tenDangNhap',donHangID: order.donHangID,),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
