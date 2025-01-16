<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// Kiểm tra phương thức HTTP
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Phương thức không được hỗ trợ. Vui lòng sử dụng POST."
    ]);
    exit;
}

// Nhận ID đơn hàng từ yêu cầu
$data = json_decode(file_get_contents("php://input"), true);
$orderID = $data['orderID'] ?? null;

if (!$orderID) {
    echo json_encode([
        "success" => false,
        "message" => "Vui lòng cung cấp ID đơn hàng."
    ]);
    exit;
}

// Cập nhật trạng thái đơn hàng thành 'HuyDon'
$sqlUpdate = "UPDATE DonHang SET TrangThai = 'DaHuy' WHERE DonHangID = ?";
$stmt = $conn->prepare($sqlUpdate);
$stmt->bind_param('i', $orderID);

if ($stmt->execute() && $stmt->affected_rows > 0) {
    echo json_encode([
        "success" => true,
        "message" => "Đơn hàng đã được hủy thành công."
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Không thể hủy đơn hàng. Đơn hàng không tồn tại hoặc đã được hủy trước đó."
    ]);
}

// Đóng kết nối
$conn->close();
?>