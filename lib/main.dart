import 'package:device_preview/device_preview.dart';
import 'package:e_learning/bindings/bind_controller.dart';
import 'package:e_learning/component/my_color.dart';
import 'package:e_learning/pages/home.dart';
import 'package:e_learning/pages/home_page.dart';
import 'package:e_learning/pages/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColor.primaryBlue,
      ),
      home: LoginPage(),
    );
  }
}
