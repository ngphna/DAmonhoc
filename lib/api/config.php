<?php
$serverName = "localhost"; 
$database = "HEALTHY";     
$username = "root";        
$password = "";            
try {
    $conn = new mysqli($serverName, $username, $password, $database);
    if ($conn->connect_error) {

        die(json_encode(["success" => false, "message" => "Lỗi kết nối CSDL: " . $conn->connect_error]));
    } else {}
} catch (Exception $e) {
    die(json_encode(["success" => false, "message" => "Lỗi: " . $e->getMessage()]));
}
?>
