import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/models/registerRequest.dart';
import 'package:tejas_loan/utils/events.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../services/api_constant/api_constants.dart';
import '../services/api_service.dart';
import '../utils/geo_locator.dart';
import '../utils/shared_constants.dart';
import 'internet_connectivity_controller.dart';

class LogingController extends GetxController {
  var checkedValue = false.obs;
  var isFoused = false.obs;

  var otpEnable = false.obs;
  var isResend = false.obs;
  var isUpLift = false.obs;
  var isReadMore = false.obs;

  var isLoadingOnSendOTP = false.obs;
  var isLoadingOnRegister = false.obs;

  var numberController = TextEditingController().obs;
  final countdown_controller = CountdownController(autoStart: true).obs;

  var OTP = "".obs;
  var profile_id = "".obs;
  var appflyer_profile_id = "".obs;
  ConnectionManagerController connectionManagerController = Get.find<ConnectionManagerController>();

  @override
  void onInit() {
    try {
      firebaseIntialize();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    numberController.value.dispose();
  }

  sendOTP(String number) async {
    prefs.setBool(SharedConstants.ISLOGIN, false);
    isResend.value = false;
    isLoadingOnRegister.value = true;

    // var a_id = await appsflyerSdk!.getAppsFlyerUID();
    if (connectionManagerController.connectivityResult != ConnectivityResult.none) {
      if (numberController.value.text.length >= 10) {
        // if (otpEnable.value == false) {
        isLoadingOnSendOTP.value = true;
        var fcmToken = prefs.getString(SharedConstants.FCM_TOKEN);
        RegisterRequest requestOtpModel = RegisterRequest();
        requestOtpModel.mobile = numberController.value.text;
        requestOtpModel.fcmToken = fcmToken;

        if (numberController.value.text != "9999999999") {
          try {
            var result = await ApiService().postMethod(body: {
              "event_name": Events.LOGIN,
              "mobile": numberController.value.text,
              // "appflyer_uid": a_id,
              "utm_source_test": prefs.getString(SharedConstants.UTM_SOURCE), //
            }, header: APIConstants.apiHeader1, baseUrl: APIConstants.getBaseUrl());

            if (result != null) {
              // try {
              //   appsflyerSdk!.setCustomerUserId(result["Data"]['appflyer_profile_id'].toString());
              //
              //   appsflyerSdk!.logEvent("login", {
              //     "status": result['Status'],
              //     "message": result['Message'],
              //   }).then((result) {
              //     print('Event successfully logged: $result');
              //   }).catchError((error) {
              //     print('Error logging event: $error');
              //   });
              // } catch (e) {
              //   print(e);
              // }
              if (result['Status'].toString() == "1") {
                ShortMessage.toast(title: result['Message'].toString());
                otpEnable.value = true;
                countdown_controller.value.restart();
                isLoadingOnSendOTP.value = false;
                profile_id.value = result["Data"]['cust_profile_id'].toString();
                Get.toNamed(RoutesName.OTPScreen);

                try {
                  prefs.setString(
                      SharedConstants.APPFLYER_PROFILE_ID, result["Data"]['appflyer_profile_id'].toString());

                  if (kDebugMode) {
                    print(result["Data"]['appflyer_profile_id'].toString());
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              } else {
                ShortMessage.toast(title: result['Message'].toString());
              }
            } else {
              Fluttertoast.showToast(msg: "Server Error !!");
            }
            isLoadingOnSendOTP.value = false;
          } catch (e) {
            Fluttertoast.showToast(msg: "Something went wrong !!");
            isLoadingOnSendOTP.value = false;
            debugPrint(e.toString());
          }
        } else {
          /** For testing */

          otpEnable.value = true;
          Get.toNamed(RoutesName.OTPScreen);
          countdown_controller.value.restart();
          isLoadingOnSendOTP.value = false;
          ShortMessage.toast(title: "OTP Send Successfully");
        }
      } else {
        Fluttertoast.showToast(msg: "Invalid Number !!");
      }
    } else {
      ShortMessage.toast(title: "Check Internet Connection");
    }
    isLoadingOnRegister.value = false;
  }

  reSendOTP() async {
    prefs.setBool(SharedConstants.ISLOGIN, false);
    // var fcmToken = prefs.getString(SharedConstants.FCM_TOKEN);

    if (connectionManagerController.connectivityResult != ConnectivityResult.none) {
      if (numberController.value.text.length >= 10) {
        if (otpEnable.value == true) {
          isLoadingOnSendOTP.value = true;

          try {
            var result = await ApiService().postMethod(body: {
              "event_name": Events.RESEND_OTP,
              "profile_id": profile_id.value,
              "mobile": numberController.value.text
            }, header: APIConstants.apiHeader1, baseUrl: APIConstants.getBaseUrl());

            if (result != null) {
              // appsflyerSdk!.logEvent("resent_otp", {
              //   "status": result['Status'],
              //   "message": result['Message'],
              // }).then((result) {
              //   print('Event successfully logged: $result');
              // }).catchError((error) {
              //   print('Error logging event: $error');
              // });
              if (result['Status'].toString() == "1") {
              } else {
                ShortMessage.toast(title: result['Message'].toString());
              }
            } else {
              Fluttertoast.showToast(msg: "Server Error !!");
            }
            isLoadingOnSendOTP.value = false;
          } catch (e) {
            Fluttertoast.showToast(msg: "Something went wrong !!");
            isLoadingOnSendOTP.value = false;
            debugPrint(e.toString());
          }
        }
        isResend.value = false;
        countdown_controller.value.restart();
      } else {
        Fluttertoast.showToast(msg: "Invalid Number !!");
      }
    } else {
      ShortMessage.toast(title: "Check Internet Connection");
    }
  }

  register() async {
    try {
      GeoLocation().determinePosition().then(
          (value) => prefs.setString(SharedConstants.LATLONG, "${value.latitude},${value.longitude.toString()}"));
    } catch (e) {
      prefs.setString(SharedConstants.LATLONG, "0.0,0.0");
      if (kDebugMode) {
        print(e);
      }
    }
    isLoadingOnRegister.value = true;
    if (checkedValue.value) {
      if (OTP.value.length == 4) {
        if (numberController.value.text != "9999999999") {
          try {
            var result = await ApiService().postMethod(body: {
              "event_name": Events.OTP_VERIFY,
              "profile_id": profile_id.value,
              "otp": OTP.value,
              "fcm": prefs.getString(SharedConstants.FCM_TOKEN) ?? ""
            }, header: APIConstants.apiHeader1, baseUrl: APIConstants.getBaseUrl());

            if (result != null) {
              //appfyler_advertiser_id
              // utm_source
              // utm_medium
              // utm_term
              // utm_campaign
              // device_id
              // try {
              //   appsflyerSdk!.setCustomerUserId(prefs.getString(SharedConstants.APPFLYER_PROFILE_ID).toString());
              // } catch (e) {
              //   print(e);
              // }
              // appsflyerSdk!.logEvent("otp_verify", {
              //   "profile_id": profile_id.value,
              //   "status": result['Status'],
              //   "message": result['Message'],
              // }).then((result) {
              //   print('Event successfully logged: $result');
              // }).catchError((error) {
              //   print('Error logging event: $error');
              // });
              if (result['Status'].toString() == "1") {
                ShortMessage.toast(title: result['Message'].toString());
                prefs.setString(SharedConstants.TOKEN, result['token'].toString());

                try {
                  prefs.setString(SharedConstants.PANCARD, result['Data']['pancard'] ?? "");
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
                otpEnable.value = true;
                countdown_controller.value.restart();
                isLoadingOnSendOTP.value = false;
                prefs.setBool(SharedConstants.ISLOGIN, true);

                prefs.setString(SharedConstants.MOBILE, numberController.value.text);

                prefs.setString(SharedConstants.TOKEN, result['Data']['app_login_token'].toString());

                prefs.setString(SharedConstants.PROFILE_ID, profile_id.value.toString());

                prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
                prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['step_percentage'] ?? 0);

                if (Events.getCurrentEvent() > 3) {
                  Get.offAllNamed(RoutesName.DashbroadScreen);
                } else {
                  Get.offAllNamed(RoutesName.PanScreen);
                }
              } else {
                prefs.setBool(SharedConstants.ISLOGIN, false);
                ShortMessage.toast(title: result['Message'].toString());
              }
            }
            isLoadingOnRegister(false);
          } catch (e) {
            isLoadingOnRegister(false);
            debugPrint(e.toString());
          }
        } else {
          if (OTP.value == "0000") {
            prefs.setBool(SharedConstants.ISLOGIN, true);
            prefs.setString(SharedConstants.MOBILE, numberController.value.text);
            prefs.setString(SharedConstants.PROFILE_ID, profile_id.value.toString());
            prefs.setString(SharedConstants.CURRENTSCREEN, RoutesName.OccupationScreen);
            Get.offAllNamed(RoutesName.OccupationScreen);
            Fluttertoast.showToast(msg: "OTP has verified !!");
          } else {
            Fluttertoast.showToast(msg: "Invalid OTP !!");
          }
        }
        // Fluttertoast.showToast(msg: "OTP has verified !!");
      } else {
        Fluttertoast.showToast(msg: "Invalid OTP !!");
      }
    } else {
      Fluttertoast.showToast(msg: "Please Accept the Terms and Conditions!!");
    }
    isLoadingOnRegister.value = false;
  }
}
