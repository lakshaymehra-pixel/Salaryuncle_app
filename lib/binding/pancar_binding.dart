import 'package:get/get.dart';

import '../controller/panCardController.dart';
import '../controller/internet_connectivity_controller.dart';

class PanCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PanCardController>(() => PanCardController());
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
