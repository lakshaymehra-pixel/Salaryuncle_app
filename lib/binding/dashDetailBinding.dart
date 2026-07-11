import 'package:get/get.dart';
import 'package:tejas_loan/controller/dashDetailController.dart';

import '../controller/internet_connectivity_controller.dart';

class DashDetailBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DashDetailController>(() => DashDetailController());
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
