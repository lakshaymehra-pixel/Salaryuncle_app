import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/occupation_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/custom_widgets/su_step_progress.dart';
import 'package:tejas_loan/utils/events.dart';

import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/su_form_card.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../utils/shared_constants.dart';

class OccupationPage extends GetView<OccupationController> {
  const OccupationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomBackground(
        isAppBarVisible: false,
        enableBottomNav: false,
        height: Get.height * 0.8,
        heightOfUpperBox: Get.height * 0.6,
        children: [
          SizedBox(
            height: 20.sp,
          ),
          CustomHeadingText(
            text1: "Please Confirm Your Details",
            text2: "Select Occupation Type",
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.sp),
            child: SuStepProgress(currentPhase: SuStepProgress.phaseFromEvent(Events.getCurrentEvent())),
          ),
          SizedBox(
            height: 20.sp,
          ),
          SuFormCard(
            icon: Icons.badge_rounded,
            title: "Occupation Type",
            subtitle: "Choose the option that describes you",
            children: [
            Container(
              width: Get.width,
              child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5.sp),
                  child: Row(
                    children: [
                      Text(
                        "Select Occupation Type",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: ColorConstants.ink),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: ColorConstants.danger, fontWeight: FontWeight.w900, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  height: Get.height * 0.1,
                  decoration: BoxDecoration(
                      color: controller.selected.value == 0
                          ? ColorConstants.cardTintLight
                          : ColorConstants.surfaceLight,
                      border: Border.all(
                          width: 1.5,
                          color: controller.selected.value == 0 ? ColorConstants.primary : ColorConstants.border),
                      borderRadius: BorderRadius.circular(14.sp),
                      boxShadow: ColorConstants.softShadow),
                  child: ListTile(
                    onTap: () {
                      controller.selected.value = 0;
                    },
                    leading: controller.selected.value == 0
                        ? Icon(
                            Icons.check_circle,
                            color: ColorConstants.primary,
                            size: 23,
                          )
                        : Icon(
                            Icons.circle_outlined,
                            color: ColorConstants.muted,
                            size: 23,
                          ),
                    title: Text(
                      "SALARIED",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: ColorConstants.ink),
                    ),
                    // subtitle: Text("Select this,if you receive monthly salary",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w500, fontSize: 15.sp)),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  height: Get.height * 0.1,
                  decoration: BoxDecoration(
                      color: controller.selected.value == 1
                          ? ColorConstants.cardTintLight
                          : ColorConstants.surfaceLight,
                      border: Border.all(
                          width: 1.5,
                          color: controller.selected.value == 1 ? ColorConstants.primary : ColorConstants.border),
                      borderRadius: BorderRadius.circular(14.sp),
                      boxShadow: ColorConstants.softShadow),
                  child: ListTile(
                    onTap: () {
                      controller.selected.value = 1;
                    },
                    leading: controller.selected.value == 1
                        ? Icon(
                            size: 23,
                            Icons.check_circle,
                            color: ColorConstants.primary,
                          )
                        : Icon(
                            Icons.circle_outlined,
                            color: ColorConstants.muted,
                            size: 23,
                          ),
                    title: Text(
                      "SELF EMPLOYED",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: ColorConstants.ink),
                    ),
                    // subtitle: Text("Select this,if you run your on business",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w600, fontSize: 15.sp)),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                // Row(
                //   children: [
                //     Text(
                //       "Select required loan amount",
                //       style: TextStyle(
                //           fontWeight: FontWeight.w600, fontSize: 17.sp),
                //     ),
                //     Text(
                //       "*",
                //       style: TextStyle(
                //           color: Colors.red,
                //           fontWeight: FontWeight.w900,
                //           fontSize: 17.sp),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: Get.height * 0.01,
                // ),
                // SliderWidget(
                //   min: 0,
                //   max: 100,
                //   sliderHeight: Get.height * 0.06,
                //   onChanged: (value) {
                //     controller.currentLoanAmount.value = value;
                //     // totalValue.value = 0;
                //     // totalValue.value = currentLoanAmount * 100 +
                //     //     (currentLoanAmount * 1) * yearValue * 365;
                //   },
                //   currentValue: controller.currentLoanAmount.value,
                //   type: "K",
                // ),
                // SizedBox(
                //   height: Get.height * 0.01,
                // ),
                // Text(
                //   "Selected Amount : ₹" +
                //       (controller.currentLoanAmount.value * 100000)
                //           .toInt()
                //           .toString(),
                //   style:
                //       TextStyle(fontWeight: FontWeight.w900, fontSize: 17.sp),
                // )
              ],
            ),
            ),
            ],
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
              child: Column(
            children: [
              CustomButton(
                onPressed: () {
                  if (controller.selected.value == 0) {
                    // if ((controller.currentLoanAmount.value * 100000).toInt() >
                    //     5000) {
                    prefs.setString(
                        SharedConstants.LOAN_AMOUNT, (controller.currentLoanAmount.value * 100000).toInt().toString());
                    Get.toNamed(RoutesName.PanScreen);
                    // } else {
                    //   ShortMessage.toast(
                    //       title: "Amount should be greater than 5000 !!");
                    // }
                  } else {
                    ShortMessage.toast(title: "You should be Salaried only for this !!");
                  }
                },
                text: 'NEXT',
                height: Get.height * .06,
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
            ],
          )),
        ],
      ),
    );
  }
}
