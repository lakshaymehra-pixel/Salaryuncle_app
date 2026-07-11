import 'package:get/get.dart';
import 'package:tejas_loan/controller/internet_connectivity_controller.dart';

import '../controller/aadhaar_controller.dart';

class AadhaarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AadhaarController>(() => AadhaarController());
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
