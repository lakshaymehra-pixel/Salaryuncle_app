import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/custom_widgets/CustomBackground.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';

import '../main.dart';
import '../utils/shared_constants.dart';

class EligiblityFaliedPage extends StatelessWidget {
  DashbroadController controller = Get.put(DashbroadController());

  EligiblityFaliedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.offAllNamed(RoutesName.DashbroadScreen);
          return Future.value(false);
        },
        child: CustomBackground(heightOfUpperBox: 0, children: [
          SizedBox(height: 30.sp),
          Container(
            padding: EdgeInsets.all(14.sp),
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
              child: Icon(
                Icons.error_rounded,
                color: ColorConstants.danger,
                size: 48,
              ),
            ),
          ),
          SizedBox(height: 24.sp),
          SizedBox(
            width: Get.width,
            child: Text(
              textAlign: TextAlign.center,
              "Oops!",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: ColorConstants.danger,
              ),
            ),
          ),
          SizedBox(height: 24.sp),
          // SizedBox(height: 20),
          // SizedBox(height: 10),
          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 16.sp),
            decoration: BoxDecoration(
              color: ColorConstants.danger.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16.sp),
              border: Border.all(color: ColorConstants.danger.withOpacity(0.2)),
            ),
            child: Text(
              prefs.getString(SharedConstants.REJECT_REASON) ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.5.sp,
                height: 1.4,
                fontWeight: FontWeight.w500,
                color: ColorConstants.body,
              ),
            ),
          ),
          SizedBox(height: 53),
          // Text(
          //     "Click on the button below to go to \n\n dashboard \n\n"
          //     "to get more details",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(fontSize: 17.sp, color: Colors.black54, fontWeight: FontWeight.w600)),
          // SizedBox(height: 30.sp),
          CustomButton(
            onPressed: () {
              Get.offAllNamed(RoutesName.DashbroadScreen);
            },
            text: "Go to Dashboard",
            height: Get.height * 0.06,
          ),
        ]));
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
