<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// Lấy dữ liệu từ phương thức POST
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['TenDangNhap']) && isset($data['Ten']) && isset($data['SDT']) && isset($data['DiaChi'])) {
    $TenDangNhap = $data['TenDangNhap'];
    $Ten = $data['Ten'];
    $SDT = $data['SDT'];
    $DiaChi = $data['DiaChi'];

    // Kiểm tra xem TenDangNhap có tồn tại trong bảng TaiKhoan
    $checkUserQuery = "SELECT * FROM taikhoan WHERE TenDangNhap = ?";
    $stmt = $conn->prepare($checkUserQuery);
    $stmt->bind_param('s', $TenDangNhap);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // TenDangNhap tồn tại, thực hiện chèn dữ liệu vào bảng DiaChiGiao
        $insertQuery = "INSERT INTO DiaChiGiao (TenDangNhap, Ten, SDT, DiaChi) VALUES (?, ?, ?, ?)";
        $stmt = $conn->prepare($insertQuery);
        $stmt->bind_param('ssss', $TenDangNhap, $Ten, $SDT, $DiaChi);

        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Địa chỉ giao hàng đã được thêm thành công.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Lỗi khi thêm địa chỉ giao hàng.']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Tên đăng nhập không tồn tại.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Dữ liệu không hợp lệ.']);
}
?>
