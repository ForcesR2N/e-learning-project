import 'package:get/get.dart';
import 'package:e_learning/controller/controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Controller>(() => Controller());
  }
}
