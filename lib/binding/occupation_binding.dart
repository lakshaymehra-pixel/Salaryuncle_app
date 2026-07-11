import 'package:get/get.dart';

import '../controller/occupation_controller.dart';

class OccupationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OccupationController>(() => OccupationController());
  }
}
