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
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
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
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(data.image),
              ),
            ),
            child: Center(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  data.title,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
