import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/controller/controller.dart';
import 'package:e_learning/component/my_color.dart';
import 'package:e_learning/pages/login_page.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller controller =
        Get.find(); // Ensure Controller is initialized

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryBlue,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'lib/image/profile_pic.jpg'), 
              backgroundColor: AppColor.primaryBlue.withOpacity(0.2),
            ),
            SizedBox(height: 20),
            Obx(
              () => Text(
                controller.name.isNotEmpty ? controller.name.value : "Username",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor,
                ),
              ),
            ),

            SizedBox(height: 40),
            ListTile(
              leading: Icon(Icons.email, color: AppColor.primaryBlue),
              title: Text("Email Address"),
              subtitle: Text("user@example.com"),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.grey), 
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: AppColor.primaryBlue),
              title: Text("Phone Number"),
              subtitle: Text("+62 8226 ****"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {},
            ),
            Divider(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() =>
                    LoginPage()); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, 
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
