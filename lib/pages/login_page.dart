import 'package:e_learning/controller/bottom_navbar_controller.dart';
import 'package:e_learning/controller/controller.dart';
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
      backgroundColor: AppColor.backgroundColor, 
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Welcome Back",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor, 
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Login to your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600], 
                ),
              ),
              SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Enter your username",
                  labelStyle: TextStyle(color: AppColor.primaryBlue), 
                  prefixIcon: Icon(Icons.person, color: AppColor.primaryBlue),
                  filled: true,
                  fillColor: AppColor.inputFieldColor, 
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                        color: AppColor.primaryBlue, 
                        width: 1.5),
                  ),
                ),
                onChanged: (value) {
                  controller.changedName(value);
                },
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  labelStyle: TextStyle(color: AppColor.primaryBlue), 
                  prefixIcon: Icon(Icons.lock, color: AppColor.primaryBlue),
                  filled: true,
                  fillColor: AppColor.inputFieldColor, 
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppColor.primaryBlue,
                      width: 1.5,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.primaryBlue, 
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => HomePage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.buttonColor, 
                  foregroundColor: Colors.white, 
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: AppColor.linkColor, 
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey[600], 
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: AppColor.linkColor, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
