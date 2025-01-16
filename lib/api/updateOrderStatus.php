<?php
require 'config.php';
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $donHangID = $_POST['DonHangID'];
    $trangThai = $_POST['TrangThai'];

    $stmt = $conn->prepare("UPDATE DonHang SET TrangThai = ? WHERE DonHangID = ?");
    $stmt->bind_param("si", $trangThai, $donHangID);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => $stmt->error]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}
?>
