import 'dart:ffi';

import 'package:e_learning/controller/bottom_navbar_controller.dart';
import 'package:e_learning/controller/controller.dart';
import 'package:e_learning/pages/cart_page.dart';
import 'package:e_learning/pages/home.dart';
import 'package:e_learning/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.find();

    final List<Widget> menus = [
      Home(),
      CartPage(),
      ProfilePage(),
    ];
    return Obx(() {
      return Scaffold(
        body: menus[bottomNavController.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: bottomNavController.changedTabIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), label: "Profile"), 
          ],
        ),
      );
    });
  }
}
