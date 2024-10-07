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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.yellow.shade400,
              size: 40,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 25, left: 5),
                child: Obx(
                  () => Text(
                    "Welcome!\nHallo ${controller.name}",
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
                height: 20,
              ),
              MySearchBar(),
              SizedBox(
                height: 10,
              ),
              Menu(),
            ],
          ),
        ),
      ),
    );
  }
}
