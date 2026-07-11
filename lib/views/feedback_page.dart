import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:lean_file_picker/lean_file_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/support_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';

import '../custom_widgets/CustomInputField.dart';
import '../custom_widgets/custom_dd_heading.dart';
import '../custom_widgets/custom_dropdown.dart';
import '../main.dart';
import '../utils/color_constants.dart';
import '../utils/image_constants.dart';
import '../utils/shared_constants.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({super.key});

  SupportController controller = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldLight,
      appBar: CustomAppbar(context: context, title: "Feedback Page"),
      body: Obx(() {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.sp),
            child: Column(
              children: [
                SizedBox(height: 15.sp),
                SizedBox(
                  height: Get.height * 0.2,
                  width: Get.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.sp),
                    child: Image.asset(
                      ImageConstants.Feedback,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 15.sp),
                CustomDDHeading(
                  textHeading: "Feedback Type",
                  height: Get.height * 0.1,
                  dropDown: CustomDropdown(
                      currentValue:controller.selectedFeedBackType.value.id,
                      list: controller.resTypeList.value,
                          onChanged: (value) {
                            print("selectedFeedBackType "+value.toString());
                            controller.selectedFeedBackType.value =
                                controller.resTypeList.firstWhere((item) => item.id == value); // Change here
                          }),

                ),
                if (["1", "2"].contains(controller.selectedFeedBackType.value.id)) ...[
                  SizedBox(
                    height: 10.sp,
                  ),
                  CustomInputField(
                    height: Get.height * 0.18,
                    heightOfTextField: Get.height * 0.2,
                    textHeading: controller.selectedFeedBackType.value.id.toString() == "1"
                        ? "Write a suggestion"
                        : "Write a complaint",
                    hint: 'Write',
                    isCaps: false,
                    letterSpacing: 1.0,
                    maxLenght: 200,
                    isOnChanged: true,
                    onChanged: (v) {
                      controller.suggestionController.value.value = TextEditingValue(
                          selection: controller.suggestionController.value.selection, text: v.capitalize.toString());
                    },
                    keyBroadType: TextInputType.streetAddress,
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ,()./-]*")),
                    ],
                    readOnly: false,
                    maxLines: 50,
                    isButton: false,
                    controller: controller.suggestionController.value,
                    buttonText: "Select",
                    onPressed: () {
                      // controller.selectDate(context);
                    },
                    // controller: controller.dobController.value,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12.sp),
                    child: Row(
                      children: [
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: "Upload Attachment: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: ColorConstants.ink),
                          ),
                        ])),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  InkWell(
                    onTap: () async {
                      if (GetPlatform.isIOS && controller.attachmentType.value == 0) {
                        try {
                          controller.images.value = await controller.picker.openPicker(
                            cropping: controller.isCroppingEnabled,
                            selectedIds: controller.includePrevSelected
                                ? controller.selectedImages.map((e) => e.id.toString()).toList()
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

                          if (controller.images.isNotEmpty) {
                            controller.file.value = File(controller.images[0].path);
                            controller.size.value = (controller.images[0].size / 1024).toInt();
                            controller.fileName.value = controller.images[0].name;
                            controller.Doc.value = File(controller.images[0].path);
                            controller.extension.value = controller.images[0].path.split(".").last;
                          } else {
                            return;
                          }
                        } catch (e) {

                          return;
                        }
                      } else {
                        try {
                          controller.file.value = (await pickFile(
                              allowedExtensions: GetPlatform.isAndroid
                                  ? controller.attachmentType.value == 0
                                      ? ['jpeg', 'jpg', 'png']
                                      : ['pdf']
                                  : ['pdf']))!;
                        } catch (e) {
                          return;
                        }

                        controller.size.value = (controller.file.value.lengthSync() / 1024).toInt();
                        controller.fileName.value = controller.file.value.path.split("/").last;
                        controller.Doc.value = File(controller.file.value.path);
                        controller.extension.value = controller.file.value.path.split(".").last;
                                            }
                    },
                    child: Column(children: [
                      Container(
                          height: Get.height * 0.23,
                          margin: EdgeInsets.symmetric(horizontal: 15.sp),
                          padding: EdgeInsets.all(20.sp),
                          decoration: BoxDecoration(
                            color: ColorConstants.surfaceLight,
                            borderRadius: BorderRadius.circular(14.sp),
                            border: Border.all(color: ColorConstants.border),
                            boxShadow: ColorConstants.softShadow,
                          ),
                          child: SizedBox(
                            width: Get.width * 0.9,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Attachment",
                                    style: TextStyle(fontWeight: FontWeight.w600, color: ColorConstants.ink, fontSize: 16.sp),
                                  ),
                                  SizedBox(height: 15.sp),
                                  SizedBox(
                                    child: controller.Doc.value.path != ""
                                        ? controller.extension.value.toLowerCase() != "pdf"
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(10.sp),
                                                child: SizedBox(
                                                    height: 43.sp,
                                                    width: 80.sp,
                                                    child: Image.file(
                                                      controller.Doc.value,
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
                                                        const Icon(
                                                          Icons.picture_as_pdf,
                                                          color: ColorConstants.danger,
                                                        ),
                                                        SizedBox(
                                                          height: 9.sp,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.all(12.sp),
                                                          child: Text(
                                                            textAlign: TextAlign.center,
                                                            controller.fileName.value,
                                                            style: const TextStyle(color: ColorConstants.body),
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
                                                    Icon(
                                                      Icons.cloud_upload,
                                                      color: ColorConstants.primary,
                                                    ),
                                                    SizedBox(
                                                      height: 9.sp,
                                                    ),
                                                     Text("Upload file (Max. 4MB)",style: TextStyle(color: ColorConstants.muted),),
                                                    SizedBox(
                                                      height: 15.sp,
                                                    ),
                                                    Text(
                                                      "Choose File",
                                                      style: TextStyle(
                                                          color: ColorConstants.primary, fontSize: 16.sp, fontWeight: FontWeight.w700),
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
                  ),
                  SizedBox(height: 20.sp),
                ],
                if (controller.selectedFeedBackType.value.id.toString() == "3") SizedBox(height: 30.sp),
                if (["1", "2", "3"].contains(controller.selectedFeedBackType.value.id.toString()))
                  CustomButton(
                    height: Get.height * 0.06,
                    onPressed: () {
                      if (controller.selectedFeedBackType.value.id.toString() == "3") {
                        controller.inAppReview.openStoreListing(appStoreId: SharedConstants.IOS_App_Id);
                      } else {
                        if (controller.isLoading.value == false) {
                          controller.submitFeedback();
                        } else {
                          ShortMessage.toast(title: "Please wait...");
                        }
                      }
                    },
                    text: controller.selectedFeedBackType.value.id.toString() == "3" ? "Go to Store" : "Submit",
                    isLoading: controller.isLoading.value,
                  ),
                SizedBox(height: 30.sp),
              ],
            ),
          ),
        );
      }),
    );
  }
}
