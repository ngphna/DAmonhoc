import 'package:doan_hk2/ChiTietDonHang.dart';
import 'package:flutter/material.dart';
import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/model/donhang_model.dart';

class AdminDonHangChoXacNhan extends StatefulWidget {
  @override
  _AdminDonHangChoXacNhanState createState() => _AdminDonHangChoXacNhanState();
}

class _AdminDonHangChoXacNhanState extends State<AdminDonHangChoXacNhan> {
  late Future<List<Order>> orders = Future.value([]); // Giá trị mặc định
  final LoginService orderService = LoginService();

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  // Hàm tải đơn hàng từ API và lọc theo trạng thái
  void _loadOrders() {
    setState(() {
      orders = orderService.getDonHang(); // Gọi API lấy đơn hàng trạng thái "ChoXacNhan"
    });
  }

  // Hàm lọc đơn hàng theo trạng thái (nếu cần)
  List<Order> _filterOrders(List<Order> orders) {
    return orders.where((order) => order.trangThai == "ChoXacNhan").toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách đơn hàng'),
      ),
      body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    children: [
      Container(
        height: MediaQuery.of(context).size.height - 200, // Đảm bảo ListView có chiều cao hợp lý
        child: FutureBuilder<List<Order>>(
          future: orders,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Có lỗi xảy ra: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Không có đơn hàng nào.'));
                  } else {
                    final allOrders = snapshot.data!; // Lấy tất cả đơn hàng
                    return ListView.builder(
                      itemCount: allOrders.length,
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
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chitietdonhang(),
                      ),
                    ),
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
