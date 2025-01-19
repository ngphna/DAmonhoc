int Sosanh(String title, List<String> categories) {
  int iddanhmuc = categories.indexOf(title) + 1; // Trả về id theo thứ tự trong danh sách

  return iddanhmuc;
}
