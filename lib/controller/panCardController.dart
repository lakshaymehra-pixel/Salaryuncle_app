import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../custom_widgets/custom_toast_snack_bar.dart';
import '../services/api_constant/api_constants.dart';
import '../services/api_service.dart';
import 'internet_connectivity_controller.dart';

class PanCardController extends GetxController {
  RxBool isLoading = false.obs;
  var isLoadingOnFind = false.obs;
  var keyboardType = TextInputType.name.obs;
  var selectedDate = DateTime.now().obs;
  var panNoController =
      TextEditingController(text: prefs.getString(SharedConstants.PANCARD)).obs;
  var panNoController2 = TextEditingController().obs;
  var panNoController3 = TextEditingController().obs;
  var salaryController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var dobController = TextEditingController().obs;
  var myFocusNode = FocusNode().obs;
  var allowedRegex =
      FilteringTextInputFormatter.allow(RegExp('[0-9,a-z,A-Z]')).obs;

  ConnectionManagerController connectionManagerController =
      Get.find<ConnectionManagerController>();
  final df = DateFormat('dd/MM/yyyy');

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(DateTime.now().subtract(const Duration(days: 6574)).year));
    if (picked != null && picked != selectedDate.value) {
      dobController.value.text = df.format(picked);
    }
  }

  findPAN() async {
    // try {
    //   await GeoLocation().determinePosition().then((value) => prefs.setString(
    //       SharedConstants.LATLONG,
    //       "${value.latitude.toString()},${value.longitude.toString()}"));
    // } catch (e) {
    //   prefs.setString(SharedConstants.LATLONG, "0.0,0.0");
    //   print(e);
    // }
    if (connectionManagerController.connectivityResult !=
        ConnectivityResult.none) {
      if (panNoController.value.text.length < 10) {
        Fluttertoast.showToast(msg: "Please Enter Your Pan !!");
      } else if (salaryController.value.text.isEmpty) {
        Fluttertoast.showToast(msg: "Please Enter Your Salary !!");
      } else {
        var profileId = prefs.getString(SharedConstants.PROFILE_ID);
        isLoadingOnFind.value = true;

        try {
          var result = await ApiService().postMethod(
              body: {
                "event_name": "pancard_verification",
                "profile_id": profileId.toString(),
                "pancard": panNoController.value.text,
                "monthly_income": salaryController.value.text
              },
              header: APIConstants.getApiHeader(
                  prefs.getString(SharedConstants.TOKEN) ?? ""),
              baseUrl: APIConstants.getBaseUrl());

          if (result != null) {
            // try {
            //   appsflyerSdk!.setCustomerUserId(prefs
            //       .getString(SharedConstants.APPFLYER_PROFILE_ID)
            //       .toString());
            // } catch (e) {
            //   print(e);
            // }
            // appsflyerSdk!.logEvent("pancard_verification", {
            //   "profile_id": profile_id.toString(),
            //   "status": result['Status'].toString(),
            //   "message": result['Message'].toString(),
            // }).then((result) {
            //   print('Event successfully logged: $result');
            // }).catchError((error) {
            //   print('Error logging event: $error');
            // });
            if (result['Status'] == 1) {
              isLoadingOnFind.value = false;
              ShortMessage.toast(title: result['Message'].toString());

              prefs.setString(
                  SharedConstants.PANCARD, panNoController.value.text);
              prefs.setString(
                  SharedConstants.SALARY, salaryController.value.text);
              prefs.setString(
                  SharedConstants.NAME, result['Data']['full_name'] ?? "");
              prefs.setString(SharedConstants.DOB, result['Data']['dob'] ?? "");
              prefs.setString(SharedConstants.STEP_STAGE,
                  result['Data']['next_step'] ?? "");
              prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT,
                  result['Data']['step_percentage'] ?? 0);

              Get.offAllNamed(RoutesName.DashbroadScreen);
            } else if (result['Status'] == 4) {
              prefs.clear();
              prefs.setBool(SharedConstants.ISLOGIN, false);
              Get.offAllNamed(RoutesName.LoginScreen);
              ShortMessage.toast(title: result['Message'].toString());
            } else if (result['Status'] == 2) {
              isLoadingOnFind.value = false;
              ShortMessage.toast(title: result['Message'].toString());
            } else {
              ShortMessage.toast(title: result['Message'].toString());
              isLoadingOnFind.value = false;
            }
            isLoadingOnFind.value = false;
          } else {
            ShortMessage.toast(title: "Something went wrong !!");
            isLoadingOnFind.value = false;
          }
        } catch (e) {
          ShortMessage.toast(title: "Something went wrong !!");
          isLoadingOnFind.value = false;
          debugPrint(e.toString());
        }
      }
    } else {
      ShortMessage.toast(title: "Check Internet Connection");
    }
  }
}
