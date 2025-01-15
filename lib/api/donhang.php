<?php

require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');
// Lấy giá trị TenDangNhap từ tham số GET
$tenDangNhap = isset($_GET['TenDangNhap']) ? $_GET['TenDangNhap'] : '';

if (empty($tenDangNhap)) {
    http_response_code(400); // Trả về mã lỗi 400 nếu tham số bị thiếu
    echo json_encode(['error' => 'Missing TenDangNhap parameter']);
    exit;
}

// Chuẩn bị câu lệnh SQL
$sql = "SELECT * FROM DonHang WHERE TenDangNhap = ?";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    http_response_code(500); // Trả về mã lỗi 500 nếu lỗi trong chuẩn bị câu lệnh
    echo json_encode(['error' => 'Failed to prepare statement: ' . $conn->error]);
    exit;
}

// Bind tham số và thực thi câu lệnh
$stmt->bind_param("s", $tenDangNhap);
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
