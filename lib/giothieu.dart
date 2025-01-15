import 'dart:async';
import 'package:flutter/material.dart';

class AutoScrollCarouselView extends StatefulWidget {
  @override
  _AutoScrollCarouselViewState createState() => _AutoScrollCarouselViewState();
}

class _AutoScrollCarouselViewState extends State<AutoScrollCarouselView> {
  late final PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;

  // Danh sách ảnh
  final List<String> imgList = [
   'assets/XoaiXanh.jpg',
  'assets/OiHong.jpg',
  'assets/Tao.jpg',
  'assets/banane.jpg',
  'assets/Cam.jpg',
  'assets/TaoDo.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % imgList.length;
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        height: 150,
        child: PageView.builder(
          controller: _pageController,
          itemCount: imgList.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imgList[index]),
                  fit: BoxFit.fitHeight,
                ),
              ),
            );
          },
        ),
      
    );
  }
}
