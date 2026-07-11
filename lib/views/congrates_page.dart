import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/custom_widgets/CustomBackground.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

class CongratesPage extends StatelessWidget {
  DashbroadController controller = Get.put(DashbroadController());

  CongratesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
          onWillPop: () {
            Get.offAllNamed(RoutesName.DashbroadScreen);
            return Future.value(false);
          },
          child: CustomBackground(heightOfUpperBox: 0, children: [
            Stack(
              children: [
                Positioned(
                  top: 40.sp,
                  child: SizedBox(
                    width: Get.width,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Congratulations!",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        color: ColorConstants.success,
                      ),
                    ),
                  ),
                ),
                Lottie.network(
                    backgroundLoading: true,
                    frameRate: const FrameRate(60),
                    fit: BoxFit.fitHeight,
                    height: 60.sp,
                    width: 85.sp,
                    repeat: true,
                    'https://lottie.host/6044ab24-4828-4892-94bb-5f0e6eed01da/JRmxuAjj9u.json'),
              ],
            ),
            // SizedBox(height: 20),
            // SizedBox(height: 10),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "You are eligible to take a loan from",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(context).textTheme.titleLarge!.color,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                    text: "\n ${SharedConstants.Brand_Name} \n\n",
                    style: TextStyle(fontSize: 16.sp, color: ColorConstants.primary, fontWeight: FontWeight.w700),
                  )
                ])),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Text("Click on the button below to enter your loan details.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 40.sp),
            CustomButton(
                isLoading: controller.loadingOnDashboard.value,
                onPressed: () {
                  controller.checkLoanQuote();
                },
                height: Get.height * 0.06,
                text: "Enter Loan Details"),
            TextButton(
                onPressed: () {
                  Get.offAllNamed(RoutesName.DashbroadScreen);
                },
                child: Text(
                  "< Go to Dashboard",
                  style: TextStyle(color: ColorConstants.primary, fontSize: 16.sp, fontWeight: FontWeight.w600),
                ))
          ]));
    });
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
