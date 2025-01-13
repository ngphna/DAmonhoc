<?php
// Kết nối cơ sở dữ liệu
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "your_database_name";

$conn = new mysqli($servername, $username, $password, $dbname);

// Kiểm tra kết nối
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Giả sử bạn có thông tin người dùng đăng nhập (tendangnhap)
$tendangnhap = "user123"; // Thay bằng tên đăng nhập thật từ hệ thống

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['sanphamID'])) {
    $sanphamID = intval($_POST['sanphamID']);

    // Kiểm tra sản phẩm đã tồn tại trong giỏ hàng chưa
    $sql_check = "SELECT * FROM giohang WHERE tendangnhap = ? AND sanphamID = ?";
    $stmt_check = $conn->prepare($sql_check);
    $stmt_check->bind_param("si", $tendangnhap, $sanphamID);
    $stmt_check->execute();
    $result_check = $stmt_check->get_result();

    if ($result_check->num_rows > 0) {
        // Nếu sản phẩm đã tồn tại, tăng số lượng
        $sql_update = "UPDATE giohang SET soluong = soluong + 1 WHERE tendangnhap = ? AND sanphamID = ?";
        $stmt_update = $conn->prepare($sql_update);
        $stmt_update->bind_param("si", $tendangnhap, $sanphamID);
        $stmt_update->execute();
    } else {
        // Nếu sản phẩm chưa tồn tại, thêm mới
        $sql_insert = "INSERT INTO giohang (tendangnhap, sanphamID, soluong) VALUES (?, ?, 1)";
        $stmt_insert = $conn->prepare($sql_insert);
        $stmt_insert->bind_param("si", $tendangnhap, $sanphamID);
        $stmt_insert->execute();
    }

    // Chuyển hướng trở lại trang sản phẩm
    header("Location: products.php");
    exit();
} else {
    echo "Yêu cầu không hợp lệ.";
}

// Đóng kết nối
$conn->close();
?>
