import 'package:get/get.dart';

import '../controller/personalDetailsController.dart';

class PersonalDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalDetailController>(() => PersonalDetailController());
  }
}
