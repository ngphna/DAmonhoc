// trangtimkiem.dart
import 'package:flutter/material.dart';
import 'danhsachtraicay.dart';

class TrangTimKiem extends StatelessWidget {
  final List<dynamic> searchResults;

  const TrangTimKiem({Key? key, required this.searchResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kết quả tìm kiếm"),
        backgroundColor: Colors.lightGreen,
      ),
      body: searchResults.isEmpty
          ? const Center(child: Text('Không có sản phẩm nào phù hợp!'))
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final product = searchResults[index];
                return ListTile(
                  title: Text(product['TenSanPham']),
                  subtitle: Text('Giá: ${product['Gia']}'),
                  leading: Image.asset(product['Image']),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                          name: product['TenSanPham'],
                          id: product['SanPhamID'],
                          price: product['Gia'],
                          image: product['Image'],
                          status: product['TrangThai'] ?? 'Còn hàng',
                          mota: product['MoTa'] ?? 'Không có mô tả',
                          soluong: product['SoLuong'] ?? '1',
                          donvi: product['DonVi'] ?? 'ko co',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
