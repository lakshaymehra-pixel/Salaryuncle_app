import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/custom_widgets/CustomBackground.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';

class PaymentFailedPage extends StatelessWidget {
  const PaymentFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(heightOfUpperBox: 0, children: [
      SizedBox(height: 53),
      Container(
        padding: EdgeInsets.all(14.sp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstants.surfaceLight,
          boxShadow: ColorConstants.softShadow,
        ),
        child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstants.danger.withOpacity(0.12),
        ),
        alignment: Alignment.center,
        child: Lottie.network(
            backgroundLoading: true,
            frameRate: const FrameRate(60),
            fit: BoxFit.fitHeight,
            height: 67,
            width: 67,
            repeat: false,
            'https://lottie.host/ad47f861-8db9-47f9-8882-8ceb8d62ace6/mqm2KrgzXq.json'),
      ),
      ),
      SizedBox(height: 20.sp),
      Text(
        "Payment Failed!",
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: ColorConstants.danger,
            ),
      ),
      SizedBox(height: 20.sp),
      Text(
        "Your Payment has been failed. Please try again.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.sp,
          color: ColorConstants.muted,
        ),
      ),
      SizedBox(height: 53),
      CustomButton(
        height: Get.height * 0.06,
        onPressed: () {
          Get.offAllNamed(RoutesName.DashbroadScreen);
        },
        text: "Go to Dashboard",
      )
    ]);
  }
}

// Container(
//   height: 180,
//   width: 83,
//   child: Lottie.network(
//     onLoaded: (a) {
//       print(a.seconds);
//     },
//     // Success Animation
//     'https://lottie.host/07f22094-2144-4c1f-8fd7-e878afb7ac41/mg3s1WtVZR.json',
//     // Failed Animation
//     // 'https://lottie.host/ad47f861-8db9-47f9-8882-8ceb8d62ace6/mqm2KrgzXq.json',
//     repeat: false,
//   ),
// ),
