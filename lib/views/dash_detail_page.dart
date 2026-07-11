import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashDetailController.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/custom_widgets/su_hero_card.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/views/preview_detail_page.dart';

class DashDeatailPage extends GetView<DashDetailController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppbar(title: "Loan Details", context: context),
        body: Obx(
          () => controller.loading2.value == true
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: controller.leadData.value.data != null
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(15.sp, 20.sp, 15.sp, 24.sp),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ── Hero summary card (amount + status) ──────
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20.sp),
                                  decoration: BoxDecoration(
                                    gradient: ColorConstants.brandGradient,
                                    borderRadius: BorderRadius.circular(22.sp),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorConstants.primary.withOpacity(0.28),
                                        blurRadius: 24,
                                        offset: const Offset(0, 12),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Loan Amount',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8.sp),
                                      Text(
                                        '₹ ${controller.leadData.value.data![0].loanAmount ?? "NO DATA"}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26.sp,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      SizedBox(height: 14.sp),
                                      Container(height: 1, color: Colors.white.withOpacity(0.15)),
                                      SizedBox(height: 14.sp),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SuHeroStat(
                                            title: 'Tenure',
                                            value: controller.leadData.value.data![0].tenure ?? "—",
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 8.sp),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30.sp),
                                            ),
                                            child: Text(
                                              controller.leadData.value.data![0].status ?? "NO DATA",
                                              style: TextStyle(
                                                color: _statusColor(controller.leadData.value.data![0].status ?? ""),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.sp),
                                _sectionTitle("Loan Details"),
                                SizedBox(height: 12.sp),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(18.sp),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.surfaceLight,
                                    borderRadius: BorderRadius.circular(20.sp),
                                    border: Border.all(color: ColorConstants.border),
                                    boxShadow: ColorConstants.softShadow,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildDetailRow(
                                        "Loan No",
                                        controller.leadData.value.data![0].loanNo ?? "NO DATA",
                                        context,
                                      ),
                                      buildDetailRow(
                                        "Loan Date",
                                        controller.leadData.value.data![0].disbursalDate ?? "NO DATA",
                                        context,
                                      ),
                                      buildDetailRow("Monthly Salary",
                                          controller.leadData.value.data![0].monthlySalaryAmount ?? "NO DATA", context),
                                      _accentRow(
                                        "Loan Amount",
                                        controller.leadData.value.data![0].loanAmount ?? "NO DATA",
                                        ColorConstants.primary,
                                      ),
                                      buildDetailRow(
                                          "Tenure", controller.leadData.value.data![0].tenure ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Purpose", controller.leadData.value.data![0].purpose ?? "NO DATA", context),
                                      _accentRow(
                                        "Status",
                                        controller.leadData.value.data![0].status ?? "NO DATA",
                                        _statusColor(controller.leadData.value.data![0].status ?? ""),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.sp),
                                _sectionTitle("Applicant Details"),
                                SizedBox(height: 12.sp),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(18.sp),
                                  decoration: BoxDecoration(
                                    color: ColorConstants.surfaceLight,
                                    borderRadius: BorderRadius.circular(20.sp),
                                    border: Border.all(color: ColorConstants.border),
                                    boxShadow: ColorConstants.softShadow,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildDetailRow(
                                          "Name", controller.leadData.value.data![0].firstName ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Email", controller.leadData.value.data![0].email ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Mobile", controller.leadData.value.data![0].mobile ?? "NO DATA", context),
                                      buildDetailRow(
                                          "Pancard", controller.leadData.value.data![0].pancard ?? "NO DATA", context),
                                      buildDetailRow("Current City",
                                          controller.leadData.value.data![0].mCityName ?? "NO DATA", context),
                                      buildDetailRow("Current State",
                                          controller.leadData.value.data![0].mStateName ?? "NO DATA", context),
                                    ],
                                  ),
                                ),
                              ]))
                      : Container(
                          height: Get.height * 0.7,
                          padding: EdgeInsets.all(15.sp),
                          child: Center(
                              child: Text(
                            "No Data Found",
                            style: Theme.of(context).textTheme.headlineLarge,
                          )),
                        ),
                ),
        ));
  }

  Color _statusColor(String status) {
    if (status == 'Disbursed' || status == 'Completed' || status == 'Closed') {
      return ColorConstants.success;
    }
    if (status == 'Rejected' || status == 'Settled' || status == 'Write-OFF') {
      return ColorConstants.danger;
    }
    if (status == 'Pending' || status == 'Processing' || status == 'Partially-Paid') {
      return ColorConstants.warning;
    }
    return ColorConstants.primary;
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4.sp,
          height: 18.sp,
          decoration: BoxDecoration(
            color: ColorConstants.primary,
            borderRadius: BorderRadius.circular(4.sp),
          ),
        ),
        SizedBox(width: 10.sp),
        Text(
          text,
          style: TextStyle(
            color: ColorConstants.ink,
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }

  Widget _accentRow(String label, String value, Color valueColor) {
    final bool isStatus = label == "Status";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width * 0.4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                color: ColorConstants.body,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          isStatus
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
                  decoration: BoxDecoration(
                    color: valueColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30.sp),
                    border: Border.all(color: valueColor.withOpacity(0.25)),
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: valueColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : Expanded(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: valueColor,
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
