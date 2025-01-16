import 'dart:ffi';

import 'package:doan_hk2/DiaChiGiao.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/api_service.dart';
import 'package:flutter/material.dart';
import 'nutmau.dart';
import 'khuyenmai.dart';
import 'product_item_model.dart';
import 'itemthanhtoan.dart';
class Thanhtoan extends StatefulWidget {
  const Thanhtoan({super.key});

  @override
  State<StatefulWidget> createState() => ThanhtoanSate();
}

class ThanhtoanSate extends State<Thanhtoan> {

  final TextEditingController tenController = TextEditingController();
  final TextEditingController sdtController = TextEditingController();
  final TextEditingController diachiController = TextEditingController();

   final LoginService cartService = LoginService();
  String? username;
  List<ProductItemModel> productsInCart = [];

  @override
  void initState() {
    super.initState();
    _loadCartProducts();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    String? loadedUsername = await cartService.getUsername();
    setState(() {
      username = loadedUsername;
    });
  }

  Future<void> _loadCartProducts() async {
    try {
      List<ProductItemModel> loadedProducts = await cartService.fetchCartProducts();
      setState(() {
        productsInCart = loadedProducts;
        
      });
    } catch (e) {
     
    }
  }

  String _selectedPaymentMethod = 'Chuyển Khoản';
void showkm(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return showkmWidget(context);
    },
  );
}

  
    // Gọi API để cập nhật số lượng sản phẩm trên server
   

  @override
  Widget build(BuildContext context) {
     final arguments = ModalRoute.of(context)?.settings.arguments;

    // Biến lưu trữ giá trị
    String ten = '';
    String sdt = '';
    String diachi = '';
    int km = 0;

    if (arguments != null) {
      if (arguments is Map<String, dynamic>) {
        // Phân tích giá trị từ cả hai màn hình
        ten = arguments['ten'] ?? ten;
        sdt = arguments['sdt'] ?? sdt;
        diachi = arguments['diachi'] ?? diachi;
        km = arguments['km'] is int
            ? arguments['km']
            : int.tryParse(arguments['km']?.toString() ?? '0') ?? 0;
      }
    }

    int total=productsInCart.fold(0, (sum, item) => sum + (item.price * item.quantity));
      double tkm=(total*((km??0)/100));
      double tienskm=total-tkm;
    
    // Gán dữ liệu từ arguments vào TextEditingController
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
       
        child: 
        
          Padding(padding: EdgeInsets.all(5),child: 
        Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Thanh Toán Hóa Đơn',
              style: TextStyle(color: Colors.red, fontSize: 24,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10,),
            
           
            const SizedBox(height: 20),
            _buildTextField('Tên Người Nhận',controller: tenController ),
            _buildTextField('Số điện Thoại',controller: sdtController),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
            ],),
            _buildTextField('Địa Chỉ', maxLines: 3),
            const SizedBox(height: 10),
            Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Màu sắc của khung
                width: 1,          // Độ dày của khung
              ),
              borderRadius: BorderRadius.circular(8), // Bo góc cho khung
            ),
                        
                        child: 
          Padding(padding: EdgeInsets.all(5),child: 
                        Column(children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [Text('Phương Thức Thanh Toán', style: TextStyle(fontSize: 20)),],),
              const SizedBox(height: 5),
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
            ],),),),
          
             const SizedBox(height: 20),
             
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
             
              CustomButton(text: "Khuyến Mãi", onPressed:(){
                
                showkm(context);
              }),
               CustomButton(text: "Đơn hàng", onPressed:(){
               _showOrderDialog(context);
              }),
            ],),
            Row(children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: [const SizedBox(height: 5),
             Text("Tổng Tiền:${productsInCart.fold(0, (sum, item) => sum + (item.price * item.quantity))} đ"),
             const SizedBox(height: 5),
            Text(tkm<=0?"Giảm : 0 đ":"Giảm: -${tkm} đ"),
            const SizedBox(height: 5),
            Text("Thành Tiền: ${tienskm} đ",style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20),],)],),
            
            Center(
              child: CustomButton(
                text: "Thanh toán",
                onPressed: () {
                  
                }
              ),                  
            ),
          ],
        ),),),
      
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1,TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        maxLines: maxLines,
        controller: controller, 
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
void _showOrderDialog(BuildContext context) {
  if (productsInCart.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Giỏ hàng của bạn đang trống!")),
    );
    return;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Đơn hàng"),
        content: SizedBox(
          height: 200,
          // child: ListView.builder(
          //   itemCount: productsInCart.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(productsInCart[index].productName),
          //       subtitle: Text("Số lượng: ${productsInCart[index].quantity}"),
          //     );
          //   },
          // ),
        ),
        actions: [
          TextButton(
            child: const Text("Đóng"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}}