import 'package:get/get.dart';
import 'package:tejas_loan/controller/loan_calculator_controller.dart';

import '../controller/internet_connectivity_controller.dart';

class LoanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanCalculatorController>(() => LoanCalculatorController());
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}
