<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Import file cấu hình CSDL
require_once 'config.php';

// Đọc dữ liệu từ body request
$data = json_decode(file_get_contents("php://input"), true);

// Kiểm tra nếu không có dữ liệu hoặc thiếu TenDangNhap
if (!isset($data['username']) || empty($data['username'])) {
    echo json_encode(["success" => false, "message" => "Thiếu thông tin TenDangNhap"]);
    exit;
}

$username = $data['username'];

// **Xác định loại yêu cầu: Lấy hoặc Cập nhật dữ liệu**
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Lấy thông tin người dùng nếu chỉ có username
    if (count($data) == 1) {
        $stmt = $conn->prepare("SELECT * FROM taikhoan WHERE TenDangNhap = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $userData = $result->fetch_assoc();
            echo json_encode(["success" => true, "data" => $userData]);
        } else {
            echo json_encode(["success" => false, "message" => "Không tìm thấy tài khoản"]);
        }
        $stmt->close();
        $conn->close();
        exit;
    }

    // Cập nhật thông tin người dùng nếu có nhiều hơn 1 trường
    $hoTen = $data['HoTen'] ?? '';
    $gioiTinh = $data['GioiTinh'] ?? '';
    $ngaySinh = $data['NgaySinh'] ?? '';
    $diaChi = $data['DiaChi'] ?? '';
    $soDienThoai = $data['SoDienThoai'] ?? '';
    $email = $data['Email'] ?? '';

    $stmt = $conn->prepare("
        UPDATE taikhoan 
        SET HoTen = ?, GioiTinh = ?, NgaySinh = ?, DiaChi = ?, SoDienThoai = ?, Email = ? 
        WHERE TenDangNhap = ?
    ");
    $stmt->bind_param("sssssss", $hoTen, $gioiTinh, $ngaySinh, $diaChi, $soDienThoai, $email, $username);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Cập nhật thông tin thành công"]);
    } else {
        echo json_encode(["success" => false, "message" => "Cập nhật thất bại: " . $stmt->error]);
    }

    $stmt->close();
    $conn->close();
}
?>
