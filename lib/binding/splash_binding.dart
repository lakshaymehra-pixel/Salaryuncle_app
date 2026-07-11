import 'package:get/get.dart';
import 'package:tejas_loan/controller/internet_connectivity_controller.dart';

import '../controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
