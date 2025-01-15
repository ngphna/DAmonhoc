<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');

// Lấy dữ liệu từ phương thức POST
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['TenDangNhap']) && isset($data['SanPhamID']) && isset($data['SoLuong'])) {
    $TenDangNhap = $data['TenDangNhap'];
    $SanPhamID = (int) $data['SanPhamID'];
    $SoLuong = (int) $data['SoLuong'];

    // Kiểm tra xem TenDangNhap có tồn tại trong bảng TaiKhoan
    $checkUserQuery = "SELECT * FROM taikhoan WHERE TenDangNhap = ?";
    $stmt = $conn->prepare($checkUserQuery);
    $stmt->bind_param('s', $TenDangNhap);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        $checkQuery = "SELECT * FROM giohang WHERE TenDangNhap = ? AND SanPhamID = ?";
        $stmt = $conn->prepare($checkQuery);
        $stmt->bind_param('si', $TenDangNhap, $SanPhamID);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // Nếu sản phẩm đã có, cập nhật số lượng
            $updateQuery = "UPDATE giohang SET SoLuong = SoLuong + ? WHERE TenDangNhap = ? AND SanPhamID = ?";
            $stmt = $conn->prepare($updateQuery);
            $stmt->bind_param('isi', $SoLuong, $TenDangNhap, $SanPhamID);
            if ($stmt->execute()) {
                echo json_encode(["status" => "success", "message" => "Cập nhật số lượng sản phẩm thành công."]);
            } else {
                echo json_encode(["status" => "error", "message" => "Cập nhật thất bại."]);
            }
        } else {
            // Nếu sản phẩm chưa có, thêm vào giỏ hàng
            $insertQuery = "INSERT INTO giohang (TenDangNhap, SanPhamID, SoLuong) VALUES (?, ?, ?)";
            $stmt = $conn->prepare($insertQuery);
            $stmt->bind_param('sii', $TenDangNhap, $SanPhamID, $SoLuong);
            if ($stmt->execute()) {
                echo json_encode(["status" => "success", "message" => "Thêm sản phẩm vào giỏ hàng thành công."]);
            } else {
                echo json_encode(["status" => "error", "message" => "Thêm sản phẩm thất bại."]);
            }
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Tên đăng nhập không hợp lệ."]);
    }

    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Dữ liệu không hợp lệ."]);
}

$conn->close();
?>
