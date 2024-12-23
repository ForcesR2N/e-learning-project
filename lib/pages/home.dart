import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:e_learning/controller/controller.dart';
import 'package:e_learning/widget/image_slider.dart';
import 'package:e_learning/widget/menu.dart';
import 'package:e_learning/widget/search_bar.dart';
import 'package:e_learning/component/my_color.dart';
import 'package:e_learning/utils/responsive_layout.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Controller contoller = Get.find();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryBlue,
        body: Responsive(
          mobile: _buildHomeContent(context),
          tablet: _buildHomeContent(context, isTablet: true),
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, {bool isTablet = false}) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context, isTablet),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 16.0 : 12.0),
            child: _buildPortraitContent(context, isTablet),
          ),
        )
      ],
    );
  }

  Widget _buildPortraitContent(BuildContext, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Featured Courses"),
        SizedBox(height: 10),
        ImageSlider(),
        SizedBox(height: 10),
        _buildSectionTitle("Categories"),
        SizedBox(height: 10),
        _buildCategoryChips(context),
        SizedBox(height: 20),
        _buildSectionTitle("Popular Couses"),
        SizedBox(height: 10),
        Menu(
          isSliver: false,
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, bool isTablet) {
    return SliverAppBar(
      expandedHeight: isTablet ? 130.0 : 120.0,
      floating: false,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.primaryBlue,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Obx(
              () => Text(
                "Hi, ${contoller.name}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 24.0 : 20,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: isTablet ? 24 : 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                color: AppColor.primaryBlue,
                size: isTablet ? 24.0 : 20.0,
              ),
            ),
          )
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 16.0 : 12.0,
            vertical: 8.0,
          ),
          child: MySearchBar(),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.textColor,
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 768;
    List<String> categories = [
      "All",
      "Design",
      "Programming",
      "Development",
      "Marketing",
      "Business"
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map(
              (category) => Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Chip(
                  label: Text(
                    category,
                    style: TextStyle(
                      fontSize: isTablet ? 14 : 12,
                    ),
                  ),
                  backgroundColor: AppColor.secondaryBlue.withOpacity(0.2),
                  labelStyle: const TextStyle(color: AppColor.primaryBlue),
                  padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 12 : 8,
                      vertical: isTablet ? 4 : 2),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
