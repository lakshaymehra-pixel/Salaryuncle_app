import 'package:get/get.dart';
import 'package:tejas_loan/controller/internet_connectivity_controller.dart';

import '../controller/loging_controller.dart';

class LogingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogingController>(() => LogingController());
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
