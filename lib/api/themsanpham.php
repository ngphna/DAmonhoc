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

// Truy vấn danh sách sản phẩm
$sql = "SELECT * FROM sanpham";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo "<div class='product'>";
        echo "<h2>" . $row['tensanpham'] . "</h2>";
        echo "<p>Price: " . $row['gia'] . " VNĐ</p>";
        echo "<form method='post' action='add_to_cart.php'>";
        echo "<input type='hidden' name='sanphamID' value='" . $row['sanphamID'] . "'>";
        echo "<button type='submit'>Thêm vào giỏ hàng</button>";
        echo "</form>";
        echo "</div>";
    }
} else {
    echo "Không tìm thấy sản phẩm.";
}

// Đóng kết nối
$conn->close();
?>
