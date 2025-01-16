<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

// Kết nối đến database
$conn = new mysqli("localhost", "root", "", "ten_database");

if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Kết nối thất bại: " . $conn->connect_error]));
}

// Lấy danh sách đơn hàng kèm thông tin chi tiết
$sql = "
    SELECT 
        dh.DonHangID,
        dh.TenDangNhap,
        dg.Ten AS TenNguoiNhan,
        dg.SDT,
        dg.DiaChi,
        tt.PhuongThuc AS PhuongThucThanhToan,
        dh.TongTien,
        dh.TrangThai,
        dh.NgayDat
    FROM donhang dh
    LEFT JOIN diachigiao dg ON dh.DiaChiGiaoID = dg.DiaChiGiaoID
    LEFT JOIN thanhtoan tt ON dh.ThanhToanID = tt.ThanhToanID
    ORDER BY dh.NgayDat DESC
";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $orders = [];
    while ($row = $result->fetch_assoc()) {
        $orders[] = [
            "DonHangID" => $row["DonHangID"],
            "TenDangNhap" => $row["TenDangNhap"],
            "TenNguoiNhan" => $row["TenNguoiNhan"],
            "SDT" => $row["SDT"],
            "DiaChi" => $row["DiaChi"],
            "PhuongThucThanhToan" => $row["PhuongThucThanhToan"],
            "TongTien" => $row["TongTien"],
            "TrangThai" => $row["TrangThai"],
            "NgayDat" => $row["NgayDat"],
        ];
    }
    echo json_encode(["success" => true, "orders" => $orders]);
} else {
    echo json_encode(["success" => false, "message" => "Không có đơn hàng nào."]);
}

$conn->close();
?>
