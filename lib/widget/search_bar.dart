import 'package:e_learning/utils/responsive_layout.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildSearchBar(context),
      tablet: _buildSearchBar(context, isTablet: true),
    );
  }

  Widget _buildSearchBar(BuildContext context, {bool isTablet = false}) {
    return Container(
      height: isTablet ? 60 : 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.radius),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(fontSize: context.fontSize),
          prefixIcon: Icon(Icons.search, size: context.iconSize),
          suffixIcon: Icon(Icons.mic, size: context.iconSize),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.spacing,
            vertical: isTablet ? 18 : 15,
          ),
        ),
      ),
    );
  }
}