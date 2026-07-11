import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/models/RepaymentModel.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

class RepaymentHistoryController extends GetxController {
  var loading = false.obs;
  var collection = <RepaymentModel>[].obs;

  @override
  void onInit() {
    getLeadDetails();
    super.onInit();
  }

  Future<List<RepaymentModel>?> getLeadDetails() async {
    try {
      loading.value = true;
      collection.clear();
      var list =
          jsonDecode(prefs.getString(SharedConstants.REPAYMENT_HISTORY) ?? "[]")
              as List;

      for (var element in list) {
        collection.add(RepaymentModel.fromJson(element));
      }
      if (kDebugMode) {
        print("REPAYMENT HISTORY ==>$collection");
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
