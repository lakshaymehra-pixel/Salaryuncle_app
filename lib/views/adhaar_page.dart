import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/aadhaar_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/custom_widgets/su_step_progress.dart';
import 'package:tejas_loan/utils/events.dart';
import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/CustomInputField.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/su_form_card.dart';
import '../main.dart';
import '../utils/shared_constants.dart';

class AdhaarPage extends GetView<AadhaarController> {
  AdhaarPage({super.key}) ;

  final defaultPinTheme = PinTheme(
    width: 42,
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 3),
    textStyle: const TextStyle(fontSize: 20, color: ColorConstants.ink, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: ColorConstants.border),
      borderRadius: BorderRadius.circular(14),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomBackground(
        height: Get.height * 0.8,
        heightOfUpperBox: Get.height * 0.6,
        children: [
          SizedBox(
            height: 20.sp,
          ),
          CustomHeadingText(text2: 'Please fill in your work information', text1: "Verify Aadhaar Details "),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            child: SuStepProgress(currentPhase: SuStepProgress.phaseFromEvent(Events.getCurrentEvent())),
          ),
          SizedBox(
            height: 10.sp,
          ),
          SuFormCard(
            icon: Icons.verified_user_rounded,
            title: "Aadhaar Verification",
            subtitle: "Enter your 12-digit Aadhaar number",
            children: [
          CustomInputField(
            isEdit: controller.isEnabled.value,
            onEditPressed: () {
              // Editing the number invalidates the OTP that was sent for the
              // old one, so clear both rather than leaving a stale request id.
              controller.isEnabled.value = false;
              controller.OTP.value = "";
              controller.request_Id.value = "";
              ShortMessage.toast(title: "Edit your number");
            },
            height: Get.height * 0.13,
            readOnly: controller.isEnabled.value,
            keyBroadType: TextInputType.number,
            textHeading: 'Enter your Aadhaar No.',
            hint: 'Enter your Aadhaar No.',
            isButton: false,
            maxLenght: 12,
            formatter: [FilteringTextInputFormatter.digitsOnly],
            controller: controller.aadhaarController.value,
            isLoading: controller.isLoadingOnSendOTP.value,
            onPressed: () {
              controller.sendAadhaarOTP(controller.aadhaarController.value.text);
            },
          ),
          SizedBox(height: 12.sp),
          // CustomInputField's own button renders a hardcoded calendar icon
          // (it was written for date fields), so this screen needs its own.
          if (!controller.isEnabled.value)
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                onPressed: () => controller
                    .sendAadhaarOTP(controller.aadhaarController.value.text),
                isLoading: controller.isLoadingOnSendOTP.value,
                text: 'Send OTP',
                height: Get.height * 0.055,
              ),
            ),
            ],
          ),
          // Shown once the OTP has actually been sent; UIDAI sends a 6-digit code.
          if (controller.isEnabled.value) ...[
            SizedBox(height: 18.sp),
            SuFormCard(
              icon: Icons.sms_outlined,
              title: "Enter Aadhaar OTP",
              subtitle: "6-digit code sent to your Aadhaar-linked mobile",
              children: [
                SizedBox(height: 10.sp),
                Center(
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyDecorationWith(
                      border: Border.all(color: ColorConstants.primary, width: 1.6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: ColorConstants.cardTintLight,
                      ),
                    ),
                    showCursor: true,
                    keyboardType: TextInputType.number,
                    onChanged: (pin) => controller.OTP.value = pin,
                    onCompleted: (pin) => controller.OTP.value = pin,
                  ),
                ),
                SizedBox(height: 12.sp),
                Center(
                  child: TextButton(
                    onPressed: controller.isLoadingOnSendOTP.value
                        ? null
                        : () {
                            controller.isEnabled.value = false;
                            controller.OTP.value = "";
                            controller.request_Id.value = "";
                            controller.sendAadhaarOTP(controller.aadhaarController.value.text);
                          },
                    child: Text("Resend OTP",
                        style: TextStyle(
                            color: ColorConstants.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp)),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(
            height: 30.sp,
          ),
          CustomButton(
            onPressed: () {
              var mobile = prefs.getString(SharedConstants.MOBILE);
              if (mobile.toString() != "9999999999") {
                if (controller.isLoadingProceed.value == false) {
                  controller.verifyOTP();
                } else {
                  ShortMessage.toast(title: "Please wait while we proceed");
                }
              } else {
                Get.toNamed(RoutesName.BankScreen);
              }
            },
            text: 'Proceed',
            isLoading: controller.isLoadingProceed.value,
            height: Get.height * 0.06,
          ),
        ],
      );
    });
  }
}
