import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/custom_widgets/CustomBackground.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';

import '../custom_widgets/custom_button.dart';
import '../custom_widgets/slideIn_animation.dart';

class ThankyouPage extends StatelessWidget {
  const ThankyouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(heightOfUpperBox: 0, children: [
      SizedBox(height: 30.sp),
      Padding(
        padding: EdgeInsets.all(10.sp),
        child: Center(
          child: SlideTransitionAnimation(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(14.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.surfaceLight,
                    boxShadow: ColorConstants.softShadow,
                  ),
                  child: Container(
                  height: 70.sp,
                  width: 70.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.success.withOpacity(0.12),
                  ),
                  alignment: Alignment.center,
                  child: Lottie.network(
                      backgroundLoading: true,
                      frameRate: const FrameRate(60),
                      fit: BoxFit.fitHeight,
                      height: 55.sp,
                      width: 55.sp,
                      repeat: false,
                      'https://lottie.host/07f22094-2144-4c1f-8fd7-e878afb7ac41/mg3s1WtVZR.json'),
                ),
                ),
                SizedBox(height: 20.sp),
                Text(
                  "Congratulations!",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: ColorConstants.success,
                      ),
                ),
                SizedBox(height: 20.sp),
                Text(
                  "Your Application has been successfully completed and submitted. Our team will reach out to you shortly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstants.muted,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 30.sp),
                CustomButton(
                  height: Get.height * 0.06,
                  text: "Go to Dashboard",
                  onPressed: () {
                    Get.offAllNamed(RoutesName.DashbroadScreen);
                  },
                )
              ],
            ),
          ),
        ),
      )
    ]);
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
