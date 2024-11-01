import 'package:e_learning/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/component/my_color.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildSlider(context, height: 220),
      tablet: _buildSlider(context, height: 300),
    );
  }

  Widget _buildSlider(BuildContext context, {required double height}) {
    return Stack(
      children: [
        SizedBox(
          height: Responsive.isLandscape(context) ? height * 0.8 : height,
          width: double.infinity,
          child: PageView.builder(
            itemCount: 3,
            onPageChanged: (index) => setState(() => currentSlider = index),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isLandscape(context) ? 8.0 : 0.0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.radius),
                child: Image.asset(
                  "lib/image/landing_page.jpg",
                  fit: BoxFit.cover,
                ),
              ),
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
                (index) => _buildIndicator(index),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
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
    );
  }
}
