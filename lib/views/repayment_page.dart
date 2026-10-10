import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/shared_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/homeController.dart';
import '../controller/internet_connectivity_controller.dart';
import '../custom_widgets/custom_toast_snack_bar.dart';
import '../routes/routes_names.dart';
import '../utils/color_constants.dart';
import 'repay_page.dart';

class RepaymentPage extends StatelessWidget {
  RepaymentPage({super.key});

  HomeController homeController = Get.put(HomeController());
  DashbroadController dashbroadController = Get.put(DashbroadController());

  ConnectionManagerController connectionManagerController = Get.put(
    ConnectionManagerController(),
  );
  var paymentType = [1, 2];

  @override
  Widget build(BuildContext context) {
    final String outAmt = prefs.getString(SharedConstants.OUT_AMT) ?? "NO DATA";
    final String loanNo = prefs.getString(SharedConstants.LOAN_NO) ?? "--";
    final String repayDate = prefs.getString(SharedConstants.REPAYMENT_DATE) ?? "--";

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldLight,
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------------------------------------------------------
              // Page header — back button (white circle) + title
              // ---------------------------------------------------------------
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.sp),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (Get.key.currentState?.canPop() ?? false) {
                          Get.back();
                        } else {
                          Get.offAllNamed(RoutesName.DashbroadScreen);
                        }
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: ColorConstants.surfaceLight,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE4EDE8)),
                          boxShadow: ColorConstants.softShadow,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: ColorConstants.ink,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    Text(
                      "Repay Loan",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: ColorConstants.ink,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.sp),

              // ---------------------------------------------------------------
              // Pay hero card — deep-green gradient
              // ---------------------------------------------------------------
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 26.sp),
                decoration: BoxDecoration(
                  gradient: ColorConstants.loanCardGradient,
                  borderRadius: BorderRadius.circular(22.sp),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.greenDeep.withOpacity(0.28),
                      blurRadius: 22,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total payable • Loan #$loanNo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.82),
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        outAmt,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -1,
                          height: 1.05,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.sp),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 7.sp),
                      decoration: BoxDecoration(
                        color: ColorConstants.goldText.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(color: ColorConstants.goldText.withOpacity(0.35)),
                      ),
                      child: Text(
                        "Due $repayDate • Repay early & save interest",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.goldText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22.sp),

              // ---------------------------------------------------------------
              // Payment method card (presentational only)
              // ---------------------------------------------------------------
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: ColorConstants.surfaceLight,
                  borderRadius: BorderRadius.circular(20.sp),
                  border: Border.all(color: const Color(0xFFE4EDE8)),
                  boxShadow: ColorConstants.softShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment method",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        color: ColorConstants.ink,
                      ),
                    ),
                    SizedBox(height: 14.sp),
                    buildMethodRow(
                      icon: Icons.account_balance_wallet_rounded,
                      badgeBg: ColorConstants.greenSoft,
                      iconColor: ColorConstants.green2,
                      label: "UPI",
                      subtitle: "Google Pay, PhonePe, Paytm & more",
                      selected: true,
                    ),
                    SizedBox(height: 12.sp),
                    buildMethodRow(
                      icon: Icons.account_balance_rounded,
                      badgeBg: ColorConstants.goldSoft,
                      iconColor: ColorConstants.gold,
                      label: "Net Banking",
                      subtitle: "All major banks supported",
                      selected: false,
                    ),
                    SizedBox(height: 12.sp),
                    buildMethodRow(
                      icon: Icons.credit_card_rounded,
                      badgeBg: ColorConstants.greenSoft,
                      iconColor: ColorConstants.green2,
                      label: "Debit Card",
                      subtitle: "Visa, RuPay, Mastercard",
                      selected: false,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22.sp),

              // ---------------------------------------------------------------
              // Repayment details card
              // ---------------------------------------------------------------
              Padding(
                padding: EdgeInsets.only(left: 4.sp, bottom: 12.sp),
                child: Text(
                  'Repayment Details',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: ColorConstants.ink,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: ColorConstants.surfaceLight,
                  borderRadius: BorderRadius.circular(20.sp),
                  border: Border.all(color: const Color(0xFFE4EDE8)),
                  boxShadow: ColorConstants.softShadow,
                ),
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetailRow("Loan Number", prefs.getString(SharedConstants.LOAN_NO) ?? "NO DATA",
                          ColorConstants.body, context),
                      buildDetailRow("Disbursed Amount", prefs.getString(SharedConstants.DIS_AMT) ?? "NO DATA",
                          ColorConstants.body, context),
                      buildDetailRow("Repayment Amount", prefs.getString(SharedConstants.REPAYMENT_AMT) ?? "NO DATA",
                          ColorConstants.body, context),
                      buildDetailRow("Disbursed Date", prefs.getString(SharedConstants.DIS_DATE) ?? "NO DATA",
                          ColorConstants.body, context),
                      buildDetailRow("Repayment Date", prefs.getString(SharedConstants.REPAYMENT_DATE) ?? "NO DATA",
                          ColorConstants.body, context),
                      buildDetailRow("Loan Status", prefs.getString(SharedConstants.LOAN_STATUS) ?? "NO DATA",
                          ColorConstants.body, context),
                      Divider(
                        thickness: 1.sp,
                        color: const Color(0xFFEDF3F0),
                      ),
                      buildDetailRow("Total Due", prefs.getString(SharedConstants.OUT_AMT) ?? "NO DATA",
                          ColorConstants.greenDeep, context),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 22.sp),

              // ---------------------------------------------------------------
              // Gold CTA — EXISTING Obx repay button / onPressed preserved
              // ---------------------------------------------------------------
              Obx(() {
                final bool loading = homeController.loadingOnRepay.value;
                return GestureDetector(
                  onTap: () {
                    if (connectionManagerController.connectivityResult == ConnectivityResult.none) {
                      ShortMessage.toast(title: "Check your internet connection");
                    } else {
                      if ((prefs.getString(SharedConstants.OUT_AMT) ?? "0.0") == "0.0") {
                        ShortMessage.toast(title: "No outstanding amount to repay");
                      } else {
                        if (homeController.loadingOnRepay.value == false) {
                          Get.to(() => const RepayPage());

                          // Get.defaultDialog(
                          //   title: "Select Payment Method",
                          //   middleText:
                          //       "Please select payment method to continue",
                          //   actions: [
                          //     if (paymentType.contains(1))
                          //       SizedBox(
                          //         width: Get.width * 0.25,
                          //         height: 28.sp,
                          //         child: ElevatedButton(
                          //             style: ElevatedButton.styleFrom(
                          //               backgroundColor: Color(
                          //                   ColorConstants.secondaryColor),
                          //               minimumSize:
                          //                   Size(double.infinity, 50),
                          //             ),
                          //             onPressed: () {
                          //               Get.back();
                          //               homeController.generateHashValue(
                          //                   prefs.getString(
                          //                       SharedConstants.LOAN_LEAD_ID),
                          //                   prefs.getString(
                          //                       SharedConstants.OUT_AMT));
                          //             },
                          //             child: Text("PayU")),
                          //       ),
                          //     if (paymentType.contains(2))
                          //       SizedBox(
                          //         width: Get.width * 0.25,
                          //         height: 28.sp,
                          //         child: ElevatedButton(
                          //             style: ElevatedButton.styleFrom(
                          //               backgroundColor: Color(
                          //                   ColorConstants.secondaryColor),
                          //               minimumSize:
                          //                   Size(double.infinity, 50),
                          //             ),
                          //             onPressed: () {
                          //               // Get.back();
                          //               homeController.generateOrderId(
                          //                   prefs.getString(
                          //                       SharedConstants.LOAN_LEAD_ID),
                          //                   prefs.getString(
                          //                       SharedConstants.OUT_AMT));
                          //             },
                          //             child: Text("RazorPay")),
                          //       ),
                          //   ],
                          // );
                          // homeController.generateOrderId(
                          //     prefs.getString(SharedConstants.LOAN_LEAD_ID), prefs.getString(SharedConstants.OUT_AMT));
                        } else {
                          ShortMessage.toast(title: "Getting Order Id");
                        }
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: ColorConstants.goldGradient,
                      borderRadius: BorderRadius.circular(16.sp),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.gold.withOpacity(0.32),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: loading
                          ? SpinKitThreeBounce(
                              color: ColorConstants.greenDeep,
                              size: 23,
                            )
                          : Text(
                              "Pay ₹$outAmt",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorConstants.greenDeep,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 12.sp),

              // Secure-note line
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_rounded,
                    size: 16,
                    color: ColorConstants.muted,
                  ),
                  SizedBox(width: 6.sp),
                  Flexible(
                    child: Text(
                      "100% secure payment via RBI-authorised gateway",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.muted,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Presentational payment-method row (VISUAL ONLY, no switching logic).
  Widget buildMethodRow({
    required IconData icon,
    required Color badgeBg,
    required Color iconColor,
    required String label,
    required String subtitle,
    required bool selected,
  }) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: selected ? ColorConstants.greenSoft.withOpacity(0.5) : ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(14.sp),
        border: Border.all(
          color: selected ? ColorConstants.green2.withOpacity(0.35) : const Color(0xFFEDF3F0),
          width: selected ? 1.4 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 53,
            height: 53,
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(11.sp),
            ),
            child: Icon(icon, size: 23, color: iconColor),
          ),
          SizedBox(width: 12.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.ink,
                  ),
                ),
                SizedBox(height: 2.sp),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.muted,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.sp),
          Container(
            width: 20.sp,
            height: 20.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? ColorConstants.green2 : ColorConstants.muted.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 10.sp,
                      height: 10.sp,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.green2,
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value, Color color, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: ColorConstants.muted, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 10.sp),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: color,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
