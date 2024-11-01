import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/component/my_color.dart';
import 'package:e_learning/controller/bottom_navbar_controller.dart';
import 'package:e_learning/pages/saved_page.dart';
import 'package:e_learning/pages/home.dart';
import 'package:e_learning/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final BottomNavController bottomNavController = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<Widget> menus = [
      Home(),
      SavedPage(),
      ProfilePage(),
    ];

    return Obx(() {
      return Scaffold(
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: menus[bottomNavController.selectedIndex.value],
        ),
        bottomNavigationBar: Container(
          height: 90, // Increased height
          decoration: BoxDecoration(
            color: AppColor.primaryBlue,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(Icons.home_rounded, "Home", 0),
                  _buildNavItem(Icons.bookmark_rounded, "Saved", 1),
                  _buildNavItem(Icons.person_rounded, "Profile", 2),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return Obx(() {
      final isSelected = bottomNavController.selectedIndex.value == index;
      return GestureDetector(
        onTap: () => bottomNavController.changedTabIndex(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(isSelected ? 8 : 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.primaryBlue : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color:
                      isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
