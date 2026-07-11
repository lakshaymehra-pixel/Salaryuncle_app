import 'package:get/get_utils/src/platform/platform.dart';

class APIConstants {
  static String androidPrefix = '/andrd'; //development Base Url
  static String iosPrefix = '/ios';

  static bool isDev = false;

  //is Development going on
  static bool isModeDevelopment() {
    return isDev;
  }

  //End Points
  static const UATBaseUrlSURF = 'https://salarytopup.in/api/';
  static const PRODBaseUrlSURF = 'https://salarytopup.in/api/';
  static const LOGIN = '/saveCustomerProfile';
  static const RESEND = '/saveCustomerProfile';
  static const VERFIYOTP = '/saveCustomerProfile';
  static const CHECK_ELIGIBLITY = '/Api/UserNewApi/checkEligibility';
  static const GETALL_LEADS = '/Api/UserNewApi/getAllLeads';
  static const GETLEAD_STATUS = '/Api/UserApi/getLeadStatus';
  static const GETDASHBOARDDATA = '/Api/UserNewApi/getDashboard';
  static const GETLEAD_DETAILS = 'getLeadDetail';
  static const Fech_Okyc = 'fetchOkycData';
  static const UPLOAD_DOC = '/saveCustomerProfile';
  static const LOAN_DETAILS = '/saveCustomerProfile';
  static const REQUIRED_DOC = 'requiredUploadedDocsARD';
  static const OKYC_Aadhaar = 'getOkycOtp';
  static const GET_CIBIL = '/Api/UserNewApi/getCibil';
  static const MasterDataARD = '/getMasterDataARD';
  static const SUBMIT_PERSONAL_INFO = '/saveCustomerProfile';
  static const SUBMIT_INCOME_INFO = '/saveCustomerProfile';
  static const SUBMIT_RESIDENCE_INFO = '/saveCustomerProfile';
  static const SUBMIT_EMPLOYMENT_INFO = '/Api/UserNewApi/informAboutCompanyUpdate';
  static const OKYC_PAN = '/saveCustomerProfile';
  static const OKYC_BANK = 'Api/TaskApi/getCustomerBankVerify';

  //Set Base Url
  static String getBaseUrl({var uri = "saveCustomerProfile"}) {
    if (GetPlatform.isAndroid && isDev) {
      return '${UATBaseUrlSURF}${androidPrefix}/$uri'; //development for android
    } else if (GetPlatform.isAndroid && isDev == false) {
      return '${PRODBaseUrlSURF}${androidPrefix}/$uri'; //production for android
    } else if (GetPlatform.isIOS && isDev) {
      return '${UATBaseUrlSURF}${iosPrefix}/$uri'; //development for ios
    } else if (GetPlatform.isIOS && isDev == false) {
      return '${PRODBaseUrlSURF}${iosPrefix}/$uri'; //production for ios
    } else {
      return 'https://api.suryaloan.in/'; //production
    }
  }

  static Map<String, String> apiHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Auth': 'ZTI4MTU1MzE4NWQ2MGQyZTFhNWM0NGU3M2UzMmM3MDM=',
  };

  //Api Header to login
  static Map<String, String> apiHeader1 = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Auth': GetPlatform.isIOS
        ? 'ODdkZGE1ZDMyMWNmYTRhMTFjM2YxZmM4YzA5ZTM3ZDA='
        : 'MjQ4ZmY5MGM0MmM2N2EyOTJlZWE0MTBiNGU2Y2Q2NzU='
  };

  //Api Header after login
  static Map<String, String> getApiHeader(var token) {
    return {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authtoken': token};
  }
}
