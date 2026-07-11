import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/models/requiredDocs.dart';
import 'package:tejas_loan/models/saveDocModel.dart';
import 'package:tejas_loan/routes/routes_names.dart';

import '../services/api_constant/api_constants.dart';
import '../services/api_service.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';
import 'internet_connectivity_controller.dart';

class DocController extends GetxController {
  ConnectionManagerController connectionManagerController = Get.find<ConnectionManagerController>();
  HLImagePicker picker = HLImagePicker();
  final _connectionManagerController = Get.put(ConnectionManagerController());
  var selectedImages = [].obs;
  var docs = [].obs;

  var isCroppingEnabled = false;
  var count = 1;
  var type = MediaType.all;
  var isExportThumbnail = true;
  var enablePreview = false;
  var usedCameraButton = true;
  var numberOfColumn = 3;
  var includePrevSelected = false;
  var aspectRatio;
  var aspectRatioPresets;
  double compressQuality = 0.9;
  CroppingStyle croppingStyle = CroppingStyle.normal;
  var images = [].obs;
  var file = File('').obs;
  var fileName = "".obs;
  var extension = "".obs;

  var size = 0.obs;
  var isLoading = false.obs;
  var profile_id = "".obs;
  var Doc = File("").obs;

  // var count = 0.obs;
  var saveDocList = <SaveDocModel>[].obs;
  var requiedDocList = <RequiedDocs>[].obs;
  var requiredIds = [].obs;
  var docmaster = [].obs;
  var isSelfie = Get.arguments ?? false;
  var token = prefs.getString(SharedConstants.TOKEN).toString();
  var appflyer_profile_id = prefs.getString(SharedConstants.APPFLYER_PROFILE_ID) ?? "";

  @override
  void onInit() {
    try {
      profile_id.value = prefs.getString(SharedConstants.PROFILE_ID).toString();
    } catch (e) {
      debugPrint(e.toString());
    }
    getDocs(isSelfie: isSelfie[0]);
    super.onInit();
  }

  Future<void> getDocs({var isSelfie = false}) async {
    requiedDocList.clear();

    /** Required Doc List From Server*/
    var response;
    // isSelfie = true;
    if (isSelfie) {
      /** Required Doc List From Local Json*/
      response = await rootBundle.loadString('lib/utils/selfie.json');
    } else {
      try {
        response = await ApiService().postMethod(
          body: {"profile_id": profile_id.value},
          header: APIConstants.getApiHeader(token),
          baseUrl: APIConstants.getBaseUrl(uri: "mandatoryDocuments"),
        );

        debugPrint("requiedDocList ==>" + response.toString());

        /** Required Doc List From Server*/

        if (response == null) {
          response = await rootBundle.loadString('lib/utils/requiredDocList.json');
          response = await jsonDecode(response) as List;
        } else {
          if (response['Status'] == 1) {
            response = response['Data'];
          } else {
            response = await rootBundle.loadString('lib/utils/requiredDocList.json');
            response = await jsonDecode(response) as List;
          }
        }
      } catch (e) {
        debugPrint("Error ==>" + e.toString());
      }
    }
    var data;
    if (isSelfie) {
      data = await json.decode(response);
    } else {
      data = response as List;
    }
    saveDocList.clear();

    for (int i = 0; i < data.length; i++) {
      requiedDocList.add(RequiedDocs.fromJson(data[i]));
      saveDocList.add(SaveDocModel());
    }

    debugPrint("requiedDocList ==>" + saveDocList.toString());
  }

  uploadDoc(List<SaveDocModel> saveDocList) async {
    // debugPrint(requiedDocList.length);
    // debugPrint(docs.length);
    if (docs.length >= requiedDocList.length) {
      isLoading.value = true;
      if (connectionManagerController.connectivityResult != ConnectivityResult.none) {
        for (int i = 0; i < saveDocList.length; i++) {
          debugPrint("saveDocList.length ==>" + saveDocList.length.toString());
          try {
            String base64encode = base64Encode(saveDocList[i].file.readAsBytesSync());
            var result = await ApiService().postMethod(
                body: {
                  "profile_id": profile_id.value,
                  "doc_type": saveDocList[i].doc_type ?? "",
                  "event_name": saveDocList[i].eventName,
                  "file_ext": saveDocList[i].ext == "HEIC" ? "jpg" : saveDocList[i].ext,
                  "file": base64encode
                },
                header: APIConstants.getApiHeader(token),
                baseUrl: isSelfie[0] ? APIConstants.getBaseUrl() : APIConstants.getBaseUrl(uri: "saveleadDetails"));
            if (result != null) {
              // appsflyerSdk!.setCustomerUserId(appflyer_profile_id.toString());
              //
              // appsflyerSdk!.logEvent("upload_document", {
              //   "profile_id": profile_id.value,
              //   "status": result['Status'],
              //   "message": result['Message'],
              //   "doc_type": saveDocList[i].doc_type ?? "",
              // }).then((result) {
              //   debugPrint('Event successfully logged: $result');
              // }).catchError((error) {
              //   debugPrint('Error logging event: $error');
              // });
              if (result["Status"].toString() == "1") {
                try {
                  if (i == requiedDocList.length - 1) {
                    // finalSubmit();
                    if (isSelfie[0]) {
                      //   Get.toNamed(RoutesName.DocScreen, arguments: [false]);
                      // } else {
                      prefs.setString(SharedConstants.PROFILE_PIC, result['Data']['selfie_doc_url'].toString());
                      prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
                      prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['step_percentage'] ?? 0);
                      Events.getNextEvent(result['Data']['next_step'].toString());
                    } else {
                      prefs.setString(SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
                      prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT, result['Data']['step_percentage'] ?? 0);
                      Events.getNextEvent(result['Data']['next_step'].toString());
                    }
                    ShortMessage.toast(title: result["Message"].toString());
                  } else {
                    ShortMessage.toast(title: result["Message"].toString());
                  }
                } catch (e) {
                  ShortMessage.toast(title: "Documents Uploaded Failed Try Again");

                  // debugPrint("error ==>" + e.toString());
                }
              } else if (result['Status'] == 3) {
                Get.offAllNamed(RoutesName.DashbroadScreen);
                ShortMessage.toast(title: result['Message'].toString());
              } else if (result['Status'] == 4) {
                Events.logout();
                ShortMessage.toast(title: result['Message'].toString());
              } else {
                isLoading.value = false;
                getDocs(isSelfie: isSelfie[0]);

                // response['required_ids'].forEach((element) {
                //   requiredIds.add(element);
                // });
                ShortMessage.toast(title: result["Message"].toString());
                break;
              }
            } else {
              isLoading.value = false;
              ShortMessage.toast(title: "Something went wrong Try Again");
            }
          } catch (e) {
            isLoading.value = false;
            ShortMessage.toast(title: "Some Error Occurred Try Again");
            debugPrint("error ==>" + e.toString());
            break;
          }
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        ShortMessage.toast(title: "No Internet Connection");
      }
    } else {
      // debugPrint('false');
      ShortMessage.toast(title: "Please Upload All Documents");
    }
  }

  void finalSubmit() async {
    var city = prefs.getString(SharedConstants.CITY);
    var latlong = prefs.getString(SharedConstants.LATLONG);
    var email = prefs.getString(SharedConstants.EMAIL);
    var fcm_token = prefs.getString(SharedConstants.FCM_TOKEN);
    var mobile = prefs.getString(SharedConstants.MOBILE);
    var salary = prefs.getString(SharedConstants.SALARY);
    var panCard = prefs.getString(SharedConstants.PANCARD);
    var aadhaar = prefs.getString(SharedConstants.AADHAAR);
    prefs.getString(SharedConstants.ADDRESS1);
    prefs.getString(SharedConstants.STATE);
    var name = prefs.getString(SharedConstants.NAME);
    var account = prefs.getString(SharedConstants.BANKNUMBER);
    var ifsc = prefs.getString(SharedConstants.IFSC);
    var pincode = prefs.getString(SharedConstants.PINCODE);
    var response = await ApiService().postMethod(
        uri: APIConstants.LOGIN,
        baseUrl: APIConstants.getBaseUrl(),
        body: {
          "coordinates": latlong ?? "",
          "mobile": mobile ?? "",
          "aadhaar": aadhaar ?? "",
          "account_number": account ?? "",
          "ifsc": ifsc ?? "",
          "name": name ?? "",
          "monthly_salary": salary ?? "",
        },
        header: APIConstants.apiHeader);

    if (response != null) {
      if (response['Status'].toString() == "1") {
        Get.offAllNamed(RoutesName.ThankyouScreen);
        prefs.setString(SharedConstants.CURRENTSCREEN, RoutesName.ThankyouScreen);
        ShortMessage.toast(title: "Submitted Successfully");
        isLoading.value = false;
      } else {
        ShortMessage.toast(title: response['Message'].toString());
        isLoading.value = false;
      }
    } else {
      ShortMessage.toast(title: "Something went wrong, please try again");
      isLoading.value = false;
    }
  }
}
