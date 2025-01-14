import 'package:doan_hk2/nutmau.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

class Thongtincanhan extends StatefulWidget {
  const Thongtincanhan({super.key});

  @override
  State<Thongtincanhan> createState() => _ThongtincanhanState();
}

class _ThongtincanhanState extends State<Thongtincanhan> {
  final LoginService _userService = LoginService();
  Map<String, dynamic>? _userInfo;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      final userInfo = await _userService.fetchCurrentUserInfo();
      setState(() {
        _userInfo = userInfo;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserInfo(Map<String, dynamic> updatedInfo) async {
    try {
      // Kết hợp dữ liệu hiện có với dữ liệu cập nhật
      final updatedUserInfo = {...?_userInfo, ...updatedInfo};
      await _userService.updateUserInfo(updatedUserInfo);

      // Cập nhật dữ liệu giao diện
      setState(() {
        _userInfo = updatedUserInfo;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cập nhật thông tin thành công!"))
      );
    } catch (error) {
      setState(() {
        _error = error.toString();
      });
    }
  }

  void _showEditDialog(String fieldKey, String currentValue) {
    TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chỉnh sửa thông tin'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nhập giá trị mới'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _updateUserInfo({fieldKey: controller.text});
                Navigator.pop(context);
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Trangchu())),
          child: const Text("Fruit Paradise", style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text('Lỗi: $_error'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Thông tin tài khoản", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      Text('Xin chào, ${_userInfo?['TenDangNhap'] ?? 'Chưa có dữ liệu'}!',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRow(
                              icon: Icons.account_circle,
                              label: 'Họ Tên:',
                              value: _userInfo?['HoTen'] ?? 'Chưa cập nhật',
                              onEdit: () => _showEditDialog('HoTen', _userInfo?['HoTen'] ?? ''),
                            ),
                            InfoRow(
                              icon: Icons.boy,
                              label: 'Giới Tính:',
                              value: _userInfo?['GioiTinh'] ?? 'Chưa cập nhật',
                              onEdit: () => _showEditDialog('GioiTinh', _userInfo?['GioiTinh'] ?? ''),
                            ),
                            InfoRow(
                              icon: Icons.date_range,
                              label: 'Ngày Sinh:',
                              value: _userInfo?['NgaySinh'] ?? 'Chưa cập nhật',
                              onEdit: () => _showEditDialog('NgaySinh', _userInfo?['NgaySinh'] ?? ''),
                            ),
                            InfoRow(
                              icon: Icons.location_on,
                              label: 'Địa chỉ:',
                              value: _userInfo?['DiaChi'] ?? 'Chưa cập nhật',
                              onEdit: () => _showEditDialog('DiaChi', _userInfo?['DiaChi'] ?? ''),
                            ),
                            InfoRow(
                              icon: Icons.phone,
                              label: 'Điện thoại:',
                              value: _userInfo?['SoDienThoai'] ?? 'Chưa cập nhật',
                              onEdit: () => _showEditDialog('SoDienThoai', _userInfo?['SoDienThoai'] ?? ''),
                            ),
                            InfoRow(
                              icon: Icons.mail,
                              label: 'Email:',
                              value: _userInfo?['Email'] ?? 'Chưa cập nhật',
                              onEdit: () => _showEditDialog('Email', _userInfo?['Email'] ?? ''),
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onEdit;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyle(color: Colors.grey[700]), overflow: TextOverflow.ellipsis)),
          IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: onEdit),
        ],
      ),
    );
  }
}
