import 'package:get/get.dart';

import '../controller/internet_connectivity_controller.dart';
import '../controller/preview_controller.dart';
import '../controller/status_controller.dart';

class PreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewController>(() => PreviewController());
    Get.lazyPut<StatusController>(() => StatusController());
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
