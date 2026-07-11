import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_auth/smart_auth.dart';
import 'package:tejas_loan/controller/loging_controller.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../utils/color_constants.dart';
import '../utils/sms_retriever_impl.dart';

/// OTP screen — dark-green + gold mockup style. Preserves OTP auto-fetch
/// (smsRetriever), controller.OTP binding, register(), reSendOTP(), countdown.
class OtpScreen extends GetView<LogingController> {
  OtpScreen({super.key});

  final SmsRetrieverImpl smsRetriever = SmsRetrieverImpl(SmartAuth());

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 54,
      height: 58,
      margin: EdgeInsets.symmetric(horizontal: 6.sp),
      textStyle: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w800),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
        borderRadius: BorderRadius.circular(14.sp),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: ColorConstants.goldText, width: 1.8),
      borderRadius: BorderRadius.circular(14.sp),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(color: Colors.white.withOpacity(0.12)),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorConstants.greenDeep,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorConstants.greenDeep,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: ColorConstants.greenDeep,
      body: Obx(() {
        return Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(gradient: ColorConstants.loanCardGradient),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 26.sp),
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: Get.height - MediaQuery.of(context).padding.vertical - 1),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24.sp),
                  // Gold lock emblem
                  Container(
                    height: 78.sp,
                    width: 78.sp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorConstants.goldText.withOpacity(0.4), width: 1.5),
                      boxShadow: [BoxShadow(color: ColorConstants.gold.withOpacity(0.25), blurRadius: 40)],
                    ),
                    child: Icon(Icons.lock_outline_rounded, color: ColorConstants.goldText, size: 38.sp),
                  ),
                  SizedBox(height: 18.sp),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                      children: [
                        const TextSpan(text: 'Verify ', style: TextStyle(color: Colors.white)),
                        TextSpan(text: 'OTP', style: TextStyle(color: ColorConstants.goldText)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Text('Code bheja hai aapke number pe',
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15.sp)),
                  SizedBox(height: 4.sp),
                  Text(
                    _maskedNumber(),
                    style: TextStyle(color: ColorConstants.goldText, fontSize: 17.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 34.sp),
                  // Pin boxes
                  Pinput(
                    length: 4,
                    smsRetriever: smsRetriever,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    cursor: Container(width: 2, height: 24, color: ColorConstants.goldText),
                    onCompleted: (pin) {
                      controller.OTP.value = pin;
                    },
                    onTapOutside: (_) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    onChanged: (pin) {
                      controller.OTP.value = pin;
                    },
                  ),
                  SizedBox(height: 30.sp),
                  // Verify button (gold)
                  GestureDetector(
                    onTap: () {
                      controller.register();
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
                          : Text('Verify & Continue',
                              style: TextStyle(color: ColorConstants.greenDeep, fontSize: 15.sp, fontWeight: FontWeight.w800)),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  // Resend
                  controller.isResend.value
                      ? InkWell(
                          onTap: () {
                            controller.isResend.value == false;
                            controller.reSendOTP();
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13.sp),
                              children: [
                                const TextSpan(text: 'Code nahi mila? '),
                                TextSpan(text: 'Resend OTP', style: TextStyle(color: ColorConstants.goldText, fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                        )
                      : Countdown(
                          controller: controller.countdown_controller.value,
                          seconds: 60,
                          build: (BuildContext context, double time) => Text(
                            'Resend OTP in 00:${time.toInt().toString().padLeft(2, '0')}',
                            style: TextStyle(color: Colors.white.withOpacity(0.55), fontWeight: FontWeight.w600, fontSize: 13.sp),
                          ),
                          interval: const Duration(milliseconds: 100),
                          onFinished: () {
                            if (kDebugMode) {
                              print("DONE");
                            }
                            controller.isResend.value = true;
                          },
                        ),
                  SizedBox(height: 20.sp),
                  // Change number
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutesName.LoginScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14.sp),
                        border: Border.all(color: Colors.white.withOpacity(0.12)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_rounded, size: 16.sp, color: ColorConstants.goldText),
                          SizedBox(width: 8.sp),
                          Text('Change Phone Number',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: ColorConstants.goldText)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.sp),
                  Text('Your data is 256-bit encrypted & never shared',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11)),
                  SizedBox(height: 20.sp),
                ],
              ),
              ),
            ),
          ),
        );
      }),
    );
  }

  String _maskedNumber() {
    final n = controller.numberController.value.text;
    if (n.length == 10) {
      return '+91 ${n.substring(0, 2)}XXXXXX${n.substring(8)}';
    }
    return '+91 $n';
  }
}
