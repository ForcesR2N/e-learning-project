import 'package:e_learning/controller/controller.dart';
import 'package:e_learning/widget/image_slider.dart';
import 'package:e_learning/widget/menu.dart';
import 'package:e_learning/widget/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    int currentSlider = 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60, bottom: 20, left: 5),
                child: Obx(
                  () => Text(
                    "Selamat Datang!\nHallo ${controller.name}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ),
              ImageSlider(
                currentSlider: currentSlider,
                onChange: (value) {
                  setState(
                    () {
                      currentSlider = value;
                    },
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              MySearchBar(),
              Menu(),
            ],
          ),
        ),
      ),
    );
  }
}
