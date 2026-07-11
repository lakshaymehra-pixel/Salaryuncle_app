import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/models/lead_customer_model.dart';

import '../custom_widgets/custom_toast_snack_bar.dart';
import '../routes/routes_names.dart';
import '../services/api_constant/api_constants.dart';
import '../services/api_service.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';
import 'dashbroadController.dart';

class PreviewController extends GetxController {
  var loading = false.obs;
  var isEligible = (prefs.getBool(SharedConstants.ELIGIBLE) ?? false).obs;
  var eventName = (prefs.getString(SharedConstants.STEP_STAGE) ?? "").obs;
  var leadData = LeadCustomerModel().obs;
  var dashbroadController = Get.find<DashbroadController>();


  getLeadDetails(var leadId) async {
    try {
      loading.value = true;
      var result = await ApiService().postMethod(
          uri: APIConstants.GETLEAD_DETAILS,
          body: {
            "lead_id": leadId,
          },
          header: APIConstants.apiHeader,
          baseUrl: APIConstants.getBaseUrl());

      if (result != null) {
        if (result['Status'].toString() == "1") {
          ShortMessage.toast(title: result['Message'].toString());
          // try {
          leadData.value = LeadCustomerModel.fromJson(result['data'][0]);
          // } catch (e) {
          //   print(e);
          // }
        } else if (result['Status'] == 3) {
          Get.offAllNamed(RoutesName.DashbroadScreen);
          ShortMessage.toast(title: result['Message'].toString());
        } else if (result['Status'] == 4) {
          Events.logout();
          ShortMessage.toast(title: result['Message'].toString());
        } else {
          ShortMessage.toast(title: result['Message'].toString());
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    loading.value = false;
  }
}
