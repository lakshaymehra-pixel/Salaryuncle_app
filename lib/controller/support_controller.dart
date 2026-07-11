import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/services/api_constant/api_constants.dart';
import 'package:tejas_loan/services/api_service.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../models/resTypeModel.dart';
import 'internet_connectivity_controller.dart';

class SupportController extends GetxController {
  var selectedFeedBackType = Restypemodel(name: "Select", id: "0").obs;
  var resTypeList = <Restypemodel>[].obs;
  var suggestionController = TextEditingController().obs;
  var attachmentType = 0.obs;
  HLImagePicker picker = HLImagePicker();
  final _connectionManagerController = Get.put(ConnectionManagerController());
  var selectedImages = [].obs;
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
  InAppReview inAppReview = InAppReview.instance;
  CroppingStyle croppingStyle = CroppingStyle.normal;
  var images = [].obs;
  var file = File('').obs;
  var fileName = "".obs;
  var extension = "".obs;
  var size = 0.obs;
  var isLoading = false.obs;
  var Doc = File("").obs;

  @override
  void onInit() {
    resTypeList.value = [
      Restypemodel(name: "Select", id: "0"),
      Restypemodel(name: "Give Suggestion", id: "1"),
      Restypemodel(name: "Raise Complaint", id: "2"),
      Restypemodel(name: "Rating and Review", id: "3"),
    ];
    super.onInit();
  }

  void submitFeedback() async {
    String base64encode = "";
    if (file.value.path.isNotEmpty) {
      base64encode = base64Encode(file.value.readAsBytesSync());
    }
    // }

    if (selectedFeedBackType.value.id == "0") {
      ShortMessage.toast(title: "Please select feedback type");
      return;
    } else if (suggestionController.value.text.trim().length < 10) {
      ShortMessage.toast(title: "Please enter minimum 10 characters for feedback/suggestion");
      return;
    }
    isLoading.value = true;

    try {
      var result = await ApiService().postMethod(
          baseUrl: APIConstants.getBaseUrl(uri: 'feedback'),
          body: {
            "feedback_id": selectedFeedBackType.value.id,
            "profile_id": prefs.getString(SharedConstants.PROFILE_ID) ?? "",
            "remark": suggestionController.value.text,
            "attachment": base64encode,
            "ext": extension.value
          },
          header: APIConstants.apiHeader);

      if (result != null) {
        if (result["Status"] == 1) {
          // ShortMessage.toast(title: result["error"]);
          ShortMessage.toast(title: result["Data"]['message']);
          isLoading.value = false;
          suggestionController.value.text = "";
          file.value = File("");
          Doc.value = File("");
          extension.value = "";
          selectedFeedBackType.value = Restypemodel(name: "Select", id: "0");
        } else {
          ShortMessage.toast(title: result["Message"]);
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        ShortMessage.toast(title: "Something went wrong");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      isLoading.value = false;
    }
  }
}
