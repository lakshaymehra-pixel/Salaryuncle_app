import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/personalDetailsController.dart';
import 'package:tejas_loan/custom_widgets/custom_dd_heading.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/su_step_progress.dart';
import 'package:tejas_loan/utils/events.dart';
import '../controller/internet_connectivity_controller.dart';
import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/CustomInputField.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/su_form_card.dart';
import '../custom_widgets/custom_dropdown.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../utils/shared_constants.dart';

class ResidenceDetailsPage extends GetView<PersonalDetailController> {
  var mobile = prefs.getString(SharedConstants.MOBILE);

  ResidenceDetailsPage({super.key});
  ConnectionManagerController connectionManagerController = Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomBackground(
        isAppBarVisible: true,
        heightOfUpperBox: Get.height * 0.7,
        height: Get.height * 0.9,
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          CustomHeadingText(
              text2: "Please fill in your work information", text1: "Enter Your Current Residence Details "),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            child: SuStepProgress(currentPhase: SuStepProgress.phaseFromEvent(Events.getCurrentEvent())),
          ),
          SizedBox(
            height: 10.sp,
          ),
          SuFormCard(
            icon: Icons.home_rounded,
            title: "Current Residence",
            subtitle: "Your present home address details",
            children: [
              CustomDDHeading(
                textHeading: "Residence Type",
                height: Get.height * 0.1,
                dropDown: CustomDropdown(
                    currentValue: controller.selectedResTypeModel.value.id,
                    list: controller.resTypeList.value,
                    onChanged: (value) {
                      controller.selectedResTypeModel.value = controller.resTypeList
                          .firstWhere(
                              (item) => item.id == value); // Change here

                      print("selectedResTypeModel ==> ${controller.selectedResTypeModel.value.name}");
                    }),

              ),
              CustomInputField(
                height: Get.height * 0.1,
                textHeading: "Address Line 1",
                hint: 'Enter address',
                isCaps: false,
                isFoused: controller.isFoused.value,
                letterSpacing: 1.0,
                maxLenght: 50,
                keyBroadType: TextInputType.streetAddress,
                formatter: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ,()./-]*")),
                ],
                readOnly: false,
                maxLines: 1,
                isButton: false,
                controller: controller.addressController1.value,
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
                isCaps: false,
                isMandatory: true,
                letterSpacing: 1.0,
                maxLenght: 50,
                keyBroadType: TextInputType.streetAddress,
                formatter: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ,()./-]*")),
                ],
                readOnly: false,
                maxLines: 1,
                isButton: false,
                controller: controller.addressController2.value,
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
                controller: controller.addressController3.value,
                buttonText: "Select",
                onPressed: () {
                  // controller.selectDate(context);
                },
                // controller: controller.dobController.value,
              ),
              CustomInputField(
                height: Get.height * 0.1,
                textHeading: "Enter Pincode",
                hint: 'Enter Pincode.',
                isCaps: false,
                isMandatory: true,
                letterSpacing: 1.0,
                maxLenght: 6,
                keyBroadType: TextInputType.number,
                formatter: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                readOnly: false,
                maxLines: 1,
                isButton: false,
                controller: controller.selectedPinCodeValue.value,
                buttonText: "Select",
                onPressed: () {
                  // controller.selectDate(context);
                },
                // controller: controller.dobController.value,
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          CustomButton(
            onPressed: () {
              var mobile = prefs.getString(SharedConstants.MOBILE);
              if (mobile.toString() != "9999999999") {
                if (controller.isLoadingOnSubmit.value == false) {
                  controller.saveResidentialDetails();
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
          SizedBox(
            height: 15.sp,
          ),
        ],
      ),
    );
  }
}
