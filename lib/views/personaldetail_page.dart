import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/personalDetailsController.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/su_step_progress.dart';
import 'package:tejas_loan/utils/events.dart';

import '../controller/internet_connectivity_controller.dart';
import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/CustomInputField.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/su_form_card.dart';
import '../custom_widgets/custom_radio_button.dart';
import '../custom_widgets/custom_rb_heading.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../utils/shared_constants.dart';

class PersonalDetailsPage extends GetView<PersonalDetailController> {
  var mobile = prefs.getString(SharedConstants.MOBILE);

  PersonalDetailsPage({super.key}) ;
  ConnectionManagerController connectionManagerController = Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomBackground(
        isAppBarVisible: true,
        heightOfUpperBox: Get.height * 0.7,
        height: controller.currentMaritalSelected.value == "2"
            ? Get.height * 1.33
            : controller.currentMaritalSelected.value == "3"
                ? Get.height * 1.33
                : Get.height * 1,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          CustomHeadingText(text2: "Please fill in your work information", text1: "Enter Your Personal Details "),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            child: SuStepProgress(currentPhase: SuStepProgress.phaseFromEvent(Events.getCurrentEvent())),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          SuFormCard(
            icon: Icons.person_rounded,
            title: "Personal Information",
            subtitle: "Tell us a little about yourself",
            children: [
          CustomInputField(
            height: Get.height * 0.1,
            textHeading: "Enter your Name",
            hint: 'Enter your name.',
            isCaps: false,
            readOnly: prefs.getString(SharedConstants.MOBILE) == "9999999999" ? false : true,
            letterSpacing: 1.0,
            maxLenght: 50,
            keyBroadType: TextInputType.name,
            formatter: const [],
            controller: controller.nameController.value,
            isButton: false,
            // controller: controller.nameController.value,
          ),
          CustomInputField(
            height: Get.height * 0.09,
            textHeading: "Enter your Personal Email",
            hint: 'Enter your email.',
            isCaps: true,
            letterSpacing: 1.0,
            maxLenght: 50,
            keyBroadType: TextInputType.emailAddress,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp('[0-9,a-z,A-Z @._]')),
            ],
            controller: controller.emailController.value,
            isButton: false,
            // controller: controller.nameController.value,
          ),
          CustomRBHeading(
              textHeading: "Select Gender",
              height: Get.height * 0.128,
              RadioButtons: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomRadioButton(
                      currentSelected: controller.currentGenderSelected.value,
                      text: "Male",
                      value: "1",
                      onChanged: (value) {
                        controller.currentGenderSelected.value = value.toString();
                        if (kDebugMode) {
                          print("currentGenderSelected "+value.toString());
                        }
                      },

                    ),
                    CustomRadioButton(
                      currentSelected: controller.currentGenderSelected.value,
                      text: "Female",
                      value: "2",
                      onChanged: (value) {
                        controller.currentGenderSelected.value = value.toString();
                        if (kDebugMode) {
                          print("currentGenderSelected "+value.toString());
                        }
                      },

                    ),
                  ],
                ),
              ])),

          SizedBox(
            height: 16.sp,
          ),
          CustomInputField(
            height: Get.height * 0.09,
            textHeading: "Enter your date of birth",
            hint: 'Enter your DOB.',
            isCaps: false,
            letterSpacing: 1.0,
            maxLenght: 20,
            keyBroadType: TextInputType.name,
            formatter: const [],
            readOnly: true,
            isButton: true,
            buttonText: "Select",
            onPressed: () {
              controller.selectDate(context: context);
            },
            controller: controller.dobController.value,
          ),
          CustomRBHeading(
              textHeading: "Marital Status",
              height: Get.height * 0.2,
              RadioButtons: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomRadioButton(
                        currentSelected: controller.currentMaritalSelected.value,
                        text: "Single",
                        value: "1",
                        onChanged: (value) {
                          controller.currentMaritalSelected.value = value.toString();
                          if (kDebugMode) {
                            print("currentMaritalSelected "+value.toString());
                          }
                        },

                      ),
                      CustomRadioButton(
                        currentSelected: controller.currentMaritalSelected.value,
                        text: "Married",
                        value: "2",
                        onChanged: (value) {
                          controller.currentMaritalSelected.value = value.toString();
                          if (kDebugMode) {
                            print("currentMaritalSelected "+value.toString());
                          }
                        },
                      ),

                    ],
                  ),
                  CustomRadioButton(
                    currentSelected: controller.currentMaritalSelected.value,
                    text: "Divorced",
                    value: "3",
                    isLongButton: true,
                    onChanged: (value) {
                      controller.currentMaritalSelected.value = value.toString();
                      if (kDebugMode) {
                        print("currentMaritalSelected "+value.toString());
                      }
                    },
                  ),
                ],
              )),
          // CustomInputField(
          //   height: Get.height * 0.13,
          //   textHeading: "Enter Your Aadhaar Last 4 Digits",
          //   hint: 'Enter number.',
          //   isCaps: false,
          //   readOnly: false,
          //   letterSpacing: 1.0,
          //   maxLenght: 4,
          //   keyBroadType: TextInputType.number,
          //   formatter: [],
          //   controller: controller.aadhaarNumberController.value,
          //   isButton: false,
          //   // controller: controller.nameController.value,
          // ),
          SizedBox(
            height: 10.sp,
          ),
          if (controller.currentMaritalSelected.value == "2")
            CustomInputField(
              height: Get.height * 0.09,
              textHeading: "Enter your Spouse Name",
              hint: 'Enter your spouse name.',
              isCaps: false,
              letterSpacing: 1.0,
              maxLenght: 50,
              keyBroadType: TextInputType.name,
              formatter: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
              ],
              controller: controller.spouseNameController.value,
              isButton: false,
              // controller: controller.nameController.value,
            ),
          if (controller.currentMaritalSelected.value == "2")
            CustomInputField(
              height: Get.height * 0.09,
              textHeading: "Enter his/her phone number",
              hint: 'Enter his/her number.',
              isCaps: false,
              letterSpacing: 1.0,
              maxLenght: 10,
              keyBroadType: TextInputType.number,
              formatter: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              controller: controller.spouseNumberController.value,
              isButton: false,
              // controller: controller.nameController.value,
            ),
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
          CustomButton(
            isLoading : controller.isLoadingOnSubmit.value,
            onPressed: () {
              var mobile = prefs.getString(SharedConstants.MOBILE);
              if (mobile.toString() != "9999999999") {
                if (controller.isLoadingOnSubmit.value == false) {
                  controller.savePersonalDetails();
                } else {
                  ShortMessage.toast(title: "Please wait...");
                }
              } else {
                Get.toNamed(RoutesName.AadhaarScreen);
              }
            },
            height: Get.height * .06,
            text: "NEXT",
          ),

          SizedBox(
            height: 10.sp,
          ),
        ],
      ),
    );
  }
}
