import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/models/DashbroadModel.dart';
import 'package:tejas_loan/models/bannerModel;.dart';
import 'package:tejas_loan/utils/image_constants.dart';
import 'package:tejas_loan/views/payment_failed_page.dart';

import '../main.dart';
import '../models/verifyOtpResponse.dart';
import '../routes/routes_names.dart';
import '../services/api_constant/api_constants.dart';
import '../services/api_service.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';
import '../views/payment_success_page.dart';

class HomeController extends GetxController {
  var allLead = <AllLeads>[].obs;
  var loading = false.obs;
  var loadingOnContinue = false.obs;
  var loadingOnRepay = false.obs;
  var dashBroad = DashbroadModel().obs;
  var controller;
  var selectedIndex = 0.obs;
  var profile_id = prefs.getString(SharedConstants.PROFILE_ID) ?? "";
  var number = prefs.getString(SharedConstants.MOBILE) ?? "";
  var token = prefs.getString(SharedConstants.TOKEN) ?? "";
  var themeMode = ThemeMode.system;
  var isDarkMode = Get.theme.brightness == Brightness.dark;

  var bannerList2 = <String>[ImageConstants.CompanyLogo, ImageConstants.CompanyLogo, ImageConstants.CompanyLogo].obs;
  var isBanner = false.obs;
  var bannerList = <BannerModel>[].obs;
  final df = DateFormat('yyyy-MM-dd');
  DashbroadController dashbroadController = Get.find<DashbroadController>();

  // late PayUCheckoutProFlutter _checkoutPro;

  @override
  void onInit() async {
    // loading.value = true;
    if (Events.getCurrentEvent() > 3) {
      if (number != "9999999999") await getDashboard();
    }

    try {
      allLead.clear();
      if (Events.getCurrentEvent() > 3) {
        debugPrint("EVENTS ==>"+Events.getCurrentEvent().toString());
        if (number != "9999999999") await getLeadDetails();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    // _checkoutPro = PayUCheckoutProFlutter(this);

    // dashbroadController.getDashboard();
    Future.delayed(const Duration(seconds: 1), () {
      isBanner.value = true;
    });

    try {
      var tempList = prefs.getString(SharedConstants.BANNERS) ?? "";
      // debugPrint("ojbjoan" + tempList.toString());
      bannerList.clear();

      jsonDecode(tempList).forEach((element) {
        bannerList.add(BannerModel.fromJson(element));
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  getLeadDetails() async {
    try {
      loading.value = true;
      // await Future.delayed(Duration(seconds: 1), () {});
      var result = await ApiService().postMethod(body: {
        "pancard": prefs.getString(SharedConstants.PANCARD),
        "fcm": prefs.getString(SharedConstants.FCM_TOKEN) ?? ""
      }, header: APIConstants.getApiHeader(token), baseUrl: APIConstants.getBaseUrl(uri: "getLeadList"));
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
        loading.value = false;
      }
    } catch (e) {
      if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON ALL_LEAD==>$e");
      loading.value = false;
    }
    loading.value = false;
  }

  void toggleTheme(ThemeMode theme) {
    themeMode = theme;
  }

  getDashboard() async {
    if (loading.value == false) {
      loading.value = true;
      // await Future.delayed(Duration(seconds: 1), () {});

      try {
        var result = await ApiService().postMethod(
            baseUrl: APIConstants.getBaseUrl(uri: "getDashboardData"),
            body: {
              "profile_id": profile_id,
            },
            header: APIConstants.getApiHeader(token));
        if (result != null) {
          if (result['Status'] == 1) {
            prefs.setBool(SharedConstants.IS_BANNERS, result['Data']['is_banner'].toString() == "0" ? false : true);
            prefs.setBool(SharedConstants.IS_EDITABLE, result['Data']['is_editable'].toString() == "0" ? false : true);

            //Get the banner
            bannerList.clear();
            try {
              result['Data']['banners'].forEach((element) {
                bannerList.add(BannerModel.fromJson(element));
              });

              if (APIConstants.isModeDevelopment()) debugPrint("BANNERS==>$bannerList");

              prefs.setString(SharedConstants.BANNERS, jsonEncode(bannerList));
            } catch (e) {
              debugPrint(e.toString());
            }

            //Get the profile pic
            try {
              prefs.setString(SharedConstants.PROFILE_PIC, result['Data']['profile_pic'] ?? '');
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON Profile Pic$e");
            }

            // Get the Repayment History
            try {
              var list = result['Data']['collection_history'];
              debugPrint("REPAYMENT HISTORY ==>$list");

              prefs.setString(SharedConstants.REPAYMENT_HISTORY, jsonEncode(list));
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON Repayment History$e");
            }

            //Get the Basic Details
            try {
              prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_event_name'].toString());
              if (Events.getCurrentEvent() > 8) {
                prefs.setBool(SharedConstants.ELIGIBLE, true);
              }

              if ((result['Data']['registration_successful'].toString()) == "1" &&
                  (result['Data']['next_event_name'] ?? "") != Events.REGISTER_NOW) {
                prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['application_filled_percent'] ?? 0);
                prefs.setString(
                    SharedConstants.IS_REGESTRATED, (result['Data']['registration_successful'] ?? 0).toString());
              } else {
                prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['profile_filled_percent'] ?? 0);
              }
              prefs.setString(SharedConstants.IS_APPLIED, (result['Data']['application_submitted'] ?? 0).toString());

              prefs.setString(
                  SharedConstants.IS_REGESTRATED, (result['Data']['registration_successful'] ?? 0).toString());
              prefs.setString(SharedConstants.CIBIL_ID, result['Data']['bureau']['cibil_id'].toString());
            } catch (e) {
              debugPrint("ERROR ON BASIC DETAILS ==>$e");
            }

            //Get the profile details
            try {
              prefs.setString(SharedConstants.NAME, result['Data']['profile_details']['first_name'] ?? "");
              prefs.setString(SharedConstants.PANCARD, result['Data']['profile_details']['pancard'] ?? "");
              prefs.setString(SharedConstants.GENDER, result['Data']['profile_details']['gender'] ?? "");
              prefs.setString(SharedConstants.DOB, result['Data']['profile_details']['dob'] ?? "");
              prefs.setString(SharedConstants.EMAIL, result['Data']['profile_details']['personal_email'] ?? "");
              prefs.setString(
                  SharedConstants.MARITALSTATUS, result['Data']['profile_details']['marital_status_id'] ?? "");
              prefs.setString(
                  SharedConstants.FULL_NAME,
                  (result['Data']['profile_details']['first_name'] ?? "") +
                          " " +
                          (result['Data']['profile_details']['middle_name'] ?? "") +
                          " " +
                          (result['Data']['profile_details']['last_name'] ?? "") ??
                      "");

              prefs.setString(SharedConstants.USER_TYPE, result['Data']['profile_details']['user_type'] ?? "");
              prefs.setString(SharedConstants.SPOUSE_NAME, result['Data']['profile_details']['spouse_name'] ?? "");
              prefs.setString(SharedConstants.SPOUS_NUMBER, result['Data']['profile_details']['spouse_mobile'] ?? "");
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON PROFILE DETAILS ==>$e");
            }

            // Get the residence details
            try {
              prefs.setString(SharedConstants.PINCODE, result['Data']['profile_details']['residence_pincode'] ?? "");
              prefs.setString(SharedConstants.ADDRESS1, result['Data']['profile_details']['residence_address_1'] ?? "");
              prefs.setString(SharedConstants.ADDRESS2, result['Data']['profile_details']['residence_address_2'] ?? "");
              prefs.setString(SharedConstants.LANDMARK, result['Data']['profile_details']['residence_landmark'] ?? "");
              prefs.setString(
                  SharedConstants.RESIDENCETYPE, result['Data']['profile_details']['residence_type_id'] ?? "");
              prefs.setString(SharedConstants.CITY, result['Data']['profile_details']['residence_city'] ?? "");
              prefs.setString(SharedConstants.STATE, result['Data']['profile_details']['residence_state'] ?? "");
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON RESIDENCE DETAILS ==>$e");
            }

            // Get the bank details
            try {
              prefs.setString(
                  SharedConstants.NAMEONBANK, result['Data']['customer_banking_details']['beneficiary_name'] ?? "");
              prefs.setString(SharedConstants.BANKNUMBER, result['Data']['customer_banking_details']['account'] ?? "");
              prefs.setString(SharedConstants.IFSC, result['Data']['customer_banking_details']['ifsc_code'] ?? "");
              prefs.setString(SharedConstants.BRANCH_NAME, result['Data']['customer_banking_details']['branch'] ?? "");
            } catch (e) {
              debugPrint("ERROR ON BANKING DETAILS ==>$e");
            }

            // Get the cibil details
            try {
              prefs.setString(SharedConstants.CIBIL, result['Data']['bureau']['cibilScore'] ?? "");
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("CIBIL ERROR ==>$e");
            }

            // Get the income details
            try {
              prefs.setString(SharedConstants.SALARY, result['Data']['profile_details']['monthly_income'] ?? "");

              prefs.setString(
                  SharedConstants.EMP_TYPE_ID, result['Data']['profile_details']['income_type_id'].toString());
              prefs.setString(
                  SharedConstants.EMP_TYPE,
                  result['Data']['profile_details']['income_type_id'].toString() == "1"
                      ? "SALARIED"
                      : result['Data']['profile_details']['income_type_id'].toString() == "2"
                          ? "SELF EMPLOYED"
                          : "");

              prefs.setString(SharedConstants.SALARY_DATE, result['Data']['profile_details']['salary_date'] ?? "");

              prefs.setString(
                  SharedConstants.SALARY_MODE_ID, result['Data']['profile_details']['salary_mode'].toString());
              prefs.setString(
                  SharedConstants.SALARY_MODE,
                  result['Data']['profile_details']['salary_mode'].toString() == "1"
                      ? "BANK"
                      : result['Data']['profile_details']['salary_mode'].toString() == "2"
                          ? "CHEQUE"
                          : result['Data']['profile_details']['salary_mode'].toString() == "3"
                              ? "CASH"
                              : "");
              prefs.setString(SharedConstants.OFFICE_EMAIL, result['Data']['profile_details']['office_email'] ?? "");
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON INCOME DETAILS ==>$e");
            }

            // Get the employment details
            try {
              prefs.setString(
                  SharedConstants.ADDRESS_OFFICE1, result['Data']['customer_employment_details']['emp_house'] ?? "");
              prefs.setString(
                  SharedConstants.ADDRESS_OFFICE2, result['Data']['customer_employment_details']['emp_street'] ?? "");
              prefs.setString(
                  SharedConstants.LANDMARK_OFFICE, result['Data']['customer_employment_details']['emp_landmark'] ?? "");
              prefs.setString(
                  SharedConstants.DESIGNATION, result['Data']['customer_employment_details']['emp_designation'] ?? "");
              prefs.setString(
                  SharedConstants.EMP_PINCODE, result['Data']['customer_employment_details']['emp_pincode'] ?? "");
              prefs.setString(
                  SharedConstants.DEPT_NAME, result['Data']['customer_employment_details']['emp_department'] ?? "");
              prefs.setString(SharedConstants.SERVICE_TENURE,
                  result['Data']['customer_employment_details']['service_tenure'] ?? "");
              prefs.setString(
                  SharedConstants.WORK_MODE, result['Data']['customer_employment_details']['emp_work_mode'] ?? "");
              prefs.setString(SharedConstants.SERVICE_TENURE,
                  result['Data']['customer_employment_details']['presentServiceTenure'] ?? "");
              prefs.setString(
                  SharedConstants.SALARY, result['Data']['customer_employment_details']['monthly_income'] ?? "");
              // prefs.setString(
              //     SharedConstants.SALARY_MODE,
              //     result['Data']['customer_employment_details']
              //             ['salary_mode'] ??
              //         "");
              prefs.setString(SharedConstants.EMP_SINCE,
                  result['Data']['customer_employment_details']['emp_residence_since'] ?? "");
              prefs.setString(
                  SharedConstants.COMPANYNAME, result['Data']['customer_employment_details']['employer_name'] ?? "");
              prefs.setString(
                  SharedConstants.COMPANYTYPE, result['Data']['customer_employment_details']['company_id'] ?? "");
              prefs.setString(
                  SharedConstants.OFFICE_EMAIL, result['Data']['customer_employment_details']['emp_email'] ?? "");
              prefs.setString(
                  SharedConstants.OFFICE_LANDMARK, result['Data']['customer_employment_details']['emp_landmark'] ?? "");
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON EMPLOYMENT DETAILS ==>$e");
            }

            // Get Repayment details
            try {
              prefs.setString(SharedConstants.OUT_AMT, "0");
              prefs.setString(SharedConstants.OUT_AMT, result['Data']['active_loan_details']['total_due'].toString());
              prefs.setString(
                SharedConstants.REPAYMENT_DATE,
                result['Data']['active_loan_details']['repayment_date'],
              );
              prefs.setString(
                  SharedConstants.REPAYMENT_AMT, result['Data']['active_loan_details']['repayment_amount'].toString());
              prefs.setString(
                  SharedConstants.REMAINING_DAYS, result['Data']['active_loan_details']['remaining_days'].toString());
              prefs.setString(
                  SharedConstants.DIS_AMT, result['Data']['active_loan_details']['loan_recommended'].toString());
              prefs.setString(
                  SharedConstants.DIS_DATE, result['Data']['active_loan_details']['disbursal_date'].toString());
              prefs.setString(
                  SharedConstants.LOAN_STATUS, result['Data']['active_loan_details']['status_name'].toString());
              prefs.setString(SharedConstants.LOAN_NO, result['Data']['active_loan_details']['loan_no'].toString());
              prefs.setString(
                  SharedConstants.LOAN_LEAD_ID, result['Data']['active_loan_details']['lead_id'].toString());
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON REPAYMENT ==>$e");
            }
            // Get contact us details
            try {
              prefs.setString(SharedConstants.CONTACT_US_NUMBER, result['Data']['contact_us_number'] ?? "");
              prefs.setString(SharedConstants.CONTACT_US_EMAIL, result['Data']['contact_us_email'] ?? "");
              prefs.setString(
                  SharedConstants.CONTACT_US_WHATSAPP, result['Data']['contact_us_whatsapp'] ?? "+919376408000");
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON CONTACT US DETAILS ==>$e");
            }

            // Get loan details
            try {
              // prefs.setString(SharedConstants.LOAN_NO, result['Data']['lead_details']['loan_no'] ?? "");
              prefs.setString(SharedConstants.PURPOSE, result['Data']['lead_details']['purpose'] ?? "");

              prefs.setString(SharedConstants.LOAN_AMOUNT, result['Data']['lead_details']['loan_amount'] ?? "");

              prefs.setString(SharedConstants.TENURE, result['Data']['lead_details']['tenure'] ?? "");
            } catch (e) {
              if (APIConstants.isModeDevelopment()) debugPrint("ERROR ON LOAN DETAILS ==>$e");
            }
          } else if (result['Status'] == 3) {
            Get.offAllNamed(RoutesName.DashbroadScreen);
            ShortMessage.toast(title: result['Message'].toString());
          } else if (result['Status'] == 4) {
            Events.logout();
            ShortMessage.toast(title: result['Message'].toString());
          } else {
            ShortMessage.toast(title: result['Message'].toString());
          }

          loading.value = false;
        } else {
          loading.value = false;
        }
      } catch (e) {
        debugPrint("ERROR ON GET DASHBOARD==>$e");
        loading.value = false;
      }
    }
    loading.value = false;
  }

  // getLeadStatus(var lead_id) async {
  //   try {
  //     if (loadingOnContinue.value == false) {
  //       loadingOnContinue.value = true;
  //
  //       var result = await ApiService().postMethod(
  //           uri: APIConstants.GETLEAD_STATUS,
  //           body: {
  //             "lead_id": lead_id,
  //           },
  //           header: APIConstants.apiHeader,
  //           baseUrl: APIConstants.BaseURL);
  //
  //       if (result != null) {
  //         if (result['Status'].toString() == "1") {
  //           ShortMessage.toast(title: result['Message'].toString());
  //           try {
  //             if (result['data']['step_stage'].toString() == "G2") {
  //               Get.toNamed(RoutesName.OccupationScreen);
  //             } else if (result['data']['step_stage'].toString() == "G3") {
  //               Get.toNamed(RoutesName.PersonalDetailsScreen);
  //             } else if (result['data']['step_stage'].toString() == "G4") {
  //               Get.toNamed(RoutesName.DocScreen);
  //             } else if (result['data']['step_stage'].toString() == "G5") {
  //               Get.toNamed(RoutesName.ProgressScreen);
  //             } else {
  //               Get.toNamed(RoutesName.OccupationScreen);
  //             }
  //             prefs.setString(SharedConstants.LEAD_ID, lead_id.toString());
  //           } catch (e) {
  //             Get.toNamed(RoutesName.OccupationScreen);
  //             debugPrint(e.toString());
  //           }
  //           // ShortMessage.toast(title: result['Message'].toString());
  //         } else {
  //           ShortMessage.toast(title: result['Message'].toString());
  //         }
  //       } else {
  //         ShortMessage.toast(title: "Server Error");
  //       }
  //     } else {
  //       ShortMessage.toast(title: "Please wait...");
  //     }
  //   } catch (e) {
  //     debugdebugPrint(e.toString().toString());
  //   }
  //   loadingOnContinue.value = false;
  // }

  // getLeadStatus(var lead_id) async {
  //   if (loading.value == false) {
  //     loading.value = true;
  //     var step_stage = prefs.getInt(SharedConstants.STEP_STAGE) ?? 1;
  //
  //     if (step_stage == 1) {
  //       Get.toNamed(RoutesName.PanScreen);
  //     } else if (step_stage == 2) {
  //       Get.toNamed(RoutesName.ResidenceDetailsScreen);
  //     } else if (step_stage == 3) {
  //       Get.toNamed(RoutesName.PersonalDetailsScreen);
  //     } else if (step_stage == 4) {
  //       Get.toNamed(RoutesName.IncomeDetailsScreen);
  //     } else if (step_stage == 5) {
  //       Get.toNamed(RoutesName.DocScreen, arguments: [true]);
  //     } else if (step_stage == 6) {
  //       Get.toNamed(RoutesName.DocScreen, arguments: [false]);
  //     } else if (step_stage == 7) {
  //       Get.toNamed(RoutesName.EmploymentDetailsScreen);
  //     } else if (step_stage == 8) {
  //       Get.toNamed(RoutesName.LoanSelect, arguments: false);
  //     } else if (step_stage >= 9) {
  //       Get.toNamed(RoutesName.LoanSelect, arguments: false);
  //     } else {
  //       Get.toNamed(RoutesName.OccupationScreen);
  //     }
  //     loading.value = false;
  //   }
  // }
  void generateOrderId(var leadId, var amount) async {
    try {
      loadingOnRepay.value = true;
      var result = await ApiService().postMethod(
          baseUrl: APIConstants.getBaseUrl(uri: 'generateRazorpayorderId'),
          header: APIConstants.getApiHeader(prefs.getString(SharedConstants.TOKEN) ?? ''),
          body: {"lead_id": leadId, "rzp_amount": amount});

      if (result != null) {
        if (result['Status'].toString() == "1") {
          var orderId = result['Data']['order_id'].toString();
          initiateRayzorPay(amount, prefs.getString(SharedConstants.NAME), prefs.getString(SharedConstants.EMAIL),
              prefs.getString(SharedConstants.MOBILE), orderId, prefs.getString(SharedConstants.LOAN_NO), leadId);
        } else {
          ShortMessage.toast(title: result['Message'].toString());
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      loadingOnRepay.value = false;
    }

    loadingOnRepay.value = false;
  }

  // void initiatePayU() async {
  //   // Get.to(PayUPage());
  //   _checkoutPro.openCheckoutScreen(
  //     payUPaymentParams: PayUParams.createPayUPaymentParams(),
  //     payUCheckoutProConfig: PayUParams.createPayUConfigParams(),
  //   );
  // }

  void generateHashValue(var leadId, var amount) async {
    try {
      loadingOnRepay.value = true;
      var result = await ApiService().postMethod(
          baseUrl: APIConstants.getBaseUrl(uri: 'generateRazorpayorderId'),
          header: APIConstants.getApiHeader(prefs.getString(SharedConstants.TOKEN) ?? ''),
          body: {"lead_id": leadId, "rzp_amount": amount});

      if (result != null) {
        if (result['Status'].toString() == "1") {
          result['Data']['order_id'].toString();
          // initiatePayU();
        } else {
          ShortMessage.toast(title: result['Message'].toString());
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      loadingOnRepay.value = false;
    }

    loadingOnRepay.value = false;
  }

  void initiateRayzorPay(var amount, var name, var email, var mobile, orderId, var loanNo, var leadId) async {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': SharedConstants.razorpayKey,
      'amount': int.parse(amount) * 100,
      'name': name,
      'description': 'Repayment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'order_id': orderId,
      'receipt': loanNo + "-" + DateTime.now().toString(),
      'notes': {"orderid": loanNo, "lead_id": leadId},
      'prefill': {'contact': mobile, 'email': email},
      'partial_payment': true,
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Get.back();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    try {
    } catch (e) {
      debugPrint(e.toString());
    }

    Get.to(const PaymentFailedPage());
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    var request = {
      'razorpay_order_id': response.orderId.toString(),
      'razorpay_signature': response.signature.toString(),
      'razorpay_payment_id': response.paymentId.toString(),
    };

    try {
      var result = await ApiService().postMethod(
          baseUrl: APIConstants.getBaseUrl(uri: 'verifyRazorPayCheckPaymentStatus'),
          body: request,
          header: APIConstants.apiHeader1);

      if (result != null) {
        if (result['Status'].toString() == "1") {
          Get.to(const PaymentSuccessPage());
        } else {
          Get.offAllNamed(RoutesName.DashbroadScreen);
          ShortMessage.toast(title: result['Message'].toString());
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    Get.to(const PaymentSuccessPage());
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    // showAlertDialog(
    //     context, "External Wallet Selected", "${response.walletName}");
  }
//
//   @override
//   generateHash(Map response) {
//     // Backend will generate the hash which you need to pass to SDK
//     // hashResponse: is the response which you get from your server
//
//     Map hashResponse = {};
//
//     //Keep the salt and hash calculation logic in the backend for security reasons. Don't use local hash logic.
//     //Uncomment following line to test the test hash.
//     hashResponse = HashService.generateHash(response);
//
//     _checkoutPro.hashGenerated(hash: hashResponse);
//   }
//
//   @override
//   onPaymentSuccess(dynamic response) {
//     showAlertDialog(Get.context!, "onPaymentSuccess", response.toString());
//   }
//
//   @override
//   onPaymentFailure(dynamic response) {
//     showAlertDialog(Get.context!, "onPaymentFailure", response.toString());
//   }
//
//   @override
//   onPaymentCancel(Map? response) {
//     showAlertDialog(Get.context!, "onPaymentCancel", response.toString());
//   }
//
//   @override
//   onError(Map? response) {
//     showAlertDialog(Get.context!, "onError", response.toString());
//   }
}
