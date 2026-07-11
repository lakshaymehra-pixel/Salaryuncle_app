import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/models/lead_customer_model.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../custom_widgets/custom_toast_snack_bar.dart';
import '../routes/routes_names.dart';
import '../services/api_constant/api_constants.dart';
import '../services/api_service.dart';
import '../utils/events.dart';

class DashDetailController extends GetxController {
  var loading2 = false.obs;
  var leadData = LeadCustomerModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    var leadId = Get.arguments.toString();
    getLeadDetails(leadId);

    super.onInit();
  }

  getLeadDetails(var leadId) async {
    try {
      loading2.value = true;
      var result = await ApiService().postMethod(
        baseUrl: APIConstants.getBaseUrl(uri: APIConstants.GETLEAD_DETAILS),
        body: {
          "lead_id": leadId,
        },
        header: APIConstants.getApiHeader(
            prefs.getString(SharedConstants.TOKEN) ?? ""),
      );

      if (result != null) {
        if (result['Status'].toString() == "1") {
          ShortMessage.toast(title: result['Message'].toString());
          // try {
          leadData.value = LeadCustomerModel.fromJson(result);
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
    loading2.value = false;
  }
}
