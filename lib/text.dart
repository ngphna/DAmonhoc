import 'package:flutter/material.dart';

class Thanhtoan extends StatefulWidget {
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
        title: Text('Fruit Paradise', style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thành Tiền: 130.000.000đ',
              style: TextStyle(color: Colors.red, fontSize: 24),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Mã giảm giá',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Text('Sử dụng'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Thông tin giao hàng', style: TextStyle(fontSize: 20)),
            _buildTextField('Họ và Tên'),
            _buildTextField('Số điện Thoại'),
            _buildTextField('Email'),
            _buildTextField('Tỉnh'),
            _buildTextField('Huyện'),
            _buildTextField('Xã'),
            _buildTextField('Địa Chỉ', maxLines: 3),
            SizedBox(height: 20),
            Text('Phương Thức Thanh Toán', style: TextStyle(fontSize: 20)),
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
                Text('Chuyển Khoản'),
                SizedBox(width: 20),
                Radio(
                  value: 'Sau khi nhận hàng',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                Text('Sau khi nhận hàng'),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Thanh Toán', style: TextStyle(fontSize: 18)),
              ),
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
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
