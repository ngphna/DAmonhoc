<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

try {
    // Chuẩn bị câu truy vấn lấy tất cả dữ liệu từ bảng SanPham
    $stmt = $conn->prepare("SELECT * FROM SanPham");
    $stmt->execute();
    $result = $stmt->get_result();

    $products = [];
    // Lặp qua kết quả truy vấn và thêm toàn bộ dữ liệu vào mảng
    while ($row = $result->fetch_assoc()) {
        $products[] = $row; // Thêm toàn bộ hàng dữ liệu vào mảng
    }

    // Kiểm tra và trả về phản hồi JSON
    if (count($products) > 0) {
        echo json_encode(["success" => true, "data" => $products]);
    } else {
        echo json_encode(["success" => false, "message" => "Không có sản phẩm nào!"]);
    }

    // Đóng câu lệnh và kết nối cơ sở dữ liệu
    $stmt->close();
    $conn->close();
} catch (mysqli_sql_exception $e) {
    // Xử lý lỗi và trả về phản hồi JSON
    echo json_encode(["success" => false, "message" => "Lỗi: " . $e->getMessage()]);
}
?>
