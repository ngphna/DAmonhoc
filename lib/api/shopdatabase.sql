-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 09, 2025 at 03:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopdatabase`
--

-- --------------------------------------------------------

--
-- Table structure for table `chitietdonhang`
--

CREATE TABLE `chitietdonhang` (
  `ChiTietID` int(11) NOT NULL,
  `DonHangID` int(11) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `danhgia`
--

CREATE TABLE `danhgia` (
  `DanhGiaID` int(11) NOT NULL,
  `TaiKhoanID` int(11) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `NoiDung` text DEFAULT NULL,
  `NgayDanhGia` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `danhgia`
--

INSERT INTO `danhgia` (`DanhGiaID`, `TaiKhoanID`, `SanPhamID`, `NoiDung`, `NgayDanhGia`) VALUES
(1, 1, 1, 'San pham tot!', '0000-00-00 00:00:00'),
(2, 2, 2, 'Giao hang nhanh, san pham chat luong.', '0000-00-00 00:00:00'),
(3, 3, 3, 'San pham dep nhung giao hang cham.', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `danhmuc`
--

CREATE TABLE `danhmuc` (
  `DanhMucID` int(11) NOT NULL,
  `TenDanhMuc` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `danhmuc`
--

INSERT INTO `danhmuc` (`DanhMucID`, `TenDanhMuc`) VALUES
(1, 'Trái cây Việt Nam'),
(2, 'Trái cây Nhiệt đới'),
(3, 'Trái cây Thái Lan'),
(4, 'Trái cây Việt Nam'),
(5, 'Trái cây Nhiệt đới'),
(6, 'Trái cây Thái Lan');

-- --------------------------------------------------------

--
-- Table structure for table `diachigiao`
--

CREATE TABLE `diachigiao` (
  `DiaChiGiaoID` int(11) NOT NULL,
  `KhachHangID` int(11) NOT NULL,
  `Ten` varchar(100) DEFAULT NULL,
  `DiaChi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `donhang`
--

CREATE TABLE `donhang` (
  `DonHangID` int(11) NOT NULL,
  `TaiKhoanID` int(11) NOT NULL,
  `KhuyenMaiID` int(11) DEFAULT NULL,
  `ThanhToanID` int(11) DEFAULT NULL,
  `DiaChiGiaoID` int(11) DEFAULT NULL,
  `NgayDat` timestamp NOT NULL DEFAULT current_timestamp(),
  `TongTien` int(11) NOT NULL,
  `TrangThai` enum('ChoXacNhan','DaXacNhan','DangGiao','DaGiao','DaHuy') DEFAULT 'ChoXacNhan'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `giohang`
--

CREATE TABLE `giohang` (
  `GioHangID` int(11) NOT NULL,
  `TaiKhoanID` int(11) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `SoLuong` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `giohang`
--

INSERT INTO `giohang` (`GioHangID`, `TaiKhoanID`, `SanPhamID`, `SoLuong`) VALUES
(1, 1, 1, 2),
(2, 2, 2, 1),
(3, 3, 3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `khachhang`
--

CREATE TABLE `khachhang` (
  `KhachHangID` int(11) NOT NULL,
  `TaiKhoanID` int(11) NOT NULL,
  `HoTen` varchar(100) NOT NULL,
  `DiaChi` text DEFAULT NULL,
  `NgaySinh` date DEFAULT NULL,
  `GioiTinh` enum('Nam','Nu','Khac') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `khachhang`
--

INSERT INTO `khachhang` (`KhachHangID`, `TaiKhoanID`, `HoTen`, `DiaChi`, `NgaySinh`, `GioiTinh`) VALUES
(1, 1, 'Nguyen Van A', '123 Le Loi, Ha Noi', '0000-00-00', 'Nam'),
(2, 2, 'Tran Thi B', '456 Nguyen Trai, Ho Chi Minh', '0000-00-00', 'Nu'),
(3, 3, 'Le Van C', '789 Tran Phu, Da Nang', '0000-00-00', 'Nam');

-- --------------------------------------------------------

--
-- Table structure for table `khuyenmai`
--

CREATE TABLE `khuyenmai` (
  `KhuyenMaiID` int(11) NOT NULL,
  `TenKhuyenMai` varchar(100) NOT NULL,
  `MoTa` text DEFAULT NULL,
  `GiamGiaPhanTram` int(11) NOT NULL,
  `NgayBatDau` date DEFAULT NULL,
  `NgayKetThuc` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sanpham`
--

CREATE TABLE `sanpham` (
  `SanPhamID` int(11) NOT NULL,
  `Image` text DEFAULT NULL,
  `TenSanPham` varchar(255) NOT NULL,
  `Gia` int(11) NOT NULL,
  `SoLuong` float DEFAULT 0,
  `DonVi` varchar(50) DEFAULT NULL,
  `MoTa` text DEFAULT NULL,
  `TrangThai` enum('ConHang','HetHang') DEFAULT 'ConHang',
  `DanhMucID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sanpham`
--

INSERT INTO `sanpham` (`SanPhamID`, `Image`, `TenSanPham`, `Gia`, `SoLuong`, `DonVi`, `MoTa`, `TrangThai`, `DanhMucID`) VALUES
(1, 'Cam.jpg', 'Cam ngọt', 5000000, 10, 'kg', 'Cam siêu ngọt , ngon ', '', 1),
(2, 'Oi.jpg', 'Ổi hồng', 15000000, 5, 'kg', 'Ổi hồng ngọt, ngon', '', 2),
(3, 'Xoai.jpg', 'Xoài xanh', 300000, 20, 'kg', 'Xoài chua chấm muối siêu giòn ngon', '', 3),
(4, 'Cam.jpg', 'Cam ngọt', 5000000, 10, 'kg', 'Cam siêu ngọt , ngon ', '', 1),
(5, 'Oi.jpg', 'Ổi hồng', 15000000, 5, 'kg', 'Ổi hồng ngọt, ngon', '', 2),
(6, 'Xoai.jpg', 'Xoài xanh', 300000, 20, 'kg', 'Xoài chua chấm muối siêu giòn ngon', '', 3);

-- --------------------------------------------------------

--
-- Table structure for table `taikhoan`
--

CREATE TABLE `taikhoan` (
  `TaiKhoanID` int(11) NOT NULL,
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `NgayTao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `taikhoan`
--

INSERT INTO `taikhoan` (`TaiKhoanID`, `TenDangNhap`, `MatKhau`, `Email`, `SoDienThoai`, `NgayTao`) VALUES
(1, 'user1', 'password1', 'user1@example.com', '0123456789', NULL),
(2, 'user2', 'password2', 'user2@example.com', '0987654321', NULL),
(3, 'user3', 'password3', 'user3@example.com', '0112233445', NULL);
(4, 'nam', '123', 'user3@example.com', '0112233445', NULL);
-- --------------------------------------------------------

--
-- Table structure for table `thanhtoan`
--

CREATE TABLE `thanhtoan` (
  `ThanhToanID` int(11) NOT NULL,
  `PhuongThuc` varchar(50) NOT NULL,
  `TrangThai` enum('ThanhToanTruoc','ThanhToanSau') DEFAULT 'ThanhToanSau'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD PRIMARY KEY (`ChiTietID`),
  ADD KEY `DonHangID` (`DonHangID`),
  ADD KEY `SanPhamID` (`SanPhamID`);

--
-- Indexes for table `danhgia`
--
ALTER TABLE `danhgia`
  ADD PRIMARY KEY (`DanhGiaID`),
  ADD KEY `TaiKhoanID` (`TaiKhoanID`),
  ADD KEY `SanPhamID` (`SanPhamID`);

--
-- Indexes for table `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD PRIMARY KEY (`DanhMucID`);

--
-- Indexes for table `diachigiao`
--
ALTER TABLE `diachigiao`
  ADD PRIMARY KEY (`DiaChiGiaoID`),
  ADD KEY `KhachHangID` (`KhachHangID`);

--
-- Indexes for table `donhang`
--
ALTER TABLE `donhang`
  ADD PRIMARY KEY (`DonHangID`),
  ADD KEY `TaiKhoanID` (`TaiKhoanID`);

--
-- Indexes for table `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`GioHangID`),
  ADD KEY `TaiKhoanID` (`TaiKhoanID`);

--
-- Indexes for table `khachhang`
--
ALTER TABLE `khachhang`
  ADD PRIMARY KEY (`KhachHangID`),
  ADD KEY `TaiKhoanID` (`TaiKhoanID`);

--
-- Indexes for table `khuyenmai`
--
ALTER TABLE `khuyenmai`
  ADD PRIMARY KEY (`KhuyenMaiID`);

--
-- Indexes for table `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`SanPhamID`),
  ADD KEY `DanhMucID` (`DanhMucID`);

--
-- Indexes for table `taikhoan`
--
ALTER TABLE `taikhoan`
  ADD PRIMARY KEY (`TaiKhoanID`);

--
-- Indexes for table `thanhtoan`
--
ALTER TABLE `thanhtoan`
  ADD PRIMARY KEY (`ThanhToanID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  MODIFY `ChiTietID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `danhgia`
--
ALTER TABLE `danhgia`
  MODIFY `DanhGiaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `danhmuc`
--
ALTER TABLE `danhmuc`
  MODIFY `DanhMucID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `diachigiao`
--
ALTER TABLE `diachigiao`
  MODIFY `DiaChiGiaoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `donhang`
--
ALTER TABLE `donhang`
  MODIFY `DonHangID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `giohang`
--
ALTER TABLE `giohang`
  MODIFY `GioHangID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `khachhang`
--
ALTER TABLE `khachhang`
  MODIFY `KhachHangID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `khuyenmai`
--
ALTER TABLE `khuyenmai`
  MODIFY `KhuyenMaiID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `SanPhamID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `taikhoan`
--
ALTER TABLE `taikhoan`
  MODIFY `TaiKhoanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `thanhtoan`
--
ALTER TABLE `thanhtoan`
  MODIFY `ThanhToanID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD CONSTRAINT `chitietdonhang_ibfk_1` FOREIGN KEY (`DonHangID`) REFERENCES `donhang` (`DonHangID`) ON DELETE CASCADE,
  ADD CONSTRAINT `chitietdonhang_ibfk_2` FOREIGN KEY (`SanPhamID`) REFERENCES `sanpham` (`SanPhamID`) ON DELETE CASCADE;

--
-- Constraints for table `danhgia`
--
ALTER TABLE `danhgia`
  ADD CONSTRAINT `danhgia_ibfk_1` FOREIGN KEY (`TaiKhoanID`) REFERENCES `taikhoan` (`TaiKhoanID`) ON DELETE CASCADE,
  ADD CONSTRAINT `danhgia_ibfk_2` FOREIGN KEY (`SanPhamID`) REFERENCES `sanpham` (`SanPhamID`) ON DELETE CASCADE;

--
-- Constraints for table `diachigiao`
--
ALTER TABLE `diachigiao`
  ADD CONSTRAINT `diachigiao_ibfk_1` FOREIGN KEY (`KhachHangID`) REFERENCES `khachhang` (`KhachHangID`) ON DELETE CASCADE;

--
-- Constraints for table `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`TaiKhoanID`) REFERENCES `taikhoan` (`TaiKhoanID`) ON DELETE CASCADE;

--
-- Constraints for table `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`TaiKhoanID`) REFERENCES `taikhoan` (`TaiKhoanID`) ON DELETE CASCADE;

--
-- Constraints for table `khachhang`
--
ALTER TABLE `khachhang`
  ADD CONSTRAINT `khachhang_ibfk_1` FOREIGN KEY (`TaiKhoanID`) REFERENCES `taikhoan` (`TaiKhoanID`) ON DELETE CASCADE;

--
-- Constraints for table `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`DanhMucID`) REFERENCES `danhmuc` (`DanhMucID`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
