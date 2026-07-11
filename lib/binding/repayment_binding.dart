import 'package:get/get.dart';

import '../controller/repayment_controller.dart';

class RepaymentHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepaymentHistoryController>(() => RepaymentHistoryController());
  }
}
