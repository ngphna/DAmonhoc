<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

// Chuẩn bị câu lệnh SQL để lấy tất cả đơn hàng
$sql = "SELECT * FROM DonHang";
$result = $conn->query($sql);

// Kiểm tra kết quả truy vấn
if ($result) {
    $orders = [];
    
    // Duyệt qua từng dòng kết quả và thêm vào mảng $orders
    while ($row = $result->fetch_assoc()) {
        $orders[] = $row;
    }
    
    // Trả về kết quả dưới dạng JSON
    http_response_code(200); // Trả về mã 200 nếu thành công
    echo json_encode(['success' => true, 'data' => $orders]);
} else {
    // Trả về lỗi nếu truy vấn không thành công
    http_response_code(500); // Trả về mã lỗi 500
    echo json_encode(['success' => false, 'error' => 'Failed to execute query: ' . $conn->error]);
}

// Đóng kết nối
$conn->close();
?>
