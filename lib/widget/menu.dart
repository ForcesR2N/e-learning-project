// menu.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:e_learning/component/my_color.dart';
import 'package:e_learning/model/data.json.dart';
import 'package:e_learning/pages/video_page.dart';
import 'package:e_learning/utils/responsive_layout.dart';

class Menu extends StatelessWidget {
  final bool isSliver;
  Menu({this.isSliver = true});

  final Future<List<Data>> _dataFuture = _loadData();

  static Future<List<Data>> _loadData() async {
    final jsonString = await rootBundle.loadString('lib/data/info.json');
    final jsonData = jsonDecode(jsonString);
    return (jsonData['datas'] as List)
        .map((item) => Data.fromJson(item))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: isSliver
          ? _buildSliverGrid(context,
              crossAxisCount: Responsive.isLandscape(context) ? 3 : 2)
          : _buildGrid(context,
              crossAxisCount: Responsive.isLandscape(context) ? 3 : 2),
      tablet: isSliver
          ? _buildSliverGrid(context,
              crossAxisCount: Responsive.isLandscape(context) ? 4 : 3)
          : _buildGrid(context,
              crossAxisCount: Responsive.isLandscape(context) ? 4 : 3),
    );
  }

  Widget _buildSliverGrid(BuildContext context, {required int crossAxisCount}) {
    return FutureBuilder<List<Data>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: context.spacing,
            crossAxisSpacing: context.spacing,
            childAspectRatio: 170 / 150,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildMenuItem(context, snapshot.data![index]),
            childCount: snapshot.data!.length,
          ),
        );
      },
    );
  }

  Widget _buildGrid(BuildContext context, {required int crossAxisCount}) {
    return FutureBuilder<List<Data>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: context.spacing,
            crossAxisSpacing: context.spacing,
            childAspectRatio: 170 / 150,
          ),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) =>
              _buildMenuItem(context, snapshot.data![index]),
        );
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, Data data) {
    final isTablet = Responsive.isTablet(context);
    final isLandscape = Responsive.isLandscape(context);

    return GestureDetector(
      onTap: () => Get.to(
        () => VideoPage(
          videoUrl: data.videoUrl,
          title: data.title,
          description: data.description,
          image: data.image,
        ),
        transition: Transition.fadeIn,
      ),
      child: Container(
        padding: EdgeInsets.all(isLandscape ? 6 : 8),
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.circular(context.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'image_${data.image}',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.radius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(context.radius),
                    child: Image.asset(
                      data.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: isLandscape ? 6 : 8),
            Text(
              data.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.fontSize,
                  height: 1.2,
                  color: AppColor.textColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
