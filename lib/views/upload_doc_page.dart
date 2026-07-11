import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:lean_file_picker/lean_file_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/docController.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/su_step_progress.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/events.dart';

import '../controller/internet_connectivity_controller.dart';
import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';
import '../models/saveDocModel.dart';
import '../utils/image_constants.dart';
import '../utils/shared_constants.dart';

class DocPage extends GetView<DocController> {
  ConnectionManagerController connectionManagerController = Get.put(ConnectionManagerController());

  DocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomBackground(
          heightOfUpperBox: controller.isSelfie[0] ?? false == true ? Get.height * 0.7 : Get.height * 0.8,
          height: controller.isSelfie[0] ?? false ? Get.height * 0.7 : Get.height * 1.3,
          enableBottomNav: true,
          children: [
            SizedBox(height: Get.height * 0.03),
            CustomHeadingText(
                text2:
                    !(controller.isSelfie[0] ?? false) ? 'Please upload your Documents' : 'Please upload your Selfie',
                text1: !(controller.isSelfie[0] ?? false) ? 'Upload Your Documents' : 'Upload Your Selfie'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: SuStepProgress(currentPhase: SuStepProgress.phaseFromEvent(Events.getCurrentEvent())),
            ),
            SizedBox(height: 10.sp),
            Column(
              children: [
                controller.requiedDocList!.length > 0
                    ? ListView.builder(
                        itemCount: controller.requiedDocList.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var name = "";

                          var DocFieldController = TextEditingController(text: name);

                          // if (controller.requiedDocList.length != index) {
                          return InkWell(
                            onTap: () async {
                              if (controller.isLoading.value) {
                                ShortMessage.toast(title: "Please wait while uploading");
                              } else {
                                if (GetPlatform.isIOS &&
                                    controller.requiedDocList![index].allowedFormat.toString() != "document") {
                                  try {
                                    controller.images.value = await controller.picker.openPicker(
                                      cropping: controller.isCroppingEnabled,
                                      selectedIds: controller.includePrevSelected
                                          ? controller.selectedImages.value.map((e) => e.id.toString()).toList()
                                          : null,
                                      pickerOptions: HLPickerOptions(
                                        mediaType: controller.type,
                                        enablePreview: controller.enablePreview,
                                        isExportThumbnail: controller.isExportThumbnail,
                                        thumbnailCompressFormat: CompressFormat.jpg,
                                        thumbnailCompressQuality: 0.9,
                                        maxSelectedAssets: controller.count,
                                        usedCameraButton: controller.usedCameraButton,
                                        numberOfColumn: 3,
                                        isGif: false,
                                      ),
                                    );

                                    if (controller.images.value.isNotEmpty) {
                                      controller.file.value = File(controller.images.value[0].path);
                                      controller.size.value = (controller.images.value[0].size / 1024).toInt();
                                      controller.fileName.value = controller.images.value[0].name;
                                      controller.Doc.value = File(controller.images.value[0].path);
                                      controller.extension.value = controller.images[0].path.split(".").last;
                                    } else {
                                      print("No file selected");
                                      return null;
                                    }
                                  } catch (e) {
                                    print(e.toString());

                                    return null;
                                  }
                                } else {
                                  try {
                                    controller.file.value = (await pickFile(
                                        allowedExtensions: GetPlatform.isAndroid
                                            ? controller.requiedDocList![index].allowedFormat.toString() != "document"
                                                ? ['jpeg', 'jpg', 'png']
                                                : ['pdf']
                                            : ['pdf']))!;
                                  } catch (e) {
                                    return null;
                                  }

                                  if (controller.file.value != null) {
                                    controller.size.value = (controller.file.value!.lengthSync() / 1024).toInt();
                                    controller.fileName.value = controller.file.value!.path.split("/").last;
                                    controller.Doc.value = File(controller.file.value!.path);
                                    controller.extension.value = controller.file.value!.path.split(".").last;
                                  } else {
                                    print("No file selected");
                                    return null;
                                  }
                                }

                                if (controller.size < 5100 || controller.isSelfie[0]) {
                                  DocFieldController.text = controller.fileName.value;
                                  if (!controller.docs.contains(controller.requiedDocList![index].docType.toString())) {
                                    controller.docs.add(controller.requiedDocList![index].docType.toString());
                                  }
                                  SaveDocModel saveDocModel = SaveDocModel(
                                      eventName: controller.requiedDocList![index].eventName.toString(),
                                      ext: controller.extension.value,
                                      file: controller.Doc.value,
                                      fileName: controller.fileName.value,
                                      doc_type: controller.requiedDocList![index].docType ?? "",
                                      index: index);

                                  // for (int i = 0;
                                  //     i < controller.saveDocList.length;
                                  //     i++) {
                                  //   if (controller.saveDocList[i].doc_type ==
                                  //       saveDocModel.doc_type) {
                                  //     controller.saveDocList.removeAt(i);
                                  //     break;
                                  //   }
                                  // }
                                  controller.saveDocList[index] = saveDocModel;
                                  controller.requiedDocList.refresh();

                                  print("saveDocList :==>${controller.saveDocList.toString()}");
                                } else {
                                  ShortMessage.toast(title: "File size should be less than 4MB");
                                }
                              }
                            },
                            child: Column(children: [
                              Container(
                                  height: Get.height * 0.23,
                                  margin: EdgeInsets.symmetric(vertical: 9.sp, horizontal: 2.sp),
                                  padding: EdgeInsets.all(20.sp),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.surfaceLight,
                                    borderRadius: BorderRadius.circular(18.sp),
                                    border: Border.all(color: ColorConstants.border),
                                    boxShadow: ColorConstants.softShadow,
                                  ),
                                  child: SizedBox(
                                    width: Get.width * 0.9,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 30.sp,
                                                width: 30.sp,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: ColorConstants.cardTintLight,
                                                  borderRadius: BorderRadius.circular(9.sp),
                                                ),
                                                child: Icon(Icons.description_rounded,
                                                    color: ColorConstants.primary, size: 16.sp),
                                              ),
                                              SizedBox(width: 10.sp),
                                              Expanded(
                                                child: Text(
                                                  controller.requiedDocList![index].name,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstants.ink,
                                                      fontSize: 16.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12.sp),
                                          SizedBox(
                                            child: controller.saveDocList[index].file != null
                                                ? controller.saveDocList[index].ext!.toLowerCase() != "pdf"
                                                    ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(10.sp),
                                                        child: SizedBox(
                                                            height: 43.sp,
                                                            width: 80.sp,
                                                            child: Image.file(
                                                              controller.saveDocList[index].file,
                                                              fit: BoxFit.fill,
                                                            )))
                                                    : Stack(
                                                        children: [
                                                          Positioned(child: Image.asset(ImageConstants.DotBorder)),
                                                          Positioned(
                                                              child: Center(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                SizedBox(
                                                                  height: 15.sp,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.all(10.sp),
                                                                  decoration: BoxDecoration(
                                                                    color: ColorConstants.danger.withOpacity(0.12),
                                                                    shape: BoxShape.circle,
                                                                  ),
                                                                  child: Icon(
                                                                    Icons.picture_as_pdf,
                                                                    color: ColorConstants.danger,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 9.sp,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.all(12.sp),
                                                                  child: Text(
                                                                    textAlign: TextAlign.center,
                                                                    controller.saveDocList[index].fileName,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        color: ColorConstants.body),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 15.sp,
                                                                ),
                                                                // Text(
                                                                //   "Choose File",
                                                                //   style: TextStyle(
                                                                //       color: Color(
                                                                //           ColorConstants
                                                                //               .primaryColor),
                                                                //       fontSize:
                                                                //       16.sp),
                                                                // ),
                                                              ],
                                                            ),
                                                          ))
                                                        ],
                                                      )
                                                : Stack(
                                                    children: [
                                                      Positioned(child: Image.asset(ImageConstants.DotBorder)),
                                                      Positioned(
                                                          child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              height: 15.sp,
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.all(12.sp),
                                                              decoration: BoxDecoration(
                                                                color: ColorConstants.cardTintLight,
                                                                shape: BoxShape.circle,
                                                              ),
                                                              child: Icon(
                                                                Icons.cloud_upload,
                                                                color: ColorConstants.primary,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 9.sp,
                                                            ),
                                                            Text("Upload file (Max. 4MB)",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    color: ColorConstants.muted)),
                                                            SizedBox(
                                                              height: 15.sp,
                                                            ),
                                                            Text(
                                                              "Choose File",
                                                              style: TextStyle(
                                                                  color: ColorConstants.primary,
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: 16.sp),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                          )
                                        ]),
                                  )),
                            ]),
                          );
                          // }
                        })
                    : SizedBox(
                        height: 90.sp,
                        width: 30.sp,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(ColorConstants.primaryColor),
                            strokeWidth: 5,
                          ),
                        ),
                      ),
                CustomButton(
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    var mobile = prefs.getString(SharedConstants.MOBILE);
                    if (mobile.toString() != "9999999999") {
                      if (controller.isLoading.value == false) {
                        controller.uploadDoc(controller.saveDocList);
                      } else {
                        ShortMessage.toast(title: "Please wait...");
                      }
                    } else {
                      Get.toNamed(RoutesName.ThankyouScreen);
                    }
                  },
                  height: Get.height * 0.06,
                  text: "SUBMIT",
                )
              ],
            )
          ]);
    });
  }
}
