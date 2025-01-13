<?php
require 'config.php'; // Kết nối cơ sở dữ liệu
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

try {
    // Nhận từ khóa tìm kiếm từ query string
    $search = isset($_GET['search']) ? $_GET['search'] : null;

    // Kiểm tra nếu từ khóa tìm kiếm không được cung cấp
    if ($search === null || empty($search)) {
        echo json_encode([
            "success" => false,
            "message" => "Từ khóa tìm kiếm không được cung cấp. Vui lòng thêm tham số search vào query string."
        ]);
        exit;
    }

    // Chuẩn bị câu truy vấn với từ khóa tìm kiếm (sử dụng LIKE để tìm kiếm gần đúng)
    $stmt = $conn->prepare("SELECT * FROM SanPham WHERE TenSanPham LIKE ?");
    $searchTerm = "%" . $search . "%"; // Thêm ký tự % để tìm kiếm gần đúng
    $stmt->bind_param("s", $searchTerm); // Liên kết tham số tìm kiếm
    $stmt->execute(); // Thực thi câu lệnh SQL
    $result = $stmt->get_result(); // Lấy kết quả

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
            "message" => "Không có sản phẩm nào phù hợp với từ khóa '$search'."
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
