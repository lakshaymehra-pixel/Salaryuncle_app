import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../routes/routes_names.dart';

class Events {
  static const LOGIN = "login";
  static const OTP_VERIFY = "otp_verify";
  static const RESEND_OTP = "resend_otp";
  static const PANCARD = "pancard_verification";
  static const PERSONAL_DETAILS = "personal_details";
  static const RESIDENCE_DETAILS = "residence_details";
  static const INCOME_DETAILS = "income_details";
  static const SELFIE_UPLOAD = "selfie_upload";
  static const REGISTER_NOW = "register_now";
  static const GENERATE_LOAN_QUOTE = "generate_loan_quote";
  static const EMPLOYMENT_DETAILS = "employment_details";
  static const BANK_STATEMENT_UPLOAD = "bank_statement_upload";
  static const PAY_SLIP_UPLOAD = "pay_slip_upload";
  static const PANCARD_UPLOAD = "pan_upload";
  static const LOAN_QUOTATION_DECISION = "loan_quotation_decision";
  static const AADHAR_UPLOAD = "aadhaar_upload";
  static const RESIDENCE_PROOF = "residence_proof_upload";
  static const BANKING_DETAILS = "banking_details";
  static const COMPLETED = "completed";

  static void getNextEvent(String eventName) {
    switch (eventName) {
      case LOGIN:
        Get.offAllNamed(RoutesName.LoginScreen);
        break;

      case OTP_VERIFY:
        Get.offAllNamed(RoutesName.LoginScreen);
        break;

      case RESEND_OTP:
        Get.offAllNamed(RoutesName.LoginScreen);
        break;

      case PANCARD:
        Get.offAllNamed(RoutesName.PanScreen);
        break;

      case PERSONAL_DETAILS:
        Get.offAllNamed(RoutesName.PersonalDetailsScreen);
        break;

      case RESIDENCE_DETAILS:
        Get.offAllNamed(RoutesName.ResidenceDetailsScreen);
        break;

      case INCOME_DETAILS:
        Get.offAllNamed(RoutesName.IncomeDetailsScreen);
        break;

      case SELFIE_UPLOAD:
        Get.offAllNamed(RoutesName.DocScreen, arguments: [true]);
        break;

      case REGISTER_NOW:
        Get.offAllNamed(RoutesName.PreviewScreen);
        break;

      case GENERATE_LOAN_QUOTE:
        Get.offAllNamed(RoutesName.CongratesPage);
        break;
      case LOAN_QUOTATION_DECISION:
        Get.offAllNamed(RoutesName.LoanSelect, arguments: false);
        break;

      case EMPLOYMENT_DETAILS:
        Get.offAllNamed(RoutesName.EmploymentDetailsScreen);
        break;

      case BANK_STATEMENT_UPLOAD:
        Get.offAllNamed(RoutesName.DocScreen, arguments: [false]);
        break;

      case PAY_SLIP_UPLOAD:
        Get.offAllNamed(RoutesName.DocScreen, arguments: [false]);
        break;

      case PANCARD_UPLOAD:
        Get.offAllNamed(RoutesName.DocScreen, arguments: [false]);
        break;

      case AADHAR_UPLOAD:
        Get.offAllNamed(RoutesName.DocScreen, arguments: [false]);
        break;

      case RESIDENCE_PROOF:
        Get.offAllNamed(RoutesName.DocScreen, arguments: [false]);
        break;

      case BANKING_DETAILS:
        Get.offAllNamed(RoutesName.BankScreen);
        break;
      case COMPLETED:
        Get.offAllNamed(RoutesName.DashbroadScreen);
        break;

      default:
        logout();
        break;
    }
  }

  static int getCurrentEvent() {
    var eventName = prefs.getString(SharedConstants.STEP_STAGE).toString();

    // print("eventName: $eventName");

    switch (eventName) {
      case LOGIN:
        return 0;
      case OTP_VERIFY:
        return 1;
      case RESEND_OTP:
        return 2;
      case PANCARD:
        return 3;
      case PERSONAL_DETAILS:
        return 4;
      case RESIDENCE_DETAILS:
        return 5;
      case INCOME_DETAILS:
        return 6;
      case SELFIE_UPLOAD:
        return 7;
      case REGISTER_NOW:
        return 8;
      case GENERATE_LOAN_QUOTE:
        return 9;
      case LOAN_QUOTATION_DECISION:
        return 9;
      case EMPLOYMENT_DETAILS:
        return 10;
      case BANK_STATEMENT_UPLOAD:
        return 11;
      case AADHAR_UPLOAD:
        return 11;
      case RESIDENCE_PROOF:
        return 11;
      case PANCARD_UPLOAD:
        return 11;
      case PAY_SLIP_UPLOAD:
        return 11;
      case BANKING_DETAILS:
        return 12;
      case COMPLETED:
        return 13;
      default:
        return 0;
    }
  }

  static logout() {
    var temp= prefs.getBool(SharedConstants.THEME)??false;  // print("temp: $temp");
    prefs.clear();
    prefs.setBool(SharedConstants.ISLOGIN, false);
    prefs.setBool(SharedConstants.THEME, temp);
    if(temp){
      Get.changeThemeMode(ThemeMode.dark);
    }else{
      Get.changeThemeMode(ThemeMode.light);
    }
    Get.offAllNamed(RoutesName.LoginScreen);
  }
}
