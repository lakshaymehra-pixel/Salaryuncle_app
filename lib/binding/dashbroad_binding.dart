import 'package:get/get.dart';

import '../controller/dashbroadController.dart';

class DashbroadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashbroadController());
    // Get.lazyPut(() => StatusController());
    // Get.lazyPut(() => ConnectionManagerController());
  }
}
