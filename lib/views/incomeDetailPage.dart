import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/personalDetailsController.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/utils/color_constants.dart';
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

class IncomeDetailsPage extends GetView<PersonalDetailController> {
  var mobile = prefs.getString(SharedConstants.MOBILE);

  IncomeDetailsPage({Key? key}) : super(key: key);
  ConnectionManagerController connectionManagerController =
      Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomBackground(
        heightOfUpperBox: Get.height * 0.8,
        height: Get.height * 0.9,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          CustomHeadingText(
              text2: "Please fill in your work information",
              text1: "Enter Your Income Details "),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            child: SuStepProgress(currentPhase: SuStepProgress.phaseFromEvent(Events.getCurrentEvent())),
          ),
          SizedBox(
            height: Get.height * 0.015,
          ),
          // CustomInputField(
          //   height: Get.height * 0.13,
          //   textHeading: "Enter your Employer Name",
          //   hint: 'Enter Employer Name.',
          //   isCaps: false,
          //   readOnly: false,
          //   isMandatory: true,
          //   letterSpacing: 1.0,
          //   maxLenght: 25,
          //   keyBroadType: TextInputType.text,
          //   formatter: [],
          //   controller: controller.companyNameController.value,
          //   isButton: false,
          //   // controller: controller.nameController.value,
          // ),
          SuFormCard(
            icon: Icons.payments_rounded,
            title: "Income Details",
            subtitle: "Your salary and payment information",
            children: [
          CustomRBHeading(
              textHeading: "Employment Type",
              height: Get.height * 0.13,
              RadioButtons: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomRadioButton(
                          currentSelected:
                              controller.currentEmploymentTypeSelected.value,
                          text: "Salaried",
                          value: "1",
                          onChanged: (value) {
                            controller.currentEmploymentTypeSelected.value =
                                value.toString();
                            if (kDebugMode) {
                              print("currentEmploymentTypeSelected " +
                                  value.toString());
                            }
                          },
                        ),
                        CustomRadioButton(
                          currentSelected:
                              controller.currentEmploymentTypeSelected.value,
                          text: "Self Employed",
                          value: "2",
                          onChanged: (value) {
                            controller.currentEmploymentTypeSelected.value =
                                value.toString();
                            if (kDebugMode) {
                              print("currentEmploymentTypeSelected " +
                                  value.toString());
                            }
                          },
                        ),
                      ],
                    ),
                  ])),

          CustomInputField(
            height: Get.height * 0.08,
            textHeading: "Enter your Monthly Gross Salary",
            hint: 'Enter your Income.',
            isCaps: false,
            readOnly: false,
            letterSpacing: 1.0,
            maxLenght: 7,
            keyBroadType: TextInputType.number,
            formatter: [
              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
            ],
            controller: controller.salaryController.value,
            isButton: false,
            // controller: controller.nameController.value,
          ),
          CustomRBHeading(
              textHeading: "Mode of Payment",
              height: Get.height * 0.2,
              RadioButtons: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomRadioButton(
                          currentSelected: controller.currentModeSelected.value,
                          text: "Bank",
                          value: "1",
                          onChanged: (value) {
                            controller.currentModeSelected.value =
                                value.toString();
                            if (kDebugMode) {
                              print("currentModeSelected " + value.toString());
                            }
                          },
                        ),
                        CustomRadioButton(
                          currentSelected: controller.currentModeSelected.value,
                          text: "Cheque",
                          value: "2",
                          onChanged: (value) {
                            controller.currentModeSelected.value =
                                value.toString();
                            if (kDebugMode) {
                              print("currentModeSelected " + value.toString());
                            }
                          },
                        ),
                      ],
                    ),
                    CustomRadioButton(
                        currentSelected: controller.currentModeSelected.value,
                        isLongButton: true,
                        value: "3",
                        text: "Cash",
                        onChanged: (value) {
                          controller.currentModeSelected.value =
                              value.toString();
                          if (kDebugMode) {
                            print("currentModeSelected " + value.toString());
                          }
                          //someLogic;
                        })
                  ])),

          // CustomInputField(
          //   textHeading: "Enter your Obligations",
          //   hint: 'Enter Obligations.',
          //   isCaps: false,
          //   readOnly: false,
          //   letterSpacing: 1.0,
          //   maxLenght: 5,
          //   keyBroadType: TextInputType.number,
          //   formatter: [],
          //   controller: controller.obligationsController.value,
          //   isButton: false,
          //   height: Get.height * 0.13,
          //   // controller: controller.nameController.value,
          // ),

          // CustomInputField(
          //   height: Get.height * 0.13,
          //   textHeading: "Enter your Last Received Salary",
          //   hint: 'Enter your last salary.',
          //   isCaps: false,
          //   readOnly: false,
          //   letterSpacing: 1.0,
          //   maxLenght: 7,
          //   keyBroadType: TextInputType.number,
          //   formatter: [],
          //   controller: controller.lastSalaryController.value,
          //   isButton: false,
          //   // controller: controller.nameController.value,
          // ),
          CustomInputField(
            height: Get.height * 0.1,
            textHeading: "Enter Your Last Salary Date",
            hint: 'Enter Date.',
            isCaps: false,
            letterSpacing: 1.0,
            maxLenght: 20,
            keyBroadType: TextInputType.name,
            formatter: [
              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
              FilteringTextInputFormatter.deny(RegExp("[., /-]*")),
            ],
            readOnly: true,
            isButton: true,
            buttonText: "Select",
            onPressed: () {
              controller.selectDate(context: context, isNextPayDate: true);
            },
            controller: controller.lastPayDateController.value,
          ),
            ],
          ),
          SizedBox(height: 18.sp),
          // CustomInputField(
          //   height: Get.height * 0.13,
          //   textHeading: "Enter your Loan Amount",
          //   hint: 'Enter your Loan Amount.',
          //   isCaps: false,
          //   readOnly: false,
          //   letterSpacing: 1.0,
          //   maxLenght: 7,
          //   keyBroadType: TextInputType.number,
          //   formatter: [],
          //   controller: controller.loanController.value,
          //   isButton: false,
          //   // controller: controller.nameController.value,
          // ),

          CustomButton(
            isLoading: controller.isLoadingOnSubmit.value,
            onPressed: () {
              var mobile = prefs.getString(SharedConstants.MOBILE);
              if (mobile.toString() != "9999999999") {
                if (controller.isLoadingOnSubmit.value == false) {
                  controller.saveIncomeDetails();
                } else {
                  ShortMessage.toast(title: "Please wait...");
                }
              } else {
                Get.toNamed(RoutesName.AadhaarScreen);
              }
            },
            height: Get.height * 0.06,
            text: 'NEXT',
            // child: Container(
            //   width: Get.width * 0.7,
            //   height: Get.height * 0.05,
            //   child: Center(
            //       child: controller.isLoadingOnFind.value
            //           ? Container(
            //               padding: EdgeInsets.all(2),
            //               child: CircularProgressIndicator(
            //                 color: Colors.white,
            //                 strokeWidth: 5,
            //               ),
            //             )
            //           : Text(
            //               "NEXT",
            //               style: TextStyle(fontWeight: FontWeight.w300),
            //             )),
            // ),
            // style: ElevatedButton.styleFrom(
            //     backgroundColor: Color(ColorConstants.primaryColor)),
          ),
          // Container(
          //   width: Get.width * 0.7,
          //   height: Get.height * 0.05,
          //   child: TextButton(
          //       onPressed: () {
          //         prefs.setString(SharedConstants.CURRENTSCREEN,
          //             RoutesName.DashbroadScreen);
          //         Get.toNamed(RoutesName.DashbroadScreen);
          //       },
          //       child: Text(
          //         "GO TO DASHBROAD",
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           color: Color(ColorConstants.primaryColor),
          //         ),
          //       )),
          // ),
          Container(),
        ],
      ),
    );
  }
}
