import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/utils/events.dart';

import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../services/api_constant/api_constants.dart';
import '../services/api_service.dart';
import '../utils/shared_constants.dart';
import 'internet_connectivity_controller.dart';

class BankController extends GetxController {
  var appflyer_profile_id = prefs.getString(SharedConstants.APPFLYER_PROFILE_ID) ?? "";
  var accountNumberController = TextEditingController(text: prefs.getString(SharedConstants.BANKNUMBER)).obs;
  var accountNumberFocusNode = FocusNode().obs;
  var confirmAccountNumberController = TextEditingController(text: prefs.getString(SharedConstants.BANKNUMBER)).obs;
  var nameController = TextEditingController(text: prefs.getString(SharedConstants.NAMEONBANK)).obs;
  var ifscController = TextEditingController(text: prefs.getString(SharedConstants.IFSC)).obs;
  var branchController = TextEditingController(text: prefs.getString(SharedConstants.BRANCH_NAME)).obs;
  ConnectionManagerController connectionManagerController = Get.find<ConnectionManagerController>();
  var isLoading = false.obs;

  @override
  void dispose() {
    super.dispose();
    accountNumberController.value.dispose();
    nameController.value.dispose();
    ifscController.value.dispose();
    branchController.value.dispose();
  }

  findBANK() async {
    if (connectionManagerController.connectivityResult != ConnectivityResult.none) {
      if (accountNumberController.value.text.trim().length < 6) {
        ShortMessage.toast(title: "Please Enter Valid Account Number");
      } else if (confirmAccountNumberController.value.text.trim().length < 6) {
        ShortMessage.toast(title: "Please Enter Valid Confirm Account Number");
      } else if (nameController.value.text.trim().length < 3) {
        ShortMessage.toast(title: "Please Enter Valid Name");
      } else if (branchController.value.text.trim().length < 3) {
        ShortMessage.toast(title: "Please Enter Valid Branch Name");
      } else if (ifscController.value.text.trim().length < 6) {
        ShortMessage.toast(title: "Please Enter Valid IFSC Code");
      } else if (accountNumberController.value.text.trim() != confirmAccountNumberController.value.text.trim()) {
        ShortMessage.toast(title: "Please Enter Same Account Number");
      } else {
        isLoading.value = true;
        try {
          var result = await ApiService().postMethod(
              header: APIConstants.getApiHeader(prefs.getString(SharedConstants.TOKEN).toString()),
              body: {
                "profile_id": prefs.getString(SharedConstants.PROFILE_ID).toString(),
                "event_name": Events.BANKING_DETAILS,
                "account_branch": branchController.value.text.trim(),
                "account_type_id": 1, // Saving
                "account_ifsc": ifscController.value.text.trim(),
                "account_number": accountNumberController.value.text.trim(),
                "confirm_account_number": accountNumberController.value.text.trim(),
                "verification_consent": 1,
                "account_name": nameController.value.text.trim()
              },
              baseUrl: APIConstants.getBaseUrl(uri: "saveleadDetails"));
          debugPrint("Request ${result.toString()}");

          if (result != null) {
            // try {
            //   appsflyerSdk!.setCustomerUserId(prefs.getString(SharedConstants.APPFLYER_PROFILE_ID).toString());
            // } catch (e) {
            //   print(e);
            // }
            // appsflyerSdk!.logEvent("banking_details", {
            //   "profile_id": prefs.getString(SharedConstants.PROFILE_ID).toString(),
            //   "status": result['Status'].toString(),
            //   "message": result['Message'].toString(),
            // }).then((result) {
            //   print('Event successfully logged: $result');
            // }).catchError((error) {
            //   print('Error logging event: $error');
            // });
            if (result["Status"] == 1) {
              isLoading.value = false;
              ShortMessage.toast(title: result["Message"].toString());
              prefs.setString(SharedConstants.BANKNUMBER, accountNumberController.value.text);
              prefs.setString(SharedConstants.NAMEONBANK, nameController.value.text);
              prefs.setString(SharedConstants.IFSC, ifscController.value.text);
              prefs.setString(SharedConstants.BRANCH_NAME, branchController.value.text);

              Get.offNamed(RoutesName.ThankyouScreen);
            } else if (result['Status'] == 3) {
              Get.offAllNamed(RoutesName.DashbroadScreen);
              ShortMessage.toast(title: result['Message'].toString());
            } else if (result['Status'] == 4) {
              Events.logout();
              ShortMessage.toast(title: result['Message'].toString());
            } else {
              isLoading.value = false;
              ShortMessage.toast(title: result["Message"].toString());
            }

            isLoading.value = false;
          } else {
            isLoading.value = false;
          }
        } catch (e) {
          ShortMessage.toast(title: "Please Enter Valid Details");
          isLoading.value = false;
          debugPrint(e.toString());
        }
      }
    } else {
      ShortMessage.toast(title: "Check Internet Connection");
    }
  }
}
