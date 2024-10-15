import 'dart:convert';
import 'package:e_learning/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/model/data.json.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Data> _datas = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final jsonString = await rootBundle.loadString('lib/data/info.json');
    final jsonData = jsonDecode(jsonString);
    final dataList =
        (jsonData['datas'] as List).map((item) => Data.fromJson(item)).toList();
    setState(() {
      _datas = dataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _datas.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 170 / 150,
      ),
      itemBuilder: (context, index) {
        final data = _datas[index];
        return GestureDetector(
          onTap: () {
            Get.to(
              () => VideoPage(
                videoUrl: data.videoUrl,
                title: data.title,
                description: data.description,
                image: data.image,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    data.image,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  data.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
