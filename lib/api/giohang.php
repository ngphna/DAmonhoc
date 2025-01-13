<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

try {
    $stmt = $conn->prepare("SELECT SanPhamID,Soluong FROM GioHang WHERE GioHang.TenDangNhap == TaiKhoan.TenDangNhap");
    $stmt->execute();
    $result = $stmt->get_result();
    
} catch (mysqli_sql_exception $e) {
    
}
?>
