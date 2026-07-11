import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/repayment_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/views/preview_detail_page.dart';

class RepaymentHistoryPage extends GetView<RepaymentHistoryController> {
  const RepaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.scaffoldLight,
        appBar: CustomAppbar(context: context, isEnableLogout: false, title: "Repayment History"),
        body: SafeArea(
          top: true,
          child: Obx(
            () => controller.loading.value == true
                ? const Center(child: CircularProgressIndicator(color: ColorConstants.primary))
                : controller.collection.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.sp, 16.sp, 20.sp, 8.sp),
                            child: Text(
                              "Payments",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: ColorConstants.ink,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.fromLTRB(16.sp, 4.sp, 16.sp, 110.sp),
                                itemCount: controller.collection.length,
                                itemBuilder: (context, index) {
                                  return _buildPaymentCard(controller.collection[index], context);
                                }),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.sp, 16.sp, 20.sp, 8.sp),
                            child: Text(
                              "Payments",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                color: ColorConstants.ink,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "No Data Found",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.muted,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        ));
  }

  Widget _buildPaymentCard(dynamic item, BuildContext context) {
    final String statusName = item.status_name ?? "NO DATA";
    final Color statusTint = _statusTint(statusName);
    return Container(
      margin: EdgeInsets.only(bottom: 12.sp),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(20.sp),
        border: Border.all(color: const Color(0xFFEDF3F0)),
        boxShadow: ColorConstants.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left square icon badge (success-tinted receipt icon)
              Container(
                width: 46.sp,
                height: 46.sp,
                decoration: BoxDecoration(
                  color: ColorConstants.success.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14.sp),
                ),
                child: Icon(
                  Icons.receipt_long_rounded,
                  color: ColorConstants.success,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.sp),
              // Body: title + date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Repayment • #${item.loanNo ?? "NO DATA"}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.ink,
                      ),
                    ),
                    SizedBox(height: 3.sp),
                    Text(
                      item.dateOfRecived ?? "----/--/--",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.muted,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.sp),
              // Right: amount + small status text
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${item.receivedAmount ?? "NO DATA"}",
                    style: TextStyle(
                      color: ColorConstants.success,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 3.sp),
                  Text(
                    statusName,
                    style: TextStyle(
                      color: statusTint,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.sp),
          Divider(thickness: 1.sp, height: 1.sp, color: const Color(0xFFEDF3F0)),
          SizedBox(height: 10.sp),
          buildDetailRow("Discount", item.discount ?? "NO DATA", context),
          buildDetailRow(
              "Verification Status", (item.paymentVerification ?? "NO DATA"), context),
        ],
      ),
    );
  }

  Color _statusTint(String status) {
    final String s = status.toLowerCase();
    if (s.contains("paid") || s.contains("close") || s.contains("success") || s.contains("complete")) {
      return ColorConstants.success;
    } else if (s.contains("overdue") || s.contains("fail") || s.contains("reject") || s.contains("default")) {
      return ColorConstants.danger;
    } else {
      return ColorConstants.warning;
    }
  }
}
