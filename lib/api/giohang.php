<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");


include 'config.php';

// Đặt kiểu trả về JSON
header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);
$tenDangNhap = $data['TenDangNhap'] ?? null;

$response = array();

if (!$tenDangNhap) {
    echo json_encode(["success" => false, "message" => "Thiếu TenDangNhap trong yêu cầu."]);
    exit();
}

try {
    // Truy vấn SQL an toàn
    $query = "SELECT gh.SanPhamID, gh.SoLuong, sp.Image, sp.TenSanPham, sp.Gia 
              FROM giohang gh 
              JOIN sanpham sp ON gh.SanPhamID = sp.SanPhamID 
              WHERE gh.TenDangNhap = ? AND gh.soLuong >0";
              
    $stmt = $conn->prepare($query);
    $stmt->bind_param("s", $tenDangNhap);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $response['success'] = true;
        $response['data'] = [];
        while ($row = $result->fetch_assoc()) {
            $response['data'][] = $row;
        }
    } else {
        $response['success'] = false;
        $response['message'] = "Không có sản phẩm nào trong giỏ hàng.";
    }
} catch (Exception $e) {
    $response['success'] = false;
    $response['message'] = "Lỗi khi truy vấn cơ sở dữ liệu: " . $e->getMessage();
}

echo json_encode($response);
?>
