class Address {
  final int diaChiGiaoID;
  final String tenDangNhap;
  final String ten;
  final String sdt;
  final String diaChi;

  Address({
    required this.diaChiGiaoID,
    required this.tenDangNhap,
    required this.ten,
    required this.sdt,
    required this.diaChi,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
  return Address(
    diaChiGiaoID: int.parse(json['DiaChiGiaoID'].toString()),
    tenDangNhap: json['TenDangNhap'].toString(),
    ten: json['Ten'].toString(), // Đổi SDT thành Ten
    sdt: json['SDT'].toString(), // Đổi Ten thành SDT
    diaChi: json['DiaChi'].toString(),
  );
}

// Phương thức chuyển đối tượng thành JSON để gửi lên server
  Map<String, dynamic> toJson() {
    return {
      'DiaChiGiaoID': diaChiGiaoID,
      'TenDangNhap': tenDangNhap,
      'Ten': ten,
      'SDT': sdt,
      'DiaChi': diaChi,
    };
  }

}
