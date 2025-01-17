import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/model/donhang_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonHangChoXacNhan extends StatefulWidget {
  @override
  DonHangChoXacNhanState createState() => DonHangChoXacNhanState();
}

class DonHangChoXacNhanState extends State<DonHangChoXacNhan> {
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

  // Hàm lọc đơn hàng theo trạng thái
  List<Order> _filterOrders(List<Order> orders) {
    return orders.where((order) => order.trangThai == "ChoXacNhan").toList();
  }

  // Hàm hủy đơn hàng
  void _cancelOrder(int orderId) async {
    final result = await orderService.cancelOrder(orderId); // Gọi API hủy đơn hàng

    if (result['success']) {
      // Hiển thị thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đơn hàng #$orderId đã được hủy thành công!')),
      );
      // Tải lại danh sách đơn hàng
      _loadOrders();
    } else {
      // Hiển thị lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: ${result['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách đơn hàng'),
        automaticallyImplyLeading: false, // Bỏ nút back
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
                    final filteredOrders = _filterOrders(allOrders); // Lọc đơn hàng theo trạng thái
                    if (filteredOrders.isEmpty) {
                      return Center(child: Text('Không có đơn hàng nào với trạng thái "Chờ xác nhận"'));
                    }
                    return ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return ListTile(
                          title: Text('Đơn hàng #${order.donHangID}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ngày đặt: ${order.ngayDat.toLocal()}'),
                              Text('Trạng thái: ${order.trangThai}'),
                              Text('${order.tongTien} VND'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Xác nhận'),
                                    content: Text('Bạn có chắc chắn muốn hủy đơn hàng #${order.donHangID}?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: Text('Không'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: Text('Có'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirm == true) {
                                _cancelOrder(order.donHangID);
                              }
                            },
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
