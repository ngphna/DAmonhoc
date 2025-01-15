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
  Future<List<Address>>? addresses; // Đổi 'late' thành '?'
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
      if (tenDangNhap != null && tenDangNhap!.isNotEmpty) {
        // Khởi tạo lại addresses với fetchAddresses sau khi lấy tenDangNhap
        addresses = service.fetchAddresses(tenDangNhap!);
      } else {
        addresses = Future.value([]); // Nếu không có tenDangNhap, trả về danh sách trống
      }
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
                    onTap: () {
                      // Truyền DiaChiGiaoID sang màn hình ThanhToan
                      String _ten = address.ten;
                      String _sdt = address.sdt;
                      String _diachi = address.diaChi;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Thanhtoan(),
                          settings: RouteSettings(
                            arguments: {
                              'ten': _ten,
                              'sdt': _sdt,
                              'diachi': _diachi,
                            },
                          ),
                        ),
                      );
                    }
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
    if (tenDangNhap == null || tenDangNhap!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng đăng nhập để thêm địa chỉ.')),
      );
      return;
    }

    Address newAddress = Address(
      diaChiGiaoID: 0,  // Để ID tự động cấp từ server
      tenDangNhap: tenDangNhap!,
      ten: ten,
      sdt: sdt,
      diaChi: diaChi,
    );

    try {
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
                  await _addAddress(
                    tenController.text,
                    sdtController.text,
                    diaChiController.text,
                  );
                  Navigator.of(context).pop();
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
