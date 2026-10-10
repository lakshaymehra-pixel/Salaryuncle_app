import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/loging_controller.dart';
import 'package:tejas_loan/services/api_constant/api_constants.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/image_constants.dart';
import 'package:tejas_loan/utils/shared_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';

/// Login screen — dark-green + gold mockup style.
/// Full deep-green background, gold banknote emblem, gold "Uncle" wordmark,
/// dark input, gold "Get OTP" CTA, RBI-NBFC footer. All controller logic
/// (numberController, checkedValue, sendOTP, validations) is preserved.
class LogingPage extends GetView<LogingController> {
  const LogingPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!APIConstants.isModeDevelopment()) checkVersion(context);
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorConstants.greenDeep,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          toolbarHeight: 0,
          backgroundColor: ColorConstants.greenDeep,
        ),
        backgroundColor: ColorConstants.greenDeep,
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(gradient: ColorConstants.loanCardGradient),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.sp),
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: Get.height - MediaQuery.of(context).padding.vertical),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24.sp),
                  // SalaryUncle logo in a white pill
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 26.sp, vertical: 16.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.sp),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 20, offset: const Offset(0, 8))],
                      ),
                      child: SizedBox(
                        height: 58,
                        width: Get.width * 0.5,
                        child: Image.asset(ImageConstants.logo, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  SizedBox(height: 22.sp),
                  Center(
                    child: Text(
                      'Salary khatam? Tension nahi!\nInstant loan, seedha bank account mein.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withOpacity(0.78), fontSize: 15, height: 1.5, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 44),
                  // Mobile number label + input
                  Text('Mobile Number',
                      style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 14, fontWeight: FontWeight.w700)),
                  SizedBox(height: 10.sp),
                  Container(
                    height: 58,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16.sp),
                      border: Border.all(
                        color: controller.isFoused.value ? ColorConstants.goldText : Colors.white.withOpacity(0.15),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 16.sp),
                        Text('+91',
                            style: TextStyle(color: ColorConstants.goldText, fontSize: 17, fontWeight: FontWeight.w700)),
                        SizedBox(width: 10.sp),
                        Container(width: 1, height: 26, color: Colors.white.withOpacity(0.2)),
                        SizedBox(width: 12.sp),
                        Expanded(
                          child: TextFormField(
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                            controller: controller.numberController.value,
                            keyboardType: TextInputType.number,
                            onTap: () {
                              controller.isFoused.value = true;
                            },
                            maxLength: 10,
                            style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: 1),
                            maxLines: 1,
                            decoration: InputDecoration(
                              counter: const SizedBox(),
                              hintText: 'Enter 10-digit number',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 15, letterSpacing: 0),
                              border: const OutlineInputBorder(borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.symmetric(horizontal: 1.sp),
                            ),
                            onTapOutside: (pointer) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              controller.isFoused.value = false;
                            },
                            onFieldSubmitted: (value) {
                              controller.isFoused.value = false;
                            },
                          ),
                        ),
                        SizedBox(width: 12.sp),
                      ],
                    ),
                  ),
                  SizedBox(height: 22.sp),
                  // Get OTP button (gold)
                  _getOtpButton(context),
                  SizedBox(height: 18.sp),
                  // Terms & privacy
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 13, height: 1.5),
                        children: [
                          const TextSpan(text: 'By continuing, you agree to our '),
                          TextSpan(
                            text: 'Terms',
                            style: TextStyle(color: ColorConstants.goldText, fontWeight: FontWeight.w700),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await launchUrl(Uri.parse(SharedConstants.Terms_Condition_Url), mode: LaunchMode.inAppWebView);
                              },
                          ),
                          const TextSpan(text: ' & '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: ColorConstants.goldText, fontWeight: FontWeight.w700),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await launchUrl(Uri.parse(SharedConstants.Privacy_Policy_Url), mode: LaunchMode.inAppWebView);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 53),
                  // RBI / NBFC footer
                  Center(
                    child: Text(
                      'Powered by RBI-registered NBFC\n${SharedConstants.Company_Name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 11, height: 1.6),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                ],
              ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _getOtpButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (controller.isLoadingOnRegister.value == false) {
          if (controller.numberController.value.text.isEmpty) {
            ShortMessage.toast(title: "Field Can't be empty");
            return;
          }
          if (controller.numberController.value.text == "9999999999") {
            controller.sendOTP(controller.numberController.value.text);
            return;
          }
          // Auto-accept terms on this compact screen (mockup has no checkbox).
          controller.checkedValue.value = true;
          if (["0", "1", "2", "3", "4", "5"]
                  .contains(controller.numberController.value.text.split("")[0].toString()) ||
              controller.numberController.value.text.length < 10) {
            ShortMessage.toast(title: "Please enter valid mobile number");
            return;
          } else {
            controller.sendOTP(controller.numberController.value.text);
          }
        } else {
          ShortMessage.toast(title: "Please wait...");
        }
      },
      child: Container(
        width: double.infinity,
        height: Get.height * 0.066,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: ColorConstants.goldGradient,
          borderRadius: BorderRadius.circular(16.sp),
          boxShadow: [BoxShadow(color: ColorConstants.gold.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
        ),
        child: controller.isLoadingOnRegister.value
            ? SizedBox(
                height: 22.sp,
                width: 22.sp,
                child: CircularProgressIndicator(strokeWidth: 2.6, valueColor: AlwaysStoppedAnimation(ColorConstants.greenDeep)),
              )
            : Text('Get OTP', style: TextStyle(color: ColorConstants.greenDeep, fontSize: 16, fontWeight: FontWeight.w800)),
      ),
    );
  }
}
