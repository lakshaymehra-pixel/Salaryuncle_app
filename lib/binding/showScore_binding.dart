import 'package:get/get.dart';

import '../controller/show_score_controller.dart';

class ShowScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShowScoreController());
  }
}
