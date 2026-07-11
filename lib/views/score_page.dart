import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/show_score_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/main.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/HeadingText.dart';
import '../utils/color_constants.dart';
import '../utils/shared_constants.dart';
import 'cibil_view_page.dart';

class ShowScorePage extends GetView<ShowScoreController> {
  const ShowScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomBackground(
        heightOfUpperBox: Get.height * 0.7,
        height: Get.height * 0.8,
        doubleBackToCloseApp: false,
        children:
            // controller.loading.value
            //     ? [
            //         SizedBox(
            //           height: Get.height * 0.03,
            //         ),
            //         Container(alignment: Alignment.center, height: Get.height * 0.7, child: CircularProgressIndicator())
            //       ]
            //     :
            controller.score.value == 0
                ? [
                    SizedBox(
                      height: Get.height * 0.12,
                    ),
                    Center(
                      child: Container(
                        height: 96.sp,
                        width: 96.sp,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.cardTintLight,
                        ),
                        child: Icon(
                          Icons.speed_rounded,
                          color: ColorConstants.primary,
                          size: 52.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    Center(
                        child: Text(
                      "No Score Found",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 22.sp, color: ColorConstants.ink),
                    )),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Center(
                      child: SizedBox(
                          width: Get.width * 0.72,
                          child: Text(
                            "Your score is not yet calculated. Please complete your profile to get your score.",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                height: 1.4,
                                color: ColorConstants.muted),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ]
                : [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CustomHeadingText(
                        text1:
                            "Hi, ${(prefs.getString(SharedConstants.NAME) ?? 'hi user').split(' ').map((word) => word.capitalize!).join(' ')}",
                        text2: 'Here is Your Score!'),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SfRadialGauge(enableLoadingAnimation: true, animationDuration: 3500, axes: <RadialAxis>[
                      RadialAxis(
                          startAngle: 180,
                          endAngle: 0,
                          minimum: 0,
                          maximum: 900,
                          showLabels: true,
                          interval: 180,
                          maximumLabels: 2,
                          onLabelCreated: (AxisLabelCreatedArgs args) {},
                          axisLabelStyle: GaugeTextStyle(
                            color: prefs.getBool(SharedConstants.THEME) ?? false ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                          showLastLabel: true,
                          labelsPosition: ElementsPosition.outside,
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: 0,
                              endValue: 180,
                              color: ColorConstants.danger,
                              startWidth: 30.sp,
                              endWidth: 30.sp,
                            ),
                            GaugeRange(
                              startValue: 180,
                              endValue: 360,
                              color: ColorConstants.warning,
                              startWidth: 30.sp,
                              endWidth: 30.sp,
                            ),
                            GaugeRange(
                              startValue: 360,
                              endValue: 540,
                              color: ColorConstants.gold,
                              startWidth: 30.sp,
                              endWidth: 30.sp,
                            ),
                            GaugeRange(
                                startValue: 540,
                                startWidth: 30.sp,
                                endWidth: 30.sp,
                                endValue: 720,
                                color: ColorConstants.success.withOpacity(0.7)),
                            GaugeRange(
                              startValue: 720,
                              endValue: 900,
                              startWidth: 30.sp,
                              endWidth: 30.sp,
                              color: ColorConstants.success,
                            )
                          ],
                          pointers: <GaugePointer>[
                            NeedlePointer(
                              value: controller.score.value.toDouble(),
                              needleStartWidth: 1.sp,
                              needleEndWidth: 12.sp,
                              needleColor: prefs.getBool(SharedConstants.THEME) ?? false ? Colors.white : Colors.black,
                              knobStyle: KnobStyle(
                                color: prefs.getBool(SharedConstants.THEME) ?? false ? ColorConstants.accent : ColorConstants.primary,
                              ),
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Text(controller.score.value.toString(),
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).textTheme.titleLarge!.color)),
                                angle: 90,
                                positionFactor: 0.2),
                          ])
                    ]),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
                      decoration: BoxDecoration(
                        color: ColorConstants.cardTintLight,
                        borderRadius: BorderRadius.circular(16.sp),
                        border: Border.all(color: ColorConstants.border),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_rounded, color: ColorConstants.primary, size: 20.sp),
                          SizedBox(width: 10.sp),
                          Expanded(
                            child: Text(
                              "Review your activity based on the previous loan sanctioned by ${SharedConstants.Brand_Name}.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.5.sp,
                                  height: 1.35,
                                  color: ColorConstants.body),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CustomButton(
                        height: Get.height * 0.06,
                        onPressed: () {
                          Get.to(() => ReportPage());
                        },
                        text: "View Report"),
                  ],
      );
    });
  }
}
