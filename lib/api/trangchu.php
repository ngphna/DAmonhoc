<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

try {
    // Nhận DanhMucID từ query string
    $danhMucId = isset($_GET['DanhMucID']) ? intval($_GET['DanhMucID']) : null;

    // Kiểm tra nếu DanhMucID không được cung cấp
    if ($danhMucId === null) {
        echo json_encode([
            "success" => false,
            "message" => "DanhMucID không được cung cấp. Vui lòng thêm DanhMucID vào query string."
        ]);
        exit;
    }

    // Chuẩn bị câu truy vấn với tham số DanhMucID
    $stmt = $conn->prepare("SELECT * FROM SanPham WHERE DanhMucID = ?");
    $stmt->bind_param("i", $danhMucId);
    $stmt->execute();
    $result = $stmt->get_result();

    $products = [];
    
    // Lặp qua kết quả truy vấn và thêm dữ liệu vào mảng
    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }

    // Trả về phản hồi JSON
    if (!empty($products)) {
        echo json_encode([
            "success" => true,
            "data" => $products
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Không có sản phẩm nào trong danh mục với ID = $danhMucId."
        ]);
    }

    // Đóng câu lệnh và kết nối cơ sở dữ liệu
    $stmt->close();
    $conn->close();
} catch (mysqli_sql_exception $e) {
    // Xử lý lỗi và trả về phản hồi JSON
    echo json_encode([
        "success" => false,
        "message" => "Lỗi khi truy vấn cơ sở dữ liệu: " . $e->getMessage()
    ]);
}
?>
