<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Kiểm tra nếu tham số username có
    if (isset($_GET['username'])) {
        $username = $_GET['username']; // Nhận tên đăng nhập từ request

        $stmt = $conn->prepare("SELECT * FROM DiaChiGiao WHERE TenDangNhap = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();

        $addresses = [];
        while ($row = $result->fetch_assoc()) {
            $addresses[] = $row;
        }

        echo json_encode($addresses);
    } 
    
    // Nếu tham số id có, trả về thông tin địa chỉ theo id
    if (isset($_GET['id'])) {
        $id = $_GET['id'];

        // Sử dụng prepared statement để tránh SQL injection
        $stmt = $conn->prepare("SELECT * FROM DiaChiGiao WHERE DiaChiGiaoID = ?");
        $stmt->bind_param("i", $id); // Dùng "i" cho integer
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $address = $result->fetch_assoc();
            echo json_encode($address);
        } else {
            echo json_encode(['message' => 'Không tìm thấy địa chỉ']);
        }
    } 

} else {
    echo json_encode(["error" => "Invalid request method"]);
}
?>
