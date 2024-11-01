// home.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/controller/controller.dart';
import 'package:e_learning/widget/image_slider.dart';
import 'package:e_learning/widget/menu.dart';
import 'package:e_learning/widget/search_bar.dart';
import 'package:e_learning/component/my_color.dart';
import 'package:e_learning/utils/responsive_layout.dart';

class Home extends StatelessWidget {
  final Controller controller = Get.find();

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
    final isLandscape = Responsive.isLandscape(context);

    return CustomScrollView(
      slivers: [
        _buildAppBar(context, isTablet),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(context.spacing),
            child: isLandscape
                ? _buildLandscapeContent(context, isTablet)
                : _buildPortraitContent(context, isTablet),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeContent(BuildContext context, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Featured Courses"),
              SizedBox(height: 10),
              ImageSlider(),
              SizedBox(height: 20),
              _buildSectionTitle("Categories"),
              SizedBox(height: 10),
              _buildCategoryChips(context),
            ],
          ),
        ),
        SizedBox(width: context.spacing),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Popular Courses"),
              SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: Menu(isSliver: false),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitContent(BuildContext context, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Featured Courses"),
        SizedBox(height: 10),
        ImageSlider(),
        SizedBox(height: 20),
        _buildSectionTitle("Categories"),
        SizedBox(height: 10),
        _buildCategoryChips(context),
        SizedBox(height: 20),
        _buildSectionTitle("Popular Courses"),
        SizedBox(height: 10),
        Menu(isSliver: false),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, bool isTablet) {
    final isLandscape = Responsive.isLandscape(context);
    return SliverAppBar(
      expandedHeight: isLandscape 
          ? (isTablet ? 80.0 : 70.0)
          : (isTablet ? 130.0 : 120.0),
      floating: false,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.primaryBlue,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColor.primaryBlue],
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
            "Hi, ${controller.name}",
            style: TextStyle(
              color: Colors.white,
              fontSize: isLandscape 
                  ? (isTablet ? 20 : 18)
                  : (isTablet ? 24 : 20),
              fontWeight: FontWeight.bold,
            ),
          )),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: isLandscape 
                ? (isTablet ? 20 : 18)
                : (isTablet ? 24 : 20),
            child: IconButton(
              icon: Icon(
                Icons.person,
                color: AppColor.primaryBlue,
                size: context.iconSize,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(isLandscape ? 40 : 50),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacing,
            vertical: isLandscape ? 4.0 : 8.0,
          ),
          child: MySearchBar(),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.textColor,
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    final isLandscape = Responsive.isLandscape(context);
    List<String> categories = [
      "All",
      "Design",
      "Development",
      "Marketing",
      "Business"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) => Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Chip(
            label: Text(
              category,
              style: TextStyle(
                fontSize: isLandscape ? 12 : 14,
              ),
            ),
            backgroundColor: AppColor.secondaryBlue.withOpacity(0.2),
            labelStyle: TextStyle(color: AppColor.primaryBlue),
            padding: EdgeInsets.symmetric(
              horizontal: isLandscape ? 8 : 12,
              vertical: isLandscape ? 2 : 4,
            ),
          ),
        )).toList(),
      ),
    );
  }
}