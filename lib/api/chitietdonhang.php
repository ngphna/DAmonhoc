<?php

require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

// Kiểm tra xem TenDangNhap và DonHangID có được gửi không
if (isset($_GET['TenDangNhap']) && isset($_GET['DonHangID'])) {
    $tenDangNhap = $_GET['TenDangNhap'];
    $donHangID = $_GET['DonHangID'];

    // Truy vấn lấy chi tiết đơn hàng
    $sql = "
        SELECT 
            dh.DonHangID,
            dh.NgayDat,
            dh.TongTien,
            dh.TrangThai,
            dg.Ten AS TenNguoiNhan,
            dg.SDT,
            dg.DiaChi,
            tt.PhuongThuc AS PhuongThucThanhToan,
            ct.SanPhamID,
            ct.SoLuong,
            sp.TenSanPham,
            sp.Gia,
            sp.Image
        FROM chitietdonhang ct
        INNER JOIN donhang dh ON dh.DonHangID = ct.DonHangID
        INNER JOIN sanpham sp ON sp.SanPhamID = ct.SanPhamID
        LEFT JOIN diachigiao dg ON dh.DiaChiGiaoID = dg.DiaChiGiaoID
        LEFT JOIN thanhtoan tt ON dh.ThanhToanID = tt.ThanhToanID
        WHERE dh.TenDangNhap = '$tenDangNhap' AND dh.DonHangID = $donHangID
    ";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $orderDetails = [];
        while ($row = $result->fetch_assoc()) {
            $orderDetails[] = [
                "SanPhamID" => (int)$row["SanPhamID"],
                "TenSanPham" => $row["TenSanPham"],
                "Gia" => (int)$row["Gia"],
                "SoLuong" => (int)$row["SoLuong"],
                "Image" => $row["Image"],
                "TenNguoiNhan" => $row["TenNguoiNhan"],
                "SDT" => $row["SDT"],
                "DiaChi" => $row["DiaChi"],
                "PhuongThucThanhToan" => $row["PhuongThucThanhToan"],
                "NgayDat" => $row["NgayDat"],
                "TongTien" => (int)$row["TongTien"],
                "TrangThai" => $row["TrangThai"]
            ];
        }
        echo json_encode(["success" => true, "orderDetails" => $orderDetails]);
    } else {
        echo json_encode(["success" => false, "message" => "Không có chi tiết đơn hàng"]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Thiếu tham số TenDangNhap hoặc DonHangID"]);
}

$conn->close();
?>
