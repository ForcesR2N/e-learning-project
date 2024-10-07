import 'package:e_learning/controller/bottom_navbar_controller.dart';
import 'package:get/get.dart';

class BindBottomnavbar extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());
  }
}
