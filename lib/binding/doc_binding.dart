import 'package:get/get.dart';

import '../controller/docController.dart';
import '../controller/internet_connectivity_controller.dart';

class DocBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocController>(() => DocController());
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
