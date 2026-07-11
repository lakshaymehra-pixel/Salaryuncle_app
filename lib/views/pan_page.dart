import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/panCardController.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/shared_constants.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/custom_widgets/su_step_progress.dart';
import 'package:tejas_loan/utils/events.dart';

import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/CustomInputField.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/su_form_card.dart';
import '../main.dart';
import '../services/api_constant/api_constants.dart';

class PanDetailsPage extends GetView<PanCardController> {
  const PanDetailsPage({super.key}) ;

  @override
  Widget build(BuildContext context) {
    StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
    return Obx(
      () => CustomBackground(
        isDrawer: false,
        isAppBarVisible: false,
        height: Get.height * 0.5,
        heightOfUpperBox: Get.height * 0.6,
        children: [
          SizedBox(
            height: Get.height * 0.05,
          ),
          CustomHeadingText(text2: "Please fill in your work information", text1: "Enter Your PAN & Income Details "),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            child: SuStepProgress(currentPhase: SuStepProgress.phaseFromEvent(Events.getCurrentEvent())),
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          SuFormCard(
            icon: Icons.badge_rounded,
            title: "PAN & Income",
            subtitle: "Enter your PAN and monthly income",
            children: [
          Container(
            padding: EdgeInsets.only(left: 2.sp),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Pan Details  ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Theme.of(context).textTheme.titleMedium!.color),
                  ),
                  TextSpan(
                    text: "*",
                    style: TextStyle(color: ColorConstants.danger, fontWeight: FontWeight.w900, fontSize: 16.sp),
                  )
                ])),
              ],
            ),
          ),
          SizedBox(
            height: 13.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.sp),
            child: PinCodeTextField(
              // backgroundColor: Colors.black,

              appContext: context,
              pastedTextStyle: TextStyle(
                color: ColorConstants.success,
                fontWeight: FontWeight.bold,
              ),
              length: 10,
              obscureText: false,
              obscuringCharacter: '*',
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              inputFormatters: [controller.allowedRegex.value],
              validator: (v) {
                if (v!.length < 10) {
                  return "Please enter valid PAN";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10.sp),
                fieldHeight: 25.sp,
                fieldWidth: 22.sp,
                errorBorderColor: ColorConstants.danger,
                selectedColor: ColorConstants.primary,
                inactiveColor: ColorConstants.border,
                activeColor: ColorConstants.primary,
                inactiveFillColor: ColorConstants.surfaceLight,
                borderWidth: 1.sp,
                selectedFillColor: ColorConstants.cardTintLight,
                activeFillColor: ColorConstants.cardTintLight,
                // inActiveBoxShadow: [
                //   BoxShadow(color: Colors.white),
                //   BoxShadow(color: Colors.white),
                //   BoxShadow(color: Colors.white),
                //   BoxShadow(color: Colors.white),
                // ],
                // activeBoxShadow: [
                //   BoxShadow(color: Colors.white),
                //   BoxShadow(color: Colors.white),
                //   BoxShadow(color: Colors.white),
                //   BoxShadow(color: Colors.white),
                // ],
              ),
              cursorColor: ColorConstants.primary,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              textStyle: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color),
              focusNode: controller.myFocusNode.value,
              errorAnimationController: errorController,
              controller: controller.panNoController.value,
              keyboardType: controller.keyboardType.value,

              onCompleted: (v) {
                if (APIConstants.isModeDevelopment()) log("Completed");
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                if (value.length == 5 && controller.keyboardType.value != TextInputType.number) {
                  controller.panNoController.value.value = TextEditingValue(
                      text: value.toUpperCase(), selection: controller.panNoController.value.selection);
                  controller.keyboardType.value = TextInputType.number;

                  controller.myFocusNode.value.unfocus();

                  Future.delayed(const Duration(milliseconds: 100)).then((value) {
                    controller.myFocusNode.value.requestFocus();
                  });
                } else if (value.length <= 4 && controller.keyboardType.value == TextInputType.number) {
                  controller.panNoController.value.value = TextEditingValue(
                      text: value.toUpperCase(), selection: controller.panNoController.value.selection);
                  controller.keyboardType.value = TextInputType.name;
                  controller.myFocusNode.value.unfocus();
                  Future.delayed(const Duration(milliseconds: 100)).then((value) {
                    controller.myFocusNode.value.requestFocus();
                  });
                } else if (value.length == 8 && controller.keyboardType.value != TextInputType.number) {
                  controller.keyboardType.value = TextInputType.number;
                  controller.myFocusNode.value.unfocus();
                  Future.delayed(const Duration(milliseconds: 100)).then((value) {
                    controller.myFocusNode.value.requestFocus();
                  });
                } else if (value.length == 9 && controller.keyboardType.value != TextInputType.name) {
                  controller.panNoController.value.value = TextEditingValue(
                      text: value.toUpperCase(), selection: controller.panNoController.value.selection);
                  controller.keyboardType.value = TextInputType.name;
                  controller.myFocusNode.value.unfocus();
                  Future.delayed(const Duration(milliseconds: 100)).then((value) {
                    controller.myFocusNode.value.requestFocus();
                  });
                } else {
                  controller.panNoController.value.value = TextEditingValue(
                      text: value.toUpperCase(), selection: controller.panNoController.value.selection);
                }
              },
              beforeTextPaste: (text) {
                if (APIConstants.isModeDevelopment()) log("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          CustomInputField(
            height: Get.height * 0.13,
            textHeading: "Enter your Net Monthly Income",
            hint: 'Enter your Income.',
            isCaps: false,
            readOnly: false,
            letterSpacing: 1.0,
            maxLenght: 7,
            keyBroadType: TextInputType.number,
            formatter: [
              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
              FilteringTextInputFormatter.deny(RegExp("[., /-]*")),
            ],
            controller: controller.salaryController.value,
            isButton: false,
            // controller: controller.nameController.value,
          ),
            ],
          ),
          SizedBox(height: 18.sp),
          CustomButton(
            onPressed: () {
              var mobile = prefs.getString(SharedConstants.MOBILE);
              if (mobile.toString() != "9999999999") {
                if (controller.isLoadingOnFind.value == false) {
                  controller.findPAN();
                } else {
                  ShortMessage.toast(title: "Please wait...");
                }
              } else {
                Get.toNamed(RoutesName.PersonalDetailsScreen);
              }
            },
            height: Get.height * .06,
            text: 'NEXT',
            isLoading: controller.isLoadingOnFind.value,
          ),
        ],
      ),
    );
  }

  isNumeric(String value) {
    var list = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    if (list.contains(value.split("").last)) {
      return true;
    } else {
      return false;
    }
  }
}
