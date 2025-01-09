import 'package:doan_hk2/DangNhap.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';

class Thongtincanhan extends StatefulWidget {
  const Thongtincanhan({super.key});

  @override
  State<Thongtincanhan> createState() => ThongtincanhanState();
}

class ThongtincanhanState extends State<Thongtincanhan> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Trangchu(),
              ),
            );
          },
          child: const Text(
            "Fruit Paradise",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        actions: [
          
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.white),
            onSelected: (value) {
              // Xử lý khi chọn menu
              if (value == "Dangxuat") {
                Navigator.of(context, rootNavigator: true).pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) => DangNhap(),
                );
              } else if (value == "Thongtin") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Thongtincanhan(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: "Dangxuat",
                child: Text("Đăng xuất"),
              ),
              const PopupMenuItem(
                value: "Thongtin",
                child: Text("Thông tin cá nhân"),
              ),
            ],
          ),
        ],
   ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thông tin tài khoản",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20,),
          const Text(
            'Xin chào, vo tuan!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'TÀI KHOẢN CỦA TÔI',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20,),
                    IconButton(
                        onPressed: (){
                          
                        }, 
                        icon: Icon(Icons.edit)
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                const InfoRow(icon: Icons.location_on, label: 'Địa chỉ:', value: '1025 Phú Thuận Q7 TPHGM'),
                const InfoRow(icon: Icons.phone, label: 'Điện thoại:', value: '09781243'),

                const InfoRow(icon: Icons.mail, label: 'Email:', value: 'vominhtuan@gmail.com'),

              ],
            ),
          ),
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sổ địa chỉ (1)',
                style: TextStyle(fontSize: 16),
              ),
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

  const InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
