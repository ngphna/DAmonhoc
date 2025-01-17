<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->username) || !isset($data->password) || !isset($data->email) || !isset($data->phone)) {
    echo json_encode(["success" => false, "message" => "Thiếu thông tin!"]);
    exit();
}

$username = $data->username;
$password = password_hash($data->password, PASSWORD_BCRYPT); // Mã hóa mật khẩu bằng bcrypt
$email = $data->email;
$phone = $data->phone;

try {
    $stmt = $conn->prepare("INSERT INTO TaiKhoan (TenDangNhap, MatKhau, Email, SoDienThoai) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $username, $password, $email, $phone);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Đăng ký thành công!"]);
    } else {
        echo json_encode(["success" => false, "message" => "Lỗi khi đăng ký!"]);
    }

    $stmt->close();
    $conn->close();
} catch (mysqli_sql_exception $e) {
    echo json_encode(["success" => false, "message" => "Lỗi: " . $e->getMessage()]);
}
?>