import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/loan_calculator_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/services/api_constant/api_constants.dart';
import 'package:tejas_loan/services/api_service.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

// import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../custom_widgets/CustomBackground.dart';
import '../custom_widgets/CustomInputField.dart';
import '../custom_widgets/HeadingText.dart';
import '../custom_widgets/custom_dd_heading.dart';
import '../custom_widgets/custom_dropdown.dart';
import '../custom_widgets/custom_slider.dart';
import '../main.dart';
import '../routes/routes_names.dart';
import '../utils/color_constants.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';

class LoanAmountPage extends GetView<LoanCalculatorController> {
  LoanAmountPage({super.key});

  var height = Get.height;
  var width = Get.width;

  @override
  Widget build(BuildContext context) {
    // print("total value = ${controller.maxValue.value}");
    return Obx(() {
      return CustomBackground(
          doubleBackToCloseApp: false,
          heightOfUpperBox: Get.height * 0.7,
          children: [
            SizedBox(height: 10.sp),
            CustomHeadingText(
              text2: "Please fill in your loan information",
              text1: "LOAN CALCULATOR",
            ),
            SizedBox(height: 14.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 26.sp, horizontal: 18.sp),
                decoration: BoxDecoration(
                  color: ColorConstants.surfaceLight,
                  borderRadius: BorderRadius.circular(22.sp),
                  border: Border.all(color: const Color(0xFFE4EDE8)),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.greenDeep.withOpacity(0.06),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                      "₹${((controller.currentLoanAmount.value) * 1000).round()}",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: ColorConstants.greenDeep,
                        letterSpacing: -0.5,
                      ),
                    ),
                    ),
                    SizedBox(height: 6.sp),
                    Text(
                      "Loan amount chuniye",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.muted,
                      ),
                    ),
                    SizedBox(height: 16.sp),
                    Container(height: 1, color: const Color(0xFFEDF3F0)),
                    SizedBox(height: 14.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: _SuMiniStat(
                          title: "Tenure",
                          value:
                              "${(controller.currentTenure.value).toInt()} days",
                        )),
                        Container(
                            width: 1,
                            height: 30.sp,
                            color: const Color(0xFFEDF3F0)),
                        Expanded(child: _SuMiniStat(
                          title: "Total Payable",
                          value:
                              "₹${((controller.totalValue.value.value * 100).round()) * 10}",
                        )),
                        Container(
                            width: 1,
                            height: 30.sp,
                            color: const Color(0xFFEDF3F0)),
                        Expanded(child: _SuMiniStat(
                          title: "Interest / day",
                          value:
                              "₹${((controller.currentLoanAmount.value) * 10).round()}",
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.sp),
            if (!(Get.arguments ?? false))
              CustomDDHeading(
                textHeading: "Loan Purpose",
                height: Get.height * 0.1,
                dropDown: CustomDropdown(
                    currentValue: controller.purposeValue.value.id,
                    list: controller.purposeList.value,
                    onChanged: (value) {
                      controller.purposeValue.value = controller.purposeList
                          .firstWhere(
                              (item) => item.id == value); // Change here

                      print("purposeValue ==> ${controller.purposeValue.value.name}");
                    }),
              ),
            SizedBox(height: 8.sp),
            if (controller.purposeValue.value.name == "OTHERS")
              CustomInputField(
                height: Get.height * 0.095,
                textHeading: "Enter In Brief",
                hint: 'Enter purpose',
                isCaps: false,
                letterSpacing: 1.0,
                maxLenght: 20,
                isMandatory: true,
                keyBroadType: TextInputType.name,
                formatter: const [],
                readOnly: false,
                isButton: false,
                buttonText: "Select",
                controller: controller.purposeController.value,
              ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: Row(
                children: [
                  Icon(Icons.currency_rupee_rounded,
                      color: ColorConstants.primary, size: 18),
                  SizedBox(width: 6.sp),
                  Text(
                    "Enter total loan amount",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: ColorConstants.ink),
                  ),
                  Text(
                    " *",
                    style: TextStyle(
                        color: ColorConstants.danger,
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: SliderWidget(
                division: controller.maxLoanAmount.value.toInt() -
                    controller.minLoanAmount.value.toInt(),
                min: controller.minLoanAmount.value.toInt(),
                max: controller.maxLoanAmount.value.toInt(),
                min_value: controller.minLoanAmount.value.toInt().toDouble(),
                max_value: controller.maxLoanAmount.value.toInt().toDouble(),
                sliderHeight: Get.height * 0.06,
                onChanged: (value) {
                  // print("LOAN AMOUNT ==>" + value.toString());
                  controller.currentLoanAmount.value = value;
                  controller.totalValue.value.value =
                      controller.currentLoanAmount.value +
                          (controller.currentLoanAmount.value / 100) *
                              controller.currentTenure.value;
                },
                currentValue: controller.currentLoanAmount.value,
                type: "K",
              ),
            ),
            SizedBox(height: 14.sp),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: Row(
                children: [
                  Icon(Icons.calendar_month_rounded,
                      color: ColorConstants.primary, size: 18),
                  SizedBox(width: 6.sp),
                  Text(
                    "Enter total days",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: ColorConstants.ink),
                  ),
                  Text(
                    " *",
                    style: TextStyle(
                        color: ColorConstants.danger,
                        fontWeight: FontWeight.w900,
                        fontSize: 17.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: SliderWidget(
                division:
                    controller.maxTenure.value - controller.minTenure.value,
                min: controller.minTenure.value,
                max: controller.maxTenure.value,
                min_value: controller.minTenure.value.toDouble(),
                max_value: controller.maxTenure.value.toDouble(),
                sliderHeight: Get.height * 0.06,
                onChanged: (value) {
                  controller.totalValue.value.value = 0;
                  controller.currentTenure.value = value;

                  controller.totalValue.value.value =
                      controller.currentLoanAmount.value +
                          (controller.currentLoanAmount.value / 100) *
                              controller.currentTenure.value;
                },
                currentValue: controller.currentTenure.value,
                type: "D",
              ),
            ),
            SizedBox(height: 20.sp),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.sp),
                padding: EdgeInsets.symmetric(vertical: 24.sp),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.greenSoft,
                  borderRadius: BorderRadius.circular(20.sp),
                  border: Border.all(color: const Color(0xFFE4EDE8)),
                ),
                child: SimpleCircularProgressBar(
                  animationDuration: 0,
                  size: 150,
                  progressStrokeWidth: 10,
                  backStrokeWidth: 10,
                  maxValue: controller.maxValue.value,
                  valueNotifier: controller.totalValue.value,
                  progressColors: const [ColorConstants.gold],
                  backColor: const Color(0xFFDDE7DA),
                  mergeMode: true,
                  onGetText: (double value) {
                    return Text(
                      textAlign: TextAlign.center,
                      'Total Payable\n₹${((controller.totalValue.value.value * 100).round()) * 10}',
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.greenDeep),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 8.sp),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.sp),
              padding: EdgeInsets.all(18.sp),
              decoration: BoxDecoration(
                color: ColorConstants.surfaceLight,
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(color: const Color(0xFFE4EDE8)),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.greenDeep.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 4.sp,
                          height: 16.sp,
                          decoration: BoxDecoration(
                            color: ColorConstants.gold,
                            borderRadius: BorderRadius.circular(4.sp),
                          )),
                      SizedBox(width: 8.sp),
                      Text(
                        "Loan Breakdown",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800,
                          color: ColorConstants.ink,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.sp),
                  _KfsRow(
                    label: "Principle Amount",
                    value:
                        "₹${((controller.currentLoanAmount.value) * 1000).round()}",
                  ),
                  SizedBox(height: 12.sp),
                  _KfsRow(
                    label: "Interest Per Day",
                    value:
                        "₹${((controller.currentLoanAmount.value) * 10).round()}",
                    valueColor: ColorConstants.greenDeep,
                  ),
                  SizedBox(height: 12.sp),
                  _KfsRow(
                    label: "Total Days",
                    value: "${(controller.currentTenure.value).toInt()} Days",
                  ),
                  SizedBox(height: 12.sp),
                  _KfsRow(
                    label: "Total Interest",
                    value:
                        "₹${(((controller.currentLoanAmount.value) * controller.currentTenure.value) * 10).round()}",
                    valueColor: ColorConstants.greenDeep,
                  ),
                  SizedBox(height: 14.sp),
                  const _DashedDivider(),
                  SizedBox(height: 14.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(
                        "Total repayment",
                        style: TextStyle(
                            fontSize: 15.5.sp,
                            fontWeight: FontWeight.w800,
                            color: ColorConstants.greenDeep)),
                      ),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            "₹${((controller.totalValue.value.value * 100).round()) * 10}",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w800,
                                color: ColorConstants.greenDeep),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.sp, vertical: 10.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.goldSoft,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Text(
                      "10% of principle amount will be deducted as processing fee",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.greenDeep),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.sp),
            Get.arguments ?? false
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16.sp),
                        onTap: () {
                          var days = (controller.currentTenure.value).round();
                          //    print(days);
                          prefs.setString(
                              SharedConstants.LOAN_AMOUNT,
                              ((controller.currentLoanAmount.value) * 1000)
                                  .round()
                                  .toString());
                          prefs.setString(
                              SharedConstants.TENURE, "$days DAYS");
                          if (controller.loading.value == false) {
                            saveLoanAmount(1);
                          } else {
                            Fluttertoast.showToast(msg: "Please wait!!");
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: Get.height * 0.06,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: ColorConstants.goldGradient,
                            borderRadius: BorderRadius.circular(16.sp),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstants.gold.withOpacity(0.30),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: controller.loading.value
                              ? SizedBox(
                                  height: 22.sp,
                                  width: 22.sp,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation(
                                        ColorConstants.greenDeep),
                                  ),
                                )
                              : Text(
                                  "ACCEPT",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ColorConstants.greenDeep,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 10.sp,
            )
          ]);
    });
  }

  showAlertDialog(BuildContext context, String title, String message) {
    return Get.defaultDialog(
      title: title,
      middleText: message,
      barrierDismissible: false,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.danger,
            ),
            onPressed: () {
              Get.back();
              Get.defaultDialog(
                  barrierDismissible: false,
                  title: "Alert !!",
                  middleText:
                      "By clicking the 'Yes' your application will be rejected and you will not be eligible for any loan. Do you want to proceed?",
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.success,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("No")),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.danger,
                        ),
                        onPressed: () {
                          Get.back();
                          saveLoanAmount("2");
                        },
                        child: const Text("Yes")),
                  ]);
            },
            child: const Text("No")),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.accent,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text("Change")),
        ElevatedButton(
            onPressed: () {
              Get.back();
              saveLoanAmount("1");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.success,
            ),
            child: const Text("Yes"))
      ],
    );
  }

  saveLoanAmount(var acceptedId) async {
    if (controller.purposeValue.value.name != "SELECT") {
      controller.loading.value = true;
      try {
        var result = await ApiService().postMethod(
            baseUrl: APIConstants.getBaseUrl(uri: "saveleadDetails"),
            body: {
              "profile_id":
                  prefs.getString(SharedConstants.PROFILE_ID).toString(),
              "event_name": "loan_quotation_decision",
              "purpose_id": controller.purposeValue.value.id.toString(),
              "amount": ((controller.currentLoanAmount.value) * 1000)
                  .round()
                  .toString(),
              "tenure": ((controller.currentTenure.value).round()).toString(),
              "accepted_id": acceptedId.toString()
            },
            header: APIConstants.getApiHeader(
                prefs.getString(SharedConstants.TOKEN) ?? ""));
        if (result != null) {
          // appsflyerSdk!.set
          // appsflyerSdk!.setCustomerUserId(controller.appflyer_profile_id.toString());
          //
          // appsflyerSdk!.logEvent("loan_quotation_decision", {
          //   "profile_id": prefs.getString(SharedConstants.PROFILE_ID).toString(),
          //   "accepted_id": accepted_id.toString(),
          //   "status": result['Status'].toString(),
          //   "message": result['Message'].toString(),
          // }).then((result) {
          //   // print('Event successfully logged: $result');
          // }).catchError((error) {
          //   // print('Error logging event: $error');
          // });
          if (result["Status"].toString() == "1") {
            prefs.setString(SharedConstants.PURPOSE,
                controller.purposeValue.value.name.toString());
            ShortMessage.toast(title: result['Message'].toString());
            prefs.setString(
                SharedConstants.STEP_STAGE, result['Data']['next_step'] ?? "");
            prefs.setInt(SharedConstants.STEP_COMPLETE_PERCENT,
                result['Data']['step_percentage'] ?? 0);
            Events.getNextEvent(result['Data']['next_step'].toString());
          } else if (result['Status'] == 3) {
            Get.offAllNamed(RoutesName.DashbroadScreen);
            ShortMessage.toast(title: result['Message'].toString());
          } else if (result['Status'] == 4) {
            Events.logout();
            ShortMessage.toast(title: result['Message'].toString());
          } else {
            ShortMessage.toast(title: result['Message'].toString());
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      controller.loading.value = false;
    } else {
      Fluttertoast.showToast(msg: "Please select Loan Purpose");
    }
  }
}

/// Small stat block (title over value) used inside the amount hero card.
class _SuMiniStat extends StatelessWidget {
  final String title;
  final String value;
  const _SuMiniStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.5.sp,
            fontWeight: FontWeight.w500,
            color: ColorConstants.muted,
          ),
        ),
        SizedBox(height: 3.sp),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            maxLines: 1,
            style: TextStyle(
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w800,
              color: ColorConstants.greenDeep,
            ),
          ),
        ),
      ],
    );
  }
}

/// A KFS-style breakdown row: muted label on the left, bold value on the right.
class _KfsRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _KfsRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w500,
              color: ColorConstants.muted,
            ),
          ),
        ),
        SizedBox(width: 8.sp),
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: valueColor ?? ColorConstants.ink,
            ),
          ),
        ),
      ],
    );
  }
}

/// A thin dashed horizontal divider (KFS separator look).
class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double dashWidth = 5;
        const double dashSpace = 4;
        final int dashCount =
            (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount < 0 ? 0 : dashCount,
            (_) => Container(
              width: dashWidth,
              height: 1,
              color: const Color(0xFFDDE7DA),
            ),
          ),
        );
      },
    );
  }
}
