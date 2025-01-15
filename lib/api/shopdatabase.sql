-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 14, 2025 lúc 07:09 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `shopdatabase`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitietdonhang`
--

CREATE TABLE `chitietdonhang` (
  `ChiTietID` int(11) NOT NULL,
  `DonHangID` int(11) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhgia`
--

CREATE TABLE `danhgia` (
  `DanhGiaID` int(11) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `TenDangNhap` varchar(50) DEFAULT NULL,
  `NoiDung` text DEFAULT NULL,
  `NgayDanhGia` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhmuc`
--

CREATE TABLE `danhmuc` (
  `DanhMucID` int(11) NOT NULL,
  `TenDanhMuc` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `danhmuc`
--

INSERT INTO `danhmuc` (`DanhMucID`, `TenDanhMuc`) VALUES
(1, 'Trái cây Việt Nam'),
(2, 'Trái cây Nhiệt đới'),
(3, 'Trái cây Thái Lan'),
(4, 'Trái cây Mỹ'),
(5, 'Trái cây Úc'),
(6, 'Trái cây Trung Quốc');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `diachigiao`
--

CREATE TABLE `diachigiao` (
  `DiaChiGiaoID` int(11) NOT NULL,
  `TenDangNhap` varchar(50) NOT NULL,
  `Ten` varchar(100) DEFAULT NULL,
  `SDT` varchar(10) DEFAULT NULL,
  `DiaChi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `donhang`
--

CREATE TABLE `donhang` (
  `DonHangID` int(11) NOT NULL,
  `TenDangNhap` varchar(50) NOT NULL,
  `KhuyenMaiID` int(11) DEFAULT NULL,
  `ThanhToanID` int(11) DEFAULT NULL,
  `DiaChiGiaoID` int(11) DEFAULT NULL,
  `NgayDat` timestamp NOT NULL DEFAULT current_timestamp(),
  `TongTien` int(11) NOT NULL,
  `TrangThai` enum('ChoXacNhan','DaXacNhan','DangGiao','DaGiao','DaHuy') DEFAULT 'ChoXacNhan'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giohang`
--

CREATE TABLE `giohang` (
<<<<<<< HEAD
  `TenDangNhap` varchar(50) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `SoLuong` int(11) DEFAULT 1
=======
  `TenDangNhap` varchar (50) DEFAULT NULL,
  `SanPhamID` int(11) DEFAULT NULL,
  `SoLuong` int(11) DEFAULT NULL 
>>>>>>> b5e9d36cfa8cea4553a81805287a011ca3d91ce5
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `giohang`
--

INSERT INTO `giohang` (`TenDangNhap`, `SanPhamID`, `SoLuong`) VALUES
('thuc', 1, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khuyenmai`
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
-- Cấu trúc bảng cho bảng `sanpham`
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
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`SanPhamID`, `Image`, `TenSanPham`, `Gia`, `SoLuong`, `DonVi`, `MoTa`, `TrangThai`, `DanhMucID`) VALUES
(1, 'assets/TaoDo.jpg', 'Táo đỏ', 50000, 1, 'kg', 'Táo đỏ nhập khẩu', 'ConHang', 1),
(2, 'assets/banane.jpg', 'Chuối tiêu', 20000, 1, 'nải', 'Chuối tiêu sạch', 'ConHang', 1),
(3, 'assets/Cam.jpg', 'Cam sành', 30000, 1, 'kg', 'Cam sành từ miền Tây', 'ConHang', 1),
(4, 'assets/Nho.jpg', 'Nho Mỹ', 120000, 1, 'kg', 'Nho Mỹ nhập khẩu', 'HetHang', 1),
(5, 'assets/XoaiXanh.jpg', 'Xoài cát', 40000, 1, 'kg', 'Xoài cát chín tự nhiên', 'ConHang', 1),
(6, 'assets/SauRieng.jpg', 'Sầu Riêng', 100000, 1, 'kg', 'Sầu một mình cũng được', 'ConHang', 1),
(7, 'assets/TaoDo.jpg', 'Táo đỏ Trung Quốc', 50000, 1, 'kg', 'Táo đỏ nhập khẩu', 'ConHang', 6),
(8, 'assets/banane.jpg', 'Chuối tiêu Trung Quốc', 20000, 1, 'nải', 'Chuối tiêu sạch', 'ConHang', 6),
(9, 'assets/Cam.jpg', 'Cam sành Trung Quốc', 30000, 1, 'kg', 'Cam sành từ miền Tây', 'ConHang', 6),
(10, 'assets/Nho.jpg', 'Nho Trung Quốc', 120000, 1, 'kg', 'Nho Mỹ nhập khẩu', 'HetHang', 6),
(11, 'assets/XoaiXanh.jpg', 'Xoài cát Trung Quốc', 40000, 1, 'kg', 'Xoài cát chín tự nhiên', 'ConHang', 6),
(12, 'assets/SauRieng.jpg', 'Sầu Riêng Trung Quốc', 100000, 1, 'kg', 'Sầu một mình cũng được', 'ConHang', 6),
(13, 'assets/TaoDo.jpg', 'Táo đỏ Mọng Nước', 50000, 1, 'kg', 'Táo đỏ nhập khẩu', 'ConHang', 2),
(14, 'assets/banane.jpg', 'Chuối tiêu Mọng Nước', 20000, 1, 'nải', 'Chuối tiêu sạch', 'ConHang', 2),
(15, 'assets/Cam.jpg', 'Cam sành Mọng Nước', 30000, 1, 'kg', 'Cam sành từ miền Tây', 'ConHang', 2),
(16, 'assets/Nho.jpg', 'Nho Mọng Nước', 120000, 1, 'kg', 'Nho Mỹ nhập khẩu', 'HetHang', 2),
(17, 'assets/XoaiXanh.jpg', 'Xoài cát Mọng Nước', 40000, 1, 'kg', 'Xoài cát chín tự nhiên', 'ConHang', 2),
(18, 'assets/SauRieng.jpg', 'Sầu Riêng Siêu Ngọt', 100000, 1, 'kg', 'Sầu một mình cũng được', 'ConHang', 2),
(19, 'assets/TaoDo.jpg', 'Táo đỏ Thái Lan', 50000, 1, 'kg', 'Táo đỏ nhập khẩu', 'ConHang', 3),
(20, 'assets/banane.jpg', 'Chuối tiêu Thái Lan', 30000, 1, 'nải', 'Chuối tiêu sạch', 'ConHang', 3),
(21, 'assets/Cam.jpg', 'Cam sành Thái Lan', 30000, 1, 'kg', 'Cam sành từ miền Tây', 'ConHang', 3),
(22, 'assets/Nho.jpg', 'Nho Thái Lan', 130000, 1, 'kg', 'Nho Mỹ nhập khẩu', 'HetHang', 3),
(23, 'assets/XoaiXanh.jpg', 'Xoài cát Thái Lan', 40000, 1, 'kg', 'Xoài cát chín tự nhiên', 'ConHang', 3),
(24, 'assets/SauRieng.jpg', 'Sầu Riêng Siêu Ngọt', 100000, 1, 'kg', 'Sầu một mình cũng được', 'ConHang', 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `taikhoan`
--

CREATE TABLE `taikhoan` (
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `HoTen` varchar(100) NOT NULL,
  `DiaChi` text DEFAULT NULL,
  `NgaySinh` date DEFAULT NULL,
  `GioiTinh` enum('Nam','Nu','Khac') DEFAULT NULL,
  `NgayTao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `taikhoan`
--

INSERT INTO `taikhoan` (`TenDangNhap`, `MatKhau`, `Email`, `SoDienThoai`, `HoTen`, `DiaChi`, `NgaySinh`, `GioiTinh`, `NgayTao`) VALUES
('Nam', '$2y$10$VLqY432utHsAx2KNFKbY8.UECdQo.F6JMYdDRgiCAYlCyfl8ivf..', 'Namlor@gmail.com', '0345', '', NULL, NULL, NULL, NULL),
('Namqqq', '$2y$10$Y1jlQMuT4wA2e6nGECopuuNQmyh1dBsSotezvWXkKNqzkWHwCMpdm', 'Namlo@gmail.com', '0123', 'Nam Nguyễn', '', '0000-00-00', '', NULL),
('thuc', '$2y$10$eHABAaXS12l26QRmY66lXuHp0ZHDSfyLW8cy4Y2YuVAIcZJ26hy2e', 'thuc@gmail.com', '09876', '', NULL, NULL, NULL, NULL),
('user1', '*668425423DB5193AF921380129F465A6425216D0', 'user1@example.com', '0123456789', '', NULL, NULL, NULL, NULL),
('user2', '*DC52755F3C09F5923046BD42AFA76BD1D80DF2E9', 'user2@example.com', '0987654321', '', NULL, NULL, NULL, NULL),
('user3', '*40C3E7D386A2FADBDF69ACEBE7AA4DC3C723D798', 'user3@example.com', '0112233445', '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thanhtoan`
--

CREATE TABLE `thanhtoan` (
  `ThanhToanID` int(11) NOT NULL,
  `PhuongThuc` varchar(50) NOT NULL,
  `TrangThai` enum('ThanhToanTruoc','ThanhToanSau') DEFAULT 'ThanhToanSau'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD PRIMARY KEY (`ChiTietID`),
  ADD KEY `DonHangID` (`DonHangID`),
  ADD KEY `SanPhamID` (`SanPhamID`);

--
-- Chỉ mục cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD PRIMARY KEY (`DanhGiaID`),
  ADD KEY `TenDangNhap` (`TenDangNhap`),
  ADD KEY `SanPhamID` (`SanPhamID`);

--
-- Chỉ mục cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD PRIMARY KEY (`DanhMucID`);

--
-- Chỉ mục cho bảng `diachigiao`
--
ALTER TABLE `diachigiao`
  ADD PRIMARY KEY (`DiaChiGiaoID`),
  ADD KEY `TenDangNhap` (`TenDangNhap`);

--
-- Chỉ mục cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD KEY `TenDangNhap` (`TenDangNhap`);

--
-- Chỉ mục cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`TenDangNhap`),
  ADD KEY `TenDangNhap` (`TenDangNhap`);

--
-- Chỉ mục cho bảng `khuyenmai`
--
ALTER TABLE `khuyenmai`
  ADD PRIMARY KEY (`KhuyenMaiID`);

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`SanPhamID`),
  ADD KEY `DanhMucID` (`DanhMucID`);

--
-- Chỉ mục cho bảng `taikhoan`
--
ALTER TABLE `taikhoan`
  ADD PRIMARY KEY (`TenDangNhap`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Chỉ mục cho bảng `thanhtoan`
--
ALTER TABLE `thanhtoan`
  ADD PRIMARY KEY (`ThanhToanID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  MODIFY `ChiTietID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  MODIFY `DanhGiaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  MODIFY `DanhMucID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `diachigiao`
--
ALTER TABLE `diachigiao`
  MODIFY `DiaChiGiaoID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `donhang`
--
ALTER TABLE `donhang`
  MODIFY `DonHangID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `khuyenmai`
--
ALTER TABLE `khuyenmai`
  MODIFY `KhuyenMaiID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `SanPhamID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `thanhtoan`
--
ALTER TABLE `thanhtoan`
  MODIFY `ThanhToanID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD CONSTRAINT `chitietdonhang_ibfk_1` FOREIGN KEY (`DonHangID`) REFERENCES `donhang` (`DonHangID`) ON DELETE CASCADE,
  ADD CONSTRAINT `chitietdonhang_ibfk_2` FOREIGN KEY (`SanPhamID`) REFERENCES `sanpham` (`SanPhamID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD CONSTRAINT `danhgia_ibfk_1` FOREIGN KEY (`TenDangNhap`) REFERENCES `taikhoan` (`TenDangNhap`) ON DELETE CASCADE,
  ADD CONSTRAINT `danhgia_ibfk_2` FOREIGN KEY (`SanPhamID`) REFERENCES `sanpham` (`SanPhamID`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `diachigiao`
--
ALTER TABLE `diachigiao`
  ADD CONSTRAINT `diachigiao_ibfk_1` FOREIGN KEY (`TenDangNhap`) REFERENCES `taikhoan` (`TenDangNhap`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`TenDangNhap`) REFERENCES `taikhoan` (`TenDangNhap`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`TenDangNhap`) REFERENCES `taikhoan` (`TenDangNhap`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`DanhMucID`) REFERENCES `danhmuc` (`DanhMucID`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
