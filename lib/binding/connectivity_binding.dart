import 'package:get/get.dart';

import '../controller/internet_connectivity_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
    // Get.lazyPut<DashbroadController>(() => DashbroadController());
  }
}
