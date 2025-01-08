-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 08, 2025 lúc 08:30 AM
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
-- Cơ sở dữ liệu: `healthy`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitietdonhang`
--

CREATE TABLE `chitietdonhang` (
  `ChiTietID` int(11) NOT NULL,
  `DonHangID` int(11) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL,
  `Gia` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitietsanpham`
--

CREATE TABLE `chitietsanpham` (
  `ChiTietID` int(11) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `ThuocTinh` varchar(100) DEFAULT NULL,
  `GiaTri` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhgia`
--

CREATE TABLE `danhgia` (
  `DanhGiaID` int(11) NOT NULL,
  `TaiKhoanID` int(11) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `NoiDung` text DEFAULT NULL,
  `NgayDanhGia` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhmuc`
--

CREATE TABLE `danhmuc` (
  `DanhMucID` int(11) NOT NULL,
  `TenDanhMuc` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `donhang`
--

CREATE TABLE `donhang` (
  `DonHangID` int(11) NOT NULL,
  `TaiKhoanID` int(11) NOT NULL,
  `NgayDat` date DEFAULT NULL,
  `TongTien` float NOT NULL,
  `TrangThai` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giohang`
--

CREATE TABLE `giohang` (
  `GioHangID` int(11) NOT NULL,
  `TaiKhoanID` int(11) NOT NULL,
  `SanPhamID` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khuyenmai`
--

CREATE TABLE `khuyenmai` (
  `KhuyenMaiID` int(11) NOT NULL,
  `TenKhuyenMai` varchar(100) NOT NULL,
  `MoTa` text DEFAULT NULL,
  `GiamGiaPhanTram` int(11) DEFAULT NULL,
  `NgayBatDau` date DEFAULT NULL,
  `NgayKetThuc` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `SanPhamID` int(11) NOT NULL,
  `TenSanPham` varchar(100) NOT NULL,
  `Gia` decimal(10,2) NOT NULL,
  `SoLuongTon` int(11) DEFAULT 0,
  `DanhMucID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `taikhoan`
--

CREATE TABLE `taikhoan` (
  `TaiKhoanID` int(11) NOT NULL,
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `NgayTao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `taikhoan`
--

INSERT INTO `taikhoan` (`TaiKhoanID`, `TenDangNhap`, `MatKhau`, `Email`, `SoDienThoai`, `NgayTao`) VALUES
(1, 'Nhan', '123', 'nhant4404@gmail.com', '0969427271', '0000-00-00'),
(2, 'Nam', '$2y$10$3yyjn6tzdZYLNfxXPorDI.OxzLMCxraP5LmVPpf23ZiHLd.4wRPMi', 'Nam@gmail.com', '0123456789', NULL),
(3, 'Thuc', '$2y$10$Z.HbJn9Ermv1evZYlPZgnuHPwmBnytfjLlQiQQqjxdKVMqmG8Lsgi', 'Thuc@gmai.com', '123456789', NULL),
(4, 'Tuan', '$2y$10$NnXZ7MePHyUb8hdHPLPr9.pfH7waqSq.WpQQyKYH1RzQ5PVpvvW5a', 'Tuan@gmail.com', '0306221191', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thanhtoan`
--

CREATE TABLE `thanhtoan` (
  `ThanhToanID` int(11) NOT NULL,
  `DonHangID` int(11) NOT NULL,
  `PhuongThuc` varchar(50) NOT NULL,
  `TrangThai` tinyint(1) DEFAULT NULL,
  `NgayThanhToan` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thongtincanhan`
--

CREATE TABLE `thongtincanhan` (
  `ThongTinID` int(11) NOT NULL,
  `TaiKhoanID` int(11) NOT NULL,
  `HoTen` varchar(100) DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL,
  `NgaySinh` date DEFAULT NULL,
  `GioiTinh` tinyint(1) DEFAULT NULL
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
-- Chỉ mục cho bảng `chitietsanpham`
--
ALTER TABLE `chitietsanpham`
  ADD PRIMARY KEY (`ChiTietID`),
  ADD KEY `SanPhamID` (`SanPhamID`);

--
-- Chỉ mục cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD PRIMARY KEY (`DanhGiaID`),
  ADD KEY `TaiKhoanID` (`TaiKhoanID`),
  ADD KEY `SanPhamID` (`SanPhamID`);

--
-- Chỉ mục cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD PRIMARY KEY (`DanhMucID`);

--
-- Chỉ mục cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD PRIMARY KEY (`DonHangID`),
  ADD KEY `TaiKhoanID` (`TaiKhoanID`);

--
-- Chỉ mục cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`GioHangID`),
  ADD KEY `TaiKhoanID` (`TaiKhoanID`),
  ADD KEY `SanPhamID` (`SanPhamID`);

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
  ADD PRIMARY KEY (`TaiKhoanID`),
  ADD UNIQUE KEY `TenDangNhap` (`TenDangNhap`);

--
-- Chỉ mục cho bảng `thanhtoan`
--
ALTER TABLE `thanhtoan`
  ADD PRIMARY KEY (`ThanhToanID`),
  ADD KEY `DonHangID` (`DonHangID`);

--
-- Chỉ mục cho bảng `thongtincanhan`
--
ALTER TABLE `thongtincanhan`
  ADD PRIMARY KEY (`ThongTinID`),
  ADD KEY `TaiKhoanID` (`TaiKhoanID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  MODIFY `ChiTietID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `chitietsanpham`
--
ALTER TABLE `chitietsanpham`
  MODIFY `ChiTietID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  MODIFY `DanhGiaID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `danhmuc`
--
ALTER TABLE `danhmuc`
  MODIFY `DanhMucID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `donhang`
--
ALTER TABLE `donhang`
  MODIFY `DonHangID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `giohang`
--
ALTER TABLE `giohang`
  MODIFY `GioHangID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `khuyenmai`
--
ALTER TABLE `khuyenmai`
  MODIFY `KhuyenMaiID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `SanPhamID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `taikhoan`
--
ALTER TABLE `taikhoan`
  MODIFY `TaiKhoanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `thanhtoan`
--
ALTER TABLE `thanhtoan`
  MODIFY `ThanhToanID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `thongtincanhan`
--
ALTER TABLE `thongtincanhan`
  MODIFY `ThongTinID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chitietdonhang`
--
ALTER TABLE `chitietdonhang`
  ADD CONSTRAINT `chitietdonhang_ibfk_1` FOREIGN KEY (`DonHangID`) REFERENCES `donhang` (`DonHangID`),
  ADD CONSTRAINT `chitietdonhang_ibfk_2` FOREIGN KEY (`SanPhamID`) REFERENCES `sanpham` (`SanPhamID`);

--
-- Các ràng buộc cho bảng `chitietsanpham`
--
ALTER TABLE `chitietsanpham`
  ADD CONSTRAINT `chitietsanpham_ibfk_1` FOREIGN KEY (`SanPhamID`) REFERENCES `sanpham` (`SanPhamID`);

--
-- Các ràng buộc cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD CONSTRAINT `danhgia_ibfk_1` FOREIGN KEY (`TaiKhoanID`) REFERENCES `taikhoan` (`TaiKhoanID`),
  ADD CONSTRAINT `danhgia_ibfk_2` FOREIGN KEY (`SanPhamID`) REFERENCES `sanpham` (`SanPhamID`);

--
-- Các ràng buộc cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`TaiKhoanID`) REFERENCES `taikhoan` (`TaiKhoanID`);

--
-- Các ràng buộc cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`TaiKhoanID`) REFERENCES `taikhoan` (`TaiKhoanID`),
  ADD CONSTRAINT `giohang_ibfk_2` FOREIGN KEY (`SanPhamID`) REFERENCES `sanpham` (`SanPhamID`);

--
-- Các ràng buộc cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`DanhMucID`) REFERENCES `danhmuc` (`DanhMucID`);

--
-- Các ràng buộc cho bảng `thanhtoan`
--
ALTER TABLE `thanhtoan`
  ADD CONSTRAINT `thanhtoan_ibfk_1` FOREIGN KEY (`DonHangID`) REFERENCES `donhang` (`DonHangID`);

--
-- Các ràng buộc cho bảng `thongtincanhan`
--
ALTER TABLE `thongtincanhan`
  ADD CONSTRAINT `thongtincanhan_ibfk_1` FOREIGN KEY (`TaiKhoanID`) REFERENCES `taikhoan` (`TaiKhoanID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
