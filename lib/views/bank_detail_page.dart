import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/su_step_progress.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/events.dart';

import '../controller/bankController.dart';
import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/CustomInputField.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/su_form_card.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';
import '../utils/shared_constants.dart';

class BankDetailPage extends GetView<BankController> {
  const BankDetailPage({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomBackground(
          height: Get.height * 0.95,
          heightOfUpperBox: Get.height * 0.7,
          children: [
            SizedBox(height: Get.height * 0.03),
            CustomHeadingText(text2: 'Please fill in your work information', text1: 'Enter Your Bank Account Details'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: SuStepProgress(currentPhase: SuStepProgress.phaseFromEvent(Events.getCurrentEvent())),
            ),
            SizedBox(height: Get.height * 0.015),
            SuFormCard(
              icon: Icons.account_balance_rounded,
              title: "Bank Account",
              subtitle: "Where we'll disburse your loan amount",
              children: [
                CustomInputField(
                  height: Get.height * 0.1,
                  keyBroadType: TextInputType.name,
                  textHeading: "Name(as per Bank Account)",
                  hint: 'Enter your Name',
                  formatter: [FilteringTextInputFormatter.allow(RegExp("[A-Z,a-z, ' ']"))],
                  // heightOfTextField: Get.height * 0.1,
                  isCaps: true,
                  isButton: false,
                  maxLenght: 20,
                  // maxLines: 4,
                  letterSpacing: 5.0,
                  controller: controller.nameController.value,
                ),
                CustomInputField(
                  height: Get.height * 0.1,
                  keyBroadType: TextInputType.name,
                  textHeading: "Account Branch Name",
                  hint: 'Enter Branch Name',
                  formatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  ],
                  isCaps: true,
                  isButton: false,
                  maxLenght: 20,
                  letterSpacing: 5.0,
                  controller: controller.branchController.value,
                ),
                CustomInputField(
                  height: Get.height * 0.1,
                  keyBroadType: TextInputType.number,
                  textHeading: "Account Number",
                  hint: 'Enter Account Number',
                  formatter: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                  isCaps: true,
                  isButton: false,
                  maxLenght: 20,
                  letterSpacing: 5.0,
                  controller: controller.accountNumberController.value,
                ),
                CustomInputField(
                  height: Get.height * 0.1,
                  isInteractive: false,
                  keyBroadType: TextInputType.number,
                  textHeading: "Confirm Account Number",
                  hint: 'Enter Account Number',
                  formatter: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                  isCaps: true,
                  isButton: false,
                  maxLenght: 20,
                  letterSpacing: 5.0,
                  controller: controller.confirmAccountNumberController.value,
                ),
                CustomInputField(
                  height: Get.height * 0.1,
                  keyBroadType: TextInputType.name,
                  textHeading: "IFSC Code",
                  hint: 'Enter IFSC Code',
                  formatter: [FilteringTextInputFormatter.allow(RegExp("[A-Z,0-9,a-z]"))],
                  isCaps: true,
                  isButton: false,
                  maxLenght: 15,
                  letterSpacing: 5.0,
                  controller: controller.ifscController.value,
                ),
              ],
            ),
            SizedBox(height: 18.sp),
            CustomButton(
              onPressed: () {
                var mobile = prefs.getString(SharedConstants.MOBILE);
                if (mobile.toString() != "9999999999") {
                  if (controller.isLoading.value == false) {
                    controller.findBANK();
                  } else {
                    ShortMessage.toast(title: "Please wait while we proceed");
                  }
                } else {
                  Get.toNamed(RoutesName.ThankyouScreen);
                }
              },
              isLoading: controller.isLoading.value,
              text: "Submit",
              height: Get.height * 0.06,
            ),
            SizedBox(height: 15.sp),
          ],
        ));
  }
}
