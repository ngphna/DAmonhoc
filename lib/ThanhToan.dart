import 'package:doan_hk2/DiaChiGiao.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/api_service.dart';
import 'package:doan_hk2/model/diachi_model.dart';
import 'package:flutter/material.dart';
import 'nutmau.dart';
class Thanhtoan extends StatefulWidget {
  const Thanhtoan({super.key});
 
  

  @override
  State<StatefulWidget> createState() => ThanhtoanSate();
}

class ThanhtoanSate extends State<Thanhtoan> {
  String _selectedPaymentMethod = 'Chuyển Khoản';

  final TextEditingController tenController = TextEditingController();
  final TextEditingController sdtController = TextEditingController();
  final TextEditingController diachiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
  }

 
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    String ten = '';
    String sdt = '';
    String diachi = '';

    if (arguments != null && arguments is Map<String, String>) {
      ten = arguments['ten'] ?? '';
      sdt = arguments['sdt'] ?? '';
      diachi = arguments['diachi'] ?? '';
    }
    tenController.text = ten;
    sdtController.text = sdt;
    diachiController.text = diachi;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Giohang(),
              ),
            );
          },
          child: const Text(
            "Fruit Paradise",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thành Tiền: 130.000.000đ',
              style: TextStyle(color: Colors.red, fontSize: 24),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Mã giảm giá',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text('Sử dụng'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Nút chọn địa chỉ từ sổ địa chỉ
            CustomButton(
              text: "Chọn địa chỉ",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiaChiGiao(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            
            const Text('Thông tin giao hàng', style: TextStyle(fontSize: 20)),
            _buildTextField('Họ và Tên',controller: tenController),
            _buildTextField('Số điện Thoại',controller: sdtController),
            _buildTextField('Địa Chỉ',controller: diachiController),
            const SizedBox(height: 20),
            const Text('Phương Thức Thanh Toán', style: TextStyle(fontSize: 20)),
            Row(
              children: [
                Radio(
                  value: 'Chuyển Khoản',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                const Text('Chuyển Khoản'),
                const SizedBox(width: 20),
                Radio(
                  value: 'Sau khi nhận hàng',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                const Text('Sau khi nhận hàng'),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomButton(
                text: "Thanh toán",
                onPressed: () {
                  // Xử lý thanh toán
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm tạo TextField với controller truyền vào
  Widget _buildTextField(String hint, {int maxLines = 1, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
