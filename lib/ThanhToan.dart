import 'package:doan_hk2/DiaChiGiao.dart';
import 'package:doan_hk2/DonhangTT.dart';
import 'package:doan_hk2/Giohang.dart';
import 'package:doan_hk2/trangchu.dart';
import 'package:flutter/material.dart';
import 'nutmau.dart';
import 'khuyenmai.dart';
import 'product_item_model.dart';
import 'api_service.dart';

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
  int? globalDiscount;

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
      // Handle error if needed
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

  void updateDiscount(int newDiscount) {
    setState(() {
      globalDiscount = newDiscount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    String ten = '';
    String sdt = '';
    String diachi = '';
    
    if (arguments != null && arguments is Map<String, dynamic>) {
      ten = arguments['ten'] ?? ten;
      sdt = arguments['sdt'] ?? sdt;
      diachi = arguments['diachi'] ?? diachi;
    }

    // Tính tổng tiền
    int total = productsInCart.fold(0, (sum, item) => sum + (item.price * item.quantity));

    // Tính tiền giảm giá
    double tkm = (total * ((globalDiscount ?? 0) / 100));
    double tienskm = total - tkm;

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
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Thanh Toán Hóa Đơn',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomButton(
                    text: "Đơn hàng",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonhangTT(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 20,),
                    CustomButton(
                    text: "Chọn địa chỉ",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiaChiGiao(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildTextField('Tên Người Nhận', controller: tenController),
              _buildTextField('Số điện Thoại', controller: sdtController),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                
                ],
              ),
              _buildTextField('Địa Chỉ', maxLines: 3, controller: diachiController),
              const SizedBox(height: 10),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Phương Thức Thanh Toán',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
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
                      ),
                      SizedBox(
                        height: 150,
                        child: PromotionsScreens(
                          onSelectPromotion: (int km) {
                            setState(() {
                              globalDiscount = km;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text("Tổng Tiền: $total đ"),
                              const SizedBox(height: 5),
                              Text(tkm <= 0 ? "Giảm : 0 đ" : "Giảm: -${tkm.toStringAsFixed(0)} đ"),
                              const SizedBox(height: 5),
                              Text(
                                "Thành Tiền: ${tienskm.toStringAsFixed(0)} đ",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),
                      Center(
                        child: CustomButton(
                          text: "Thanh toán",
                          onPressed: () {
                            if(_selectedPaymentMethod =="Chuyển Khoản"){
                               showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Chuyển Khoản"),
                                          content: Image.asset('assets/thanhtoan.jpg'),
                                          actions: [
                                             TextButton(
                                              child: Text("Hoàn Tất Thanh Toán"),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context
                                                  , MaterialPageRoute(builder: (context)=>Trangchu()));
                                                
                                                // Đóng dialog
                                              },
                                            ),
                                            TextButton(
                                              child: Text("Hủy"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Đóng dialog
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                            }
                            else{
                               showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Tiền Mặt "),
                                          content: Text("Thanh Toán Bằng Tiền Mặt"),
                                          actions: [
                                             TextButton(
                                              child: Text("Hoàn Tất Thanh Toán"),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context
                                                  , MaterialPageRoute(builder: (context)=>Trangchu()));
                                                
                                                // Đóng dialog
                                              },
                                            ),
                                           
                                            TextButton(
                                              child: Text("Hủy"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Đóng dialog
                                              },
                                            ),
                                             TextButton(
                                              child: Text("Hoàn Tất Thanh Toán"),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context
                                                  , MaterialPageRoute(builder: (context)=>Trangchu()));
                                                
                                                // Đóng dialog
                                              },
                                            ),
                                          ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1, TextEditingController? controller}) {
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
}
