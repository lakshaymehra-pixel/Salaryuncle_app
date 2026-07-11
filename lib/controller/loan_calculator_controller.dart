import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/models/resTypeModel.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../main.dart';
import 'internet_connectivity_controller.dart';

class LoanCalculatorController extends GetxController {
  var connectionManagerController = Get.put(ConnectionManagerController()).obs;
  var height = Get.height;
  var width = Get.width;
  var value = 50.0.obs;
  var currentLoanAmount = ((prefs.getInt(SharedConstants.MIN_LOAN) ?? 5000) / 1000).toDouble().obs;
  var purposeController = TextEditingController().obs;
  var currentTenure = (prefs.getInt(SharedConstants.MIN_TENURE) ?? 7).toDouble().obs;
  var loading = false.obs;
  var intersetValue = 1.0.obs;
  var maxLoanAmount = ((prefs.getInt(SharedConstants.MAX_LOAN) ?? 100000) / 1000).obs;
  var maxTenure = (prefs.getInt(SharedConstants.MAX_TENURE) ?? 40).obs;
  var minLoanAmount = ((prefs.getInt(SharedConstants.MIN_LOAN) ?? 5000) / 1000).obs;
  var appflyer_profile_id = prefs.getString(SharedConstants.APPFLYER_PROFILE_ID) ?? "";

  // ((prefs.getInt(SharedConstants.MIN_LOAN) ?? 5000) / 1000).obs;
  // var minTenure = (prefs.getInt(SharedConstants.MIN_TENURE) ?? 7).obs;
  var minTenure = (prefs.getInt(SharedConstants.MIN_TENURE) ?? 7).obs;
  var purposeList = <Restypemodel>[
    Restypemodel(name: "SELECT", id: "0"),
    Restypemodel(name: "TRAVEL", id: "4"),
    Restypemodel(name: "MEDICAL", id: "5"),
    Restypemodel(name: "ACADEMICS", id: "6"),
    Restypemodel(name: "OBLIGATION", id: "7"),
    Restypemodel(name: "FESTIVAL", id: "8"),
    Restypemodel(name: "PURCHASE", id: "9"),
    Restypemodel(name: "OTHERS", id: "10"),
  ].obs;
  var purposeValue = (Restypemodel(name: "SELECT", id: "0")).obs;
  var totalValue = ValueNotifier(0.0).obs;
  var maxValue = 0.0.obs;

  @override
  void onInit() {
    // yearValue = (((yearValue / 1.43) / (minTenure.toInt())) * 10).toDouble();
    // print(yearValue);
    // print("minTenure" + minTenure.toString());
    // print("maxTenure" + maxTenure.toString());
    // print("yearValue" + yearValue.toString());
    // print("minLoanAmount" + minLoanAmount.toString());
    // print("maxLoanAmount" + maxLoanAmount.toString());

    // currentTenure.value = 0.0045 * maxTenure.value;
    //
    // currentLoanAmount.value = 5.0;
    // // currentLoanAmount.value = (minLoanAmount.value / maxLoanAmount.value);

    var savedLoanAmount = prefs.getString(SharedConstants.LOAN_AMOUNT) ?? "0.0";
    var savedTenure = prefs.getString(SharedConstants.TENURE) ?? "0.0";

    try {
      // print("savedLoanAmount" + savedLoanAmount.toString());
      // print("savedTenure1" + savedTenure.toString());

      // currentLoanAmount.value = double.parse(savedLoanAmount) / 1000;
      if (!(Get.arguments ?? false)) {
        if (savedLoanAmount != "0.0") {
          currentLoanAmount.value = double.parse(savedLoanAmount) / 1000;
        }
        if (savedTenure != "0.0") {
          currentTenure.value = double.parse(savedTenure);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    maxValue.value =
        (maxLoanAmount.value + (maxLoanAmount.value / 100) * maxTenure.value);
    totalValue.value.value = currentLoanAmount.value +
        (currentLoanAmount.value / 100) * currentTenure.value;
    final savedPurpose = prefs.getString(SharedConstants.PURPOSE) ?? "";
    if (savedPurpose.isNotEmpty && !(Get.arguments ?? false)) {
      purposeValue.value =
          purposeList.where((p0) => p0.name == savedPurpose).first;
    }

    super.onInit();
  }
}
