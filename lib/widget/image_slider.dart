import 'package:e_learning/component/my_color.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentSlider;
  const ImageSlider({super.key, required this.onChange, required this.currentSlider});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // More rounded corners for images
            child: PageView(
              scrollDirection: Axis.horizontal,
              onPageChanged: onChange,
              physics: ClampingScrollPhysics(),
              children: [
                Image.asset(
                  "lib/image/landing_page.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "lib/image/landing_page.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "lib/image/landing_page.png",
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: currentSlider == index ? 15 : 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentSlider == index
                        ? AppColor.primaryBlue
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
