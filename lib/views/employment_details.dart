import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/personalDetailsController.dart';
import 'package:tejas_loan/custom_widgets/custom_dd_heading.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/custom_dropdown.dart';
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

class EmploymentDetailsPage extends GetView<PersonalDetailController> {
  var mobile = prefs.getString(SharedConstants.MOBILE);

  EmploymentDetailsPage({super.key});

  ConnectionManagerController connectionManagerController =
      Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomBackground(
        heightOfUpperBox: Get.height * 0.8,
        height: Get.height * 1.7,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          CustomHeadingText(
              text2: "Please fill in your work information",
              text1: "Enter Your Employment Details "),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            child: SuStepProgress(currentPhase: SuStepProgress.phaseFromEvent(Events.getCurrentEvent())),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          SuFormCard(
            icon: Icons.work_rounded,
            title: "Employment Details",
            subtitle: "Where you work and your role",
            children: [
          CustomRBHeading(
              textHeading: "Select Mode Of Work",
              height: Get.height * 0.128,
              RadioButtons: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomRadioButton(
                          currentSelected:
                              controller.currentWorkModeSelected.value,
                          text: "OnSite",
                          value: "1",
                          onChanged: (value) {
                            controller.currentWorkModeSelected.value =
                                value.toString();
                            if (kDebugMode) {
                              print("currentWorkModeSelected " +
                                  value.toString());
                            }
                          },
                        ),
                        CustomRadioButton(
                          currentSelected:
                              controller.currentWorkModeSelected.value,
                          text: "Remote",
                          value: "2",
                          onChanged: (value) {
                            controller.currentWorkModeSelected.value =
                                value.toString();
                            if (kDebugMode) {
                              print("currentWorkModeSelected " +
                                  value.toString());
                            }
                          },
                        ),
                      ],
                    ),
                  ])),

          CustomInputField(
            height: Get.height * 0.09,
            textHeading: "Enter your Official Email",
            hint: 'Enter your email.',
            isCaps: false,
            letterSpacing: 1.0,
            maxLenght: 50,
            isMandatory: false,
            keyBroadType: TextInputType.emailAddress,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp('[0-9,a-z,A-Z @._]')),
            ],
            controller: controller.emailOfficeController.value,
            isButton: false,
            // controller: controller.nameController.value,
          ),
          CustomDDHeading(
            textHeading: "Company Type",
            height: Get.height * 0.10,
            dropDown: CustomDropdown(
                currentValue: controller.selectedCompanyTypeModel.value?.id,
                list: controller.companyTypeList.value,
                onChanged: (value) {
                  if (kDebugMode) {
                    print("selectedCompanyTypeModel " + value.toString());
                  }
                  controller.selectedCompanyTypeModel.value = controller
                      .companyTypeList
                      .firstWhere((item) => item.id == value); // Change here
                }),
          ),

          CustomInputField(
            height: Get.height * 0.09,
            textHeading: "Enter Organisation Name",
            hint: 'Enter Organisation name.',
            isCaps: false,
            readOnly: false,
            letterSpacing: 1.0,
            maxLenght: 50,
            keyBroadType: TextInputType.name,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
            ],
            controller: controller.companyNameController.value,
            isButton: false,
            // controller: controller.nameController.value,
          ),
          CustomDDHeading(
            textHeading: "Enter Department Name",
            height: Get.height * 0.1,
            dropDown: CustomDropdown(
                currentValue: controller.deptValue.value,
                list: controller.deptList.value,
                isModelList: false,
                onChanged: (value) {
                  if (kDebugMode) {
                    print("deptValue " + value.toString());
                  }
                  controller.deptValue.value = value!;
                }),
          ),
          // CustomInputField(
          //   height: Get.height * 0.11,
          //   textHeading: "Enter Department Name",
          //   hint: 'Enter Department name.',
          //   isCaps: false,
          //   readOnly: false,
          //   letterSpacing: 1.0,
          //   maxLenght: 50,
          //   keyBroadType: TextInputType.name,
          //   formatter: [],
          //   controller: controller.deptNameController.value,
          //   isButton: false,
          //   // controller: controller.nameController.value,
          // ),
          CustomInputField(
            height: Get.height * 0.1,
            textHeading: "Enter Designation",
            hint: 'Enter designation.',
            isCaps: false,
            readOnly: false,
            letterSpacing: 1.0,
            maxLenght: 50,
            keyBroadType: TextInputType.name,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
            ],
            controller: controller.designationController.value,
            isButton: false,
            // controller: controller.nameController.value,
          ),
          CustomInputField(
            height: Get.height * 0.1,
            textHeading: "Enter Employment Since",
            hint: 'Enter employment since.',
            isCaps: false,
            letterSpacing: 1.0,
            maxLenght: 20,
            keyBroadType: TextInputType.name,
            formatter: const [],
            readOnly: true,
            isButton: true,
            buttonText: "Select",
            onPressed: () {
              controller.selectDate(context: context, isEmploymentDate: true);
            },
            controller: controller.empSinceController.value,
          ),
          // CustomInputField(
          //   height: Get.height * 0.11,
          //   textHeading: "Enter Tenure",
          //   hint: 'Enter in year & months',
          //   isCaps: false,
          //   readOnly: false,
          //   letterSpacing: 1.0,
          //   maxLenght: 2,
          //   keyBroadType: TextInputType.number,
          //   formatter: [],
          //   controller: controller.serviceTenureController.value,
          //   isButton: false,
          //   // controller: controller.nameController.value,
          // ),
          CustomInputField(
            height: Get.height * 0.1,
            textHeading: "Enter Office Address Line 1",
            hint: 'Enter address',
            isCaps: false,
            letterSpacing: 1.0,
            isMandatory: true,
            maxLenght: 50,
            keyBroadType: TextInputType.streetAddress,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ,()./-]*")),
            ],
            readOnly: false,
            maxLines: 1,
            isButton: false,
            controller: controller.officeAddressController1.value,
            buttonText: "Select",
            onPressed: () {
              // controller.selectDate(context);
            },
            // controller: controller.dobController.value,
          ),
          CustomInputField(
            height: Get.height * 0.1,
            textHeading: "Address Line 2",
            hint: 'Enter address',
            isMandatory: true,
            isCaps: false,
            letterSpacing: 1.0,
            maxLenght: 50,
            keyBroadType: TextInputType.streetAddress,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ,()./-]*")),
            ],
            readOnly: false,
            maxLines: 1,
            isButton: false,
            controller: controller.officeAddressController2.value,
            buttonText: "Select",
            onPressed: () {
              // controller.selectDate(context);
            },
            // controller: controller.dobController.value,
          ),
          CustomInputField(
            height: Get.height * 0.1,
            textHeading: "Address Landmark",
            hint: 'Enter Landmark.',
            isCaps: false,
            isMandatory: false,
            letterSpacing: 1.0,
            maxLenght: 50,
            keyBroadType: TextInputType.streetAddress,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ,()./-]*")),
            ],
            readOnly: false,
            maxLines: 1,
            isButton: false,
            controller: controller.officeAddressController3.value,
            buttonText: "Select",
            onPressed: () {
              // controller.selectDate(context);
            },
            // controller: controller.dobController.value,
          ),
          CustomInputField(
            height: Get.height * 0.11,
            textHeading: "Enter Pincode",
            hint: 'Enter Pincode.',
            isCaps: false,
            isMandatory: true,
            letterSpacing: 1.0,
            maxLenght: 6,
            keyBroadType: TextInputType.number,
            formatter: const [],
            readOnly: false,
            maxLines: 1,
            isButton: false,
            controller: controller.selectedOfficePinCodeValue.value,
            buttonText: "Select",
            onPressed: () {
              // controller.selectDate(context);
            },
            // controller: controller.dobController.value,
          ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.0,
          ),
          CustomButton(
            onPressed: () {
              var mobile = prefs.getString(SharedConstants.MOBILE);
              if (mobile.toString() != "9999999999") {
                if (controller.isLoadingOnSubmit.value == false) {
                  controller.saveEmploymentDetails();
                } else {
                  ShortMessage.toast(title: "Please wait...");
                }
              } else {
                Get.toNamed(RoutesName.AadhaarScreen);
              }
            },
            isLoading: controller.isLoadingOnSubmit.value,
            text: "NEXT",
            height: Get.height * 0.06,
          ),

          const SizedBox(),
          const SizedBox(),
        ],
      ),
    );
  }
}
