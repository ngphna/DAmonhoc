import 'package:doan_hk2/ThanhToan.dart';
import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/model/diachi_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaChiGiao extends StatefulWidget {
  @override
  DiaChiGiaoState createState() => DiaChiGiaoState();
}

class DiaChiGiaoState extends State<DiaChiGiao> {
  late Future<List<Address>> addresses;
  String? tenDangNhap;

  final LoginService service = LoginService();

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Hàm để lấy TenDangNhap từ SharedPreferences
  Future<void> _loadUsername() async {
    String? username = await getUsername();
    setState(() {
      tenDangNhap = username;
      // Nếu có tên đăng nhập, bạn có thể gọi lại fetchAddresses với giá trị mới
      addresses = LoginService().fetchAddresses(tenDangNhap ?? '');
    });
  }

  // Lấy TenDangNhap từ SharedPreferences
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('TenDangNhap');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Thanhtoan(),
              ),
            );
          },
          child: const Text(
            "Fruit Paradise",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder<List<Address>>(
        future: addresses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có địa chỉ nào."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final address = snapshot.data![index];
                return Card(
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Họ và Tên: ${address.ten}"),
                        Text("SĐT: ${address.sdt}"),
                        Text("Địa chỉ: ${address.diaChi}"),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Chức năng thêm
          _showAddAddressDialog();
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }

  // Hàm thêm địa chỉ
  Future<void> _addAddress(String ten, String sdt, String diaChi) async {
    // Kiểm tra xem tenDangNhap có sẵn không
    if (tenDangNhap == null || tenDangNhap!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng đăng nhập để thêm địa chỉ.')),
      );
      return;
    }

    Address newAddress = Address(
      diaChiGiaoID: 0, // Có thể để là 0, ID tự động tăng sẽ được cấp từ server
      tenDangNhap: tenDangNhap!,
      ten: ten,
      sdt: sdt,
      diaChi: diaChi,
    );

    try {
      // Gọi hàm để thêm địa chỉ vào server
      await service.addAddress(newAddress);
      setState(() {
        // Cập nhật lại danh sách địa chỉ
        addresses = service.fetchAddresses(tenDangNhap!);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Địa chỉ đã được thêm thành công.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi thêm địa chỉ: $e')),
      );
    }
  }

  // Hàm hiện dialog để thêm địa chỉ
  void _showAddAddressDialog() {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController tenController = TextEditingController();
    final TextEditingController sdtController = TextEditingController();
    final TextEditingController diaChiController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm Địa Chỉ Giao Hàng'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: tenController,
                  decoration: InputDecoration(labelText: 'Họ và Tên'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập họ và tên';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: sdtController,
                  decoration: InputDecoration(labelText: 'SĐT'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: diaChiController,
                  decoration: InputDecoration(labelText: 'Địa Chỉ'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập địa chỉ';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Gửi yêu cầu thêm địa chỉ
                  await _addAddress(
                    tenController.text,
                    sdtController.text,
                    diaChiController.text,
                  );
                  Navigator.of(context).pop(); // Đóng dialog
                }
              },
              child: Text('Thêm'),
            ),
          ],
        );
      },
    );
  }
}
