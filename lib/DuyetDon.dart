import 'package:doan_hk2/DangNhap.dart';
import 'package:flutter/material.dart';
import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/model/donhang_model.dart';
import 'package:doan_hk2/trangchu.dart';

class DuyetDon extends StatefulWidget {
  @override
  DuyetDonState createState() => DuyetDonState();
}

class DuyetDonState extends State<DuyetDon> {
  late Future<List<Order>> orders;
  String selectedStatus = 'ChoXacNhan'; // Trạng thái được chọn mặc định

  @override
  void initState() {
    super.initState();
    fetchFilteredOrders(); // Gọi hàm lấy danh sách đơn hàng theo trạng thái
  }

  void fetchFilteredOrders() {
    orders = LoginService().fetchOrders().then(
          (allOrders) =>
              allOrders.where((order) => order.trangThai == selectedStatus).toList(),
        );
  }

  Future<void> updateOrderStatus(int donHangID) async {
    try {
      final response = await LoginService().updateOrderStatus(donHangID, 'DaXacNhan');
      if (response) {
        setState(() {
          fetchFilteredOrders(); // Cập nhật lại danh sách đơn hàng sau khi xác nhận
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đơn hàng đã được xác nhận.')),
        );
      } else {
        throw Exception('Không thể cập nhật trạng thái đơn hàng.');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Danh sách tất cả đơn hàng",
            style: TextStyle(color: Colors.black),
          ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.white),
            onSelected: (value) {
              if (value == "Dangxuat") {
                Navigator.of(context, rootNavigator: true).pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) => DangNhap(),
                );
              } 
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: "Dangxuat",
                child: Text("Đăng xuất"),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // DropdownButton để chọn trạng thái lọc
            Row(
              children: [
                const Text(
                  'Trạng thái: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedStatus,
                  items: [
                    'ChoXacNhan',
                    'DaXacNhan',
                    'DangGiao',
                    'DaGiao',
                    'DaHuy',
                  ].map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedStatus = value;
                        fetchFilteredOrders(); // Cập nhật danh sách đơn hàng khi trạng thái thay đổi
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder<List<Order>>(
                future: orders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Có lỗi xảy ra: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có đơn hàng nào.'));
                  } else {
                    final filteredOrders = snapshot.data!;
                    return ListView.builder(
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text('Đơn hàng #${order.donHangID}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ngày đặt: ${order.ngayDat.toLocal()}'),
                                Text('Tổng tiền: ${order.tongTien} VND'),
                                Text('Trạng thái: ${order.trangThai}'),
                              ],
                            ),
                            trailing: selectedStatus == 'ChoXacNhan'
                                ? ElevatedButton(
                                    onPressed: () {
                                      updateOrderStatus(order.donHangID);
                                    },
                                    child: const Text('Xác nhận'),
                                  )
                                : null,
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
