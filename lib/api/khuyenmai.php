<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode(["success" => false, "message" => "Chỉ hỗ trợ phương thức GET"]);
    exit();
}

try {
    // Kiểm tra kết nối cơ sở dữ liệu
    if (!$conn) {
        throw new Exception("Kết nối cơ sở dữ liệu thất bại.");
    }

    // Câu truy vấn lấy khuyến mãi còn hiệu lực
    $stmt = $conn->prepare("SELECT KhuyenMaiID, TenKhuyenMai, MoTa, GiamGiaPhanTram, NgayBatDau, NgayKetThuc
                            FROM KhuyenMai
                            WHERE CURDATE() BETWEEN NgayBatDau AND NgayKetThuc");
    
    // Kiểm tra lỗi trong câu truy vấn
    if (!$stmt) {
        throw new Exception("Lỗi câu truy vấn: " . $conn->error);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    // Lấy kết quả
    $promotions = $result->fetch_all(MYSQLI_ASSOC);

    if (count($promotions) > 0) {
        echo json_encode(["success" => true, "data" => $promotions]);
    } else {
        echo json_encode(["success" => false, "message" => "Không có khuyến mãi nào còn hiệu lực!"]);
    }

    $stmt->close();
    $conn->close();
} catch (Exception $e) {
    echo json_encode(["success" => false, "message" => "Lỗi: " . $e->getMessage()]);
}
?>
