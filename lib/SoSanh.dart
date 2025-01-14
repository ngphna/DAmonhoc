int Sosanh(String title) {
  int iddanhmuc = 0;

  if (title == "Trái cây Việt Nam") {
    iddanhmuc = 1;
  } else if (title == "Trái cây Nhiệt đới") {
    iddanhmuc = 2;
  } else if (title == "Trái cây Thái Lan") {
    iddanhmuc = 3;
  } else if (title == "Trái cây Mỹ") {
    iddanhmuc = 4;
  } else if (title == "Trái cây Úc") {
    iddanhmuc = 5;
  } else if (title == "Trái cây Trung Quốc") {
    iddanhmuc = 6;
  }

  return iddanhmuc;
}
