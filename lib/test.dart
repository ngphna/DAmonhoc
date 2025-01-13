import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/XoaiXanh.jpg',
      'assets/OiHong.jpg',
      'assets/Tao.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel Example'),
      ),
      body: Column(
        children: [
          CarouselSlider(
            items: imgList.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(item),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 200.0, // Chiều cao của slider
              autoPlay: true, // Tự động cuộn
              autoPlayInterval: const Duration(seconds: 3), // Khoảng thời gian giữa mỗi cuộn
              enlargeCenterPage: true, // Phóng to trang trung tâm
              aspectRatio: 16 / 9, // Tỷ lệ chiều rộng / chiều cao
              viewportFraction: 0.8, // Độ rộng của mỗi mục so với viewport
              onPageChanged: (index, reason) {
                print('Page changed to $index'); // Xử lý khi chuyển trang
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CarouselExample(),
  ));
}
