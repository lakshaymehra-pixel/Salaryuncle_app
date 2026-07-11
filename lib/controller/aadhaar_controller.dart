import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/models/OKYC_Aadhaar.dart';
import 'package:tejas_loan/models/VerifyAadhaarOTP_Resposen.dart';
import 'package:tejas_loan/models/aadhaarOtpResponse.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../services/api_constant/api_constants.dart';
import '../services/api_service.dart';
import '../utils/shared_constants.dart';
import 'internet_connectivity_controller.dart';

class AadhaarController extends GetxController {
  var isEnabled = false.obs;
  var isLoadingOnSendOTP = false.obs;
  var isLoadingProceed = false.obs;
  var OTP = "".obs;
  var request_Id = "".obs;

  ConnectionManagerController connectionManagerController =
      Get.find<ConnectionManagerController>();
  var aadhaarController = TextEditingController().obs;


  sendAadhaarOTP(String number) async {
    OKYC_Aadhaar okyc_aadhaar = OKYC_Aadhaar();
    okyc_aadhaar.aadhaarNumber = number;
    if (connectionManagerController.connectivityResult !=
        ConnectivityResult.none) {
      if (aadhaarController.value.text.length >= 10) {
        if (isEnabled.value == false) {
          isLoadingOnSendOTP.value = true;

          try {
            var result = await ApiService().postMethod(
                baseUrl: APIConstants.PRODBaseUrlSURF,
                uri: APIConstants.OKYC_Aadhaar,
                body: okyc_aadhaar,
                header: APIConstants.apiHeader);

            if (result != null) {
              GetAadhaarOTP_Responsse getAadhaarOTP_Responsse =
                  GetAadhaarOTP_Responsse.fromJson(result);
              if (getAadhaarOTP_Responsse.statusCode.toString() == "200" &&
                  getAadhaarOTP_Responsse.data!.otpSentStatus.toString() ==
                      "true") {
                request_Id.value =
                    getAadhaarOTP_Responsse.data!.requestId.toString();
                isEnabled.value = true;
                isLoadingOnSendOTP.value = false;
                ShortMessage.toast(
                    title:
                        "OTP has been sent to your registered mobile number");
              } else {
                isLoadingOnSendOTP.value = false;
                ShortMessage.toast(title: "Enter Valid Aadhaar Number!!");
              }
            } else {
              isLoadingOnSendOTP.value = false;
            }
          } catch (e) {
            isLoadingOnSendOTP.value = false;
            debugPrint(e.toString());
          }
        }
      } else {
        ShortMessage.toast(title: "Invalid Number !!");
      }
    } else {
      ShortMessage.toast(title: "Check Internet Connection");
    }
  }

  verifyOTP() async {
    debugPrint("OTP==>${OTP.value}");
    if (OTP.value.length == 6) {
      try {
        isLoadingProceed.value = true;
        var result = await ApiService().postMethod(
            uri: APIConstants.Fech_Okyc,
            body: {"requestId": request_Id.value, "otp": OTP.value},
            header: APIConstants.apiHeader1,
            baseUrl: APIConstants.PRODBaseUrlSURF);
        if (result != null) {
          VerifyAadhaarOTP_Responsse aadhaarOTP_Responsse =
              VerifyAadhaarOTP_Responsse.fromJson(result);
          isLoadingProceed.value = false;
          // debugPrint(
          //     "STATUSCODE==>${aadhaarOTP_Responsse.statusCode.toString()}");
          if (aadhaarOTP_Responsse.statusCode.toString() == "200") {
            Fluttertoast.showToast(
              msg: "Aadhaar Verification Successfully",
            );
            prefs.setString(
                SharedConstants.AADHAAR, aadhaarController.value.text);
            prefs.setString(
                SharedConstants.CURRENTSCREEN, RoutesName.BankScreen);

            Get.offAllNamed(RoutesName.BankScreen);
          }
        } else {
          isLoadingProceed.value = false;
        }
      } catch (e) {
        isLoadingProceed.value = false;
        debugPrint(e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "Invalid OTP !!");
    }
  }
}
