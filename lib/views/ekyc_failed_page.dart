import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/utils/color_constants.dart';

import '../custom_widgets/slideIn_animation.dart';

class EkycFailedPage extends StatelessWidget {
  const EkycFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldLight,
      // Background color relevant to success
      body: Stack(
        children: [
          Container(
            height: Get.height * 0.18,
            decoration: const BoxDecoration(
              gradient: ColorConstants.brandGradient,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
          ),
          Padding(
        padding: EdgeInsets.all(24.sp),
        child: Center(
          child: SlideTransitionAnimation(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.surfaceLight,
                    shape: BoxShape.circle,
                    boxShadow: ColorConstants.softShadow,
                  ),
                  child: Container(
                  padding: EdgeInsets.all(18.sp),
                  decoration: BoxDecoration(
                    color: ColorConstants.danger.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Lottie.network(
                      frameRate: const FrameRate(60),
                      backgroundLoading: true,
                      fit: BoxFit.fitHeight,
                      height: 55.sp,
                      width: 55.sp,
                      repeat: false,
                      'https://lottie.host/ad47f861-8db9-47f9-8882-8ceb8d62ace6/mqm2KrgzXq.json'),
                ),
                ),
                SizedBox(height: 28.sp),
                Text(
                  "Oops!",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    color: ColorConstants.danger,
                  ),
                ),
                SizedBox(height: 12.sp),
                Text(
                  "Your eKYC has been failed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.5.sp,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        ],
      ),
    );
  }
}

// Container(
//   height: 100.sp,
//   width: 50.sp,
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
