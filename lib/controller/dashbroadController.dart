import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';

import '../main.dart';
import '../models/verifyOtpResponse.dart';
import '../routes/routes_names.dart';
import '../services/api_constant/api_constants.dart';
import '../services/api_service.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';
import 'internet_connectivity_controller.dart';

class DashbroadController extends GetxController {
  var connectionManagerController = Get.put(ConnectionManagerController());
  var allLead = <AllLeads>[].obs;
  var loadingOnDashboard = false.obs;
  var profile_id = prefs.getString(SharedConstants.PROFILE_ID) ?? "";
  var number = prefs.getString(SharedConstants.MOBILE) ?? "";
  var token = prefs.getString(SharedConstants.TOKEN) ?? "";
  var loadingOnApply = false.obs;
  final df = DateFormat('yyyy-MM-dd');
  var advancedDrawerController = AdvancedDrawerController().obs;
  var pageController = PageController(initialPage: 0).obs;
  var selectedIndex = 0.obs;
  var selectedIndex1 = 0.obs;
  var selectedDrawerIndex = 0.obs;

  @override
  void onInit() {
    // getDashboard();
    if (Events.getCurrentEvent() > 3 ) {
      // debugPrint(Events.getCurrentEvent());
      if (number != "9999999999") getLeadDetails();
    }
    super.onInit();
  }

  logout(var context) {
    return showDialog(
        context: context,
        builder: (builder) =>
            AlertDialog(title: const Text("Logout"), content: const Text("Are you sure you want to logout?"), actions: [
              TextButton(
                  child: const Text("No",style: TextStyle(color: Colors.green),),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: const Text("Yes",style: TextStyle(color: Colors.red),),
                  onPressed: () {
                   Events.logout();
                  }),

            ]));
  }

  getLeadDetails() async {
    try {
      loadingOnDashboard.value = true;

      debugPrint("CHECK");
      // await Future.delayed(Duration(seconds: 1), () {});

      var result = await ApiService().postMethod(
          body: {"pancard": prefs.getString(SharedConstants.PANCARD)},
          header: APIConstants.getApiHeader(token),
          baseUrl: APIConstants.getBaseUrl(uri: "getLeadList"));
      if (result != null) {
        if (result['Status'] == 1) {
          allLead.clear();
          var data = (result['Data']['lead_list'] as List);
          for (var element in data) {
            allLead.add(AllLeads.fromJson(element));
          }
          if (APIConstants.isModeDevelopment()) debugPrint("ALL_LEAD==>$allLead");
        } else if (result['Status'] == 3) {
          Get.offAllNamed(RoutesName.DashbroadScreen);
        } else if (result['Status'] == 4) {
          Events.logout();
        } else {
          ShortMessage.toast(title: result['Message'].toString());
        }
      }
    } catch (e) {
      if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON ALL_LEAD==>$e");
    }
    loadingOnDashboard.value = false;
  }

  checkLoanQuote() async {
    try {
      loadingOnDashboard.value = true;

      var result = await ApiService().postMethod(
          body: {"profile_id": profile_id, "event_name": Events.GENERATE_LOAN_QUOTE},
          header: APIConstants.getApiHeader(token),
          baseUrl: APIConstants.getBaseUrl(uri: "saveleadDetails"));

      if (result != null) {
        if (result['Status'] == 1) {
          prefs.setInt(SharedConstants.MIN_LOAN, result['Data']['min_loan_amount']);
          prefs.setInt(SharedConstants.MAX_LOAN, result['Data']['max_loan_amount']);
          prefs.setInt(SharedConstants.MIN_TENURE, result['Data']['min_loan_tenure']);
          prefs.setInt(SharedConstants.MAX_TENURE, result['Data']['max_loan_tenure']);
          prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
          prefs.setBool(SharedConstants.ELIGIBLE, true);
          prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['step_percentage'] ?? 0);
          Events.getNextEvent(result['Data']['next_step'].toString());
        } else if (result['Status'] == 4) {
          prefs.clear();
          Get.offAllNamed(RoutesName.LoginScreen);
          ShortMessage.toast(title: result['Message'].toString());
        } else {
          ShortMessage.toast(title: result['Message'].toString());
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    loadingOnDashboard.value = false;
  }

  getLeadStatus(var leadId) async {
    if (loadingOnDashboard.value == false) {
      loadingOnDashboard.value = true;
      var stepStage = prefs.getInt(SharedConstants.STEP_STAGE) ?? 1;

      if (stepStage == 1) {
        Get.toNamed(RoutesName.PanScreen);
      } else if (stepStage == 2) {
        Get.toNamed(RoutesName.ResidenceDetailsScreen);
      } else if (stepStage == 3) {
        Get.toNamed(RoutesName.PersonalDetailsScreen);
      } else if (stepStage == 4) {
        Get.toNamed(RoutesName.IncomeDetailsScreen);
      } else if (stepStage == 5) {
        Get.toNamed(RoutesName.DocScreen, arguments: [true]);
      } else if (stepStage == 6) {
        Get.toNamed(RoutesName.DocScreen, arguments: [false]);
      } else if (stepStage == 7) {
        Get.toNamed(RoutesName.EmploymentDetailsScreen);
      } else if (stepStage == 8) {
        Get.toNamed(RoutesName.LoanSelect, arguments: false);
      } else if (stepStage >= 9) {
        Get.toNamed(RoutesName.LoanSelect, arguments: false);
      } else {
        Get.toNamed(RoutesName.OccupationScreen);
      }

      loadingOnDashboard.value = false;
    }
  }

  onItemTapped(int index) {
    HapticFeedback.mediumImpact();
    selectedIndex.value = index;
    selectedIndex1.value = index;
    if (index == 0) {
      selectedDrawerIndex.value = index;
    } else if (index != 2) {
      selectedDrawerIndex.value = index + 1;
    } else {
      selectedDrawerIndex.value = 0;
    }
    //   if (index != 0) {
    //     pageController.value.jumpToPage(index);
    //   } else {
    //     Get.offAllNamed(RoutesName.DashbroadScreen);
    //   }
    // }
  }
}
