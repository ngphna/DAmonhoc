<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

$data = json_decode(file_get_contents("php://input"));

if (!isset($data->username) || !isset($data->password)) {
    echo json_encode(["success" => false, "message" => "Thiếu thông tin đăng nhập!"]);
    exit();
}

$username = $data->username;
$password = $data->password;

try {
    $stmt = $conn->prepare("SELECT MatKhau FROM TaiKhoan WHERE TaiKhoanID = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $hashed_password = $row['MatKhau'];

        if (password_verify($password, $hashed_password)) {
            echo json_encode(["success" => true, "message" => "Đăng nhập thành công!"]);
        } else {
            echo json_encode(["success" => false, "message" => "Mật khẩu không chính xác!"]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "Tài khoản không tồn tại!"]);
    }

    $stmt->close();
    $conn->close();
} catch (mysqli_sql_exception $e) {
    echo json_encode(["success" => false, "message" => "Lỗi: " . $e->getMessage()]);
}
?>
