<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

try {
    $stmt = $conn->prepare("SELECT TenDanhMuc FROM DanhMuc");
    $stmt->execute();
    $result = $stmt->get_result();

    $categories = [];
    while ($row = $result->fetch_assoc()) {
        $categories[] = $row['TenDanhMuc'];
    }

    if (count($categories) > 0) {
        echo json_encode(["success" => true, "data" => $categories]);
    } else {
        echo json_encode(["success" => false, "message" => "Không có danh mục nào!"]);
    }

    $stmt->close();
    $conn->close();
} catch (mysqli_sql_exception $e) {
    echo json_encode(["success" => false, "message" => "Lỗi: " . $e->getMessage()]);
}
?>
