import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_learning/controller/controller.dart';
import 'package:e_learning/component/my_color.dart';
import 'package:e_learning/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1200;

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isTablet =
        screenWidth >= tabletBreakpoint && screenWidth < desktopBreakpoint;

    return Scaffold(
      backgroundColor: AppColor.primaryBlue,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryBlue,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
            child: isLandscape
                ? _buildLandscapeLayout(
                    controller, screenWidth, screenHeight, isTablet)
                : _buildPortraitLayout(controller, isTablet),
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(Controller controller, bool isTablet) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 600 : double.infinity,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: isTablet ? 60 : 20),
            _buildProfileImage(isTablet),
            SizedBox(height: isTablet ? 30 : 20),
            _buildUsername(controller, isTablet),
            SizedBox(height: isTablet ? 60 : 40),
            _buildInfoList(isTablet),
            SizedBox(height: isTablet ? 60 : 40),
            _buildLogoutButton(isTablet),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(Controller controller, double screenWidth,
      double screenHeight, bool isTablet) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 900 : double.infinity,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: isTablet ? 2 : 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: isTablet ? 120 : 20),
                  _buildProfileImage(isTablet),
                  SizedBox(height: isTablet ? 30 : 20),
                  _buildUsername(controller, isTablet),
                ],
              ),
            ),
            SizedBox(width: isTablet ? 60 : 20),
            Expanded(
              flex: isTablet ? 2 : 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: isTablet ? 120 : 40),
                    _buildInfoList(isTablet),
                    SizedBox(height: isTablet ? 40 : 20),
                    _buildLogoutButton(isTablet),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(bool isTablet) {
    return CircleAvatar(
      radius: isTablet ? 90 : 50,
      backgroundImage: AssetImage('lib/image/profile_pic.jpg'),
      backgroundColor: AppColor.primaryBlue.withOpacity(0.2),
    );
  }

  Widget _buildUsername(Controller controller, bool isTablet) {
    return Obx(
      () => Text(
        controller.name.isNotEmpty ? controller.name.value : "Username",
        style: TextStyle(
          fontSize: isTablet ? 35 : 22,
          fontWeight: FontWeight.bold,
          color: AppColor.textColor,
        ),
      ),
    );
  }

  Widget _buildInfoList(bool isTablet) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isTablet ? 16 : 10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: isTablet ? 8 : 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.email,
            title: "Email Address",
            subtitle: "user@example.com",
            isTablet: isTablet,
          ),
          Divider(height: 1),
          _buildListTile(
            icon: Icons.phone,
            title: "Phone Number",
            subtitle: "+62 8226 ****",
            isTablet: isTablet,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isTablet,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24.0 : 16.0,
        vertical: isTablet ? 8.0 : 4.0,
      ),
      leading: Icon(
        icon,
        color: AppColor.primaryBlue,
        size: isTablet ? 32 : 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: isTablet ? 20 : 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: isTablet ? 16 : 14,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: isTablet ? 20 : 16,
      ),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton(bool isTablet) {
    return Container(
      width: isTablet ? 100 : 70,
      child: ElevatedButton(
        onPressed: () {
          Get.offAll(() => LoginPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: isTablet ? 8.0 : 5.0,
            horizontal: isTablet ? 16.0 : 10.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 8 : 6),
          ),
          elevation: isTablet ? 3 : 2,
        ),
        child: Text(
          "Logout",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 16 : 12,
          ),
        ),
      ),
    );
  }
}
