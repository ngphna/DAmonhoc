<?php

require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

// Lấy tham số "TrangThai" từ query string, nếu có
$trangThai = isset($_GET['TrangThai']) ? $_GET['TrangThai'] : '';

// Chuẩn bị câu lệnh SQL để lấy tất cả thông tin đơn hàng theo trạng thái
$sql = "SELECT * FROM DonHang WHERE TrangThai = ?";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    http_response_code(500); // Trả về mã lỗi 500 nếu lỗi trong chuẩn bị câu lệnh
    echo json_encode(['error' => 'Failed to prepare statement: ' . $conn->error]);
    exit;
}

// Gán giá trị của "TrangThai" vào câu lệnh chuẩn bị
$stmt->bind_param("s", $trangThai);

// Thực thi câu lệnh
$stmt->execute();
$result = $stmt->get_result();

// Xử lý kết quả trả về
$orders = [];
while ($row = $result->fetch_assoc()) {
    $orders[] = $row;
}

// Giải phóng tài nguyên và đóng kết nối
$stmt->close();
$conn->close();

// Trả về kết quả dưới dạng JSON
http_response_code(200); // Trả về mã 200 nếu thành công
echo json_encode($orders);
?>
