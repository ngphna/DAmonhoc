class Order {
  final int donHangID;
  final String tenDangNhap;
  final int khuyenMaiID;
  final int thanhToanID;
  final int diaChiGiaoID;
  final DateTime ngayDat;
  final int tongTien;
  final String trangThai;

  Order({
    required this.donHangID,
    required this.tenDangNhap,
    required this.khuyenMaiID,
    required this.thanhToanID,
    required this.diaChiGiaoID,
    required this.ngayDat,
    required this.tongTien,
    required this.trangThai,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      donHangID: int.parse(json['DonHangID'].toString()),
      tenDangNhap: json['TenDangNhap'].toString(),
      khuyenMaiID: int.parse(json['KhuyenMaiID'].toString()),
      thanhToanID: int.parse(json['ThanhToanID'].toString()),
      diaChiGiaoID: int.parse(json['DiaChiGiaoID'].toString()),
      ngayDat: DateTime.parse(json['NgayDat'].toString()),
      tongTien: int.parse(json['TongTien'].toString()),
      trangThai: json['TrangThai'].toString(),
    );
  }

  // Phương thức chuyển đối tượng thành JSON để gửi lên server
  Map<String, dynamic> toJson() {
    return {
      'DonHangID': donHangID,
      'TenDangNhap': tenDangNhap,
      'KhuyenMaiID': khuyenMaiID,
      'ThanhToanID': thanhToanID,
      'DiaChiGiaoID': diaChiGiaoID,
      'NgayDat': ngayDat.toIso8601String(),
      'TongTien': tongTien,
      'TrangThai': trangThai,
    };
  }
}
