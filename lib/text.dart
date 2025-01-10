import 'package:doan_hk2/Giohang.dart';
import 'package:flutter/material.dart';
import 'nutmau.dart';
class Thanhtoan extends StatefulWidget {
  const Thanhtoan({super.key});

  @override
  State<StatefulWidget> createState() => ThanhtoanSate();
}

class ThanhtoanSate extends State<Thanhtoan> {
  String _selectedPaymentMethod = 'Chuyển Khoản';

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
            const SizedBox(height: 20),
            const Text('Thông tin giao hàng', style: TextStyle(fontSize: 20)),
            _buildTextField('Họ và Tên'),
            _buildTextField('Số điện Thoại'),
            _buildTextField('Email'),
            _buildTextField('Tỉnh'),
            _buildTextField('Huyện'),
            _buildTextField('Xã'),
            _buildTextField('Địa Chỉ', maxLines: 3),
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
                                  onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
