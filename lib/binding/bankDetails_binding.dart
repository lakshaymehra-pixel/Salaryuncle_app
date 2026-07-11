import 'package:get/get.dart';
import 'package:tejas_loan/controller/bankController.dart';

import '../controller/internet_connectivity_controller.dart';

class BankDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankController>(() => BankController());
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
