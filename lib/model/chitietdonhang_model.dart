class ChiTietDH {
  final int sanPhamID;
  final String tenSanPham;
  final int gia;
  final int soLuong;
  final String image;
  final String? tenNguoiNhan;
  final String? sdt;
  final String? diaChi;
  final String? phuongThucThanhToan; // Phương thức thanh toán có thể là null
  final String ngayDat;
  final int tongTien;
  final String trangThai;

  ChiTietDH({
    required this.sanPhamID,
    required this.tenSanPham,
    required this.gia,
    required this.soLuong,
    required this.image,
    this.tenNguoiNhan,
    this.sdt,
    this.diaChi,
    this.phuongThucThanhToan,
    required this.ngayDat,
    required this.tongTien,
    required this.trangThai,
  });

  factory ChiTietDH.fromJson(Map<String, dynamic> json) {
    return ChiTietDH(
      sanPhamID: json['SanPhamID'],
      tenSanPham: json['TenSanPham'],
      gia: int.parse(json['Gia'].toString()),
      soLuong: json['SoLuong'],
      image: json['Image'],
      tenNguoiNhan: json['TenNguoiNhan'],
      sdt: json['SDT'],
      diaChi: json['DiaChi'],
      phuongThucThanhToan: json['PhuongThucThanhToan'], // có thể null
      ngayDat: json['NgayDat'],
      tongTien: int.parse(json['TongTien'].toString()),
      trangThai: json['TrangThai'],
    );
  }
}
