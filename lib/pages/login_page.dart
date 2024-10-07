import 'package:e_learning/controller/bottom_navbar_controller.dart';
import 'package:e_learning/controller/controller.dart';
import 'package:e_learning/pages/home.dart';
import 'package:e_learning/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/component/my_color.dart';

class LoginPage extends StatefulWidget {
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Username",
                hintText: "Enter your username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
                ),
              ),
              onChanged: (value) {
                controller.changedName(value);
              },
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your username",
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.deepPurple, width: 1.5),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Get.to(() => HomePage());
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black, width: 1.3),
                foregroundColor: AppColor.textColor,
                backgroundColor: AppColor.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 1,
              ),
              child: Text(
                "Login",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
