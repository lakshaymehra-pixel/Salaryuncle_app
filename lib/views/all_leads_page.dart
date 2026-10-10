import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../controller/dashbroadController.dart';
import '../custom_widgets/custom_button.dart';
import '../routes/routes_names.dart';
import '../utils/color_constants.dart';

class AllLeadsPage extends StatelessWidget {
  AllLeadsPage({super.key});

  DashbroadController controller = Get.put(DashbroadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldLight,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Obx(() {
          return RefreshIndicator(
            onRefresh: () {
              return controller.number != "9999999999" ? controller.getLeadDetails() : null;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 18.sp),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Text(
                      'My Loans',
                      style: TextStyle(
                        color: ColorConstants.ink,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  // Summary strip: two white boxes computed from allLead.
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Row(
                      children: [
                        Expanded(
                          child: _summaryBox(
                            label: 'Total loans',
                            value: '${controller.allLead.length}',
                            icon: Icons.account_balance_wallet_rounded,
                            tint: ColorConstants.greenSoft,
                            iconColor: ColorConstants.greenDeep,
                          ),
                        ),
                        SizedBox(width: 12.sp),
                        Expanded(
                          child: _summaryBox(
                            label: 'Loans completed',
                            value: '${controller.allLead.where((e) => (e.status == 'Disbursed' || e.status == 'Completed' || e.status == 'Closed')).length}',
                            icon: Icons.verified_rounded,
                            tint: ColorConstants.goldSoft,
                            iconColor: ColorConstants.gold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  Skeletonizer(
                    enabled: controller.loadingOnDashboard.value,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.allLead.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.sp),
                            child: _loanView(
                              context: context,
                              appNo: controller.allLead[index].application_no ?? '#0000000000',
                              status: controller.allLead[index].status ?? '',
                              // status: 'Rejected',
                              amount: controller.allLead[index].loanAmount ?? '0',
                              applyDate: controller.allLead[index].leadEntryDate ?? '0000-00-00',
                              name: (prefs.getString(SharedConstants.NAME) ?? "User Name"),
                              lead_id: controller.allLead[index].leadId.toString(),
                            ),
                          );
                        }),
                  ),
                  /**Column Contains Card for Banner & Grid view for Leads */

                  SizedBox(height: 90),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // Presentational summary box for the top strip.
  Widget _summaryBox({
    required String label,
    required String value,
    required IconData icon,
    required Color tint,
    required Color iconColor,
  }) {
    return Container(
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(20.sp),
        border: Border.all(color: ColorConstants.border),
        boxShadow: ColorConstants.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 44,
            width: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(11.sp),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          SizedBox(height: 12.sp),
          Text(
            value,
            style: TextStyle(
              color: ColorConstants.ink,
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 3.sp),
          Text(
            label,
            style: TextStyle(
              color: ColorConstants.muted,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Resolves the mockup status color from the existing status logic.
  Color _statusColor(String status) {
    return (status == 'Disbursed' || status == 'Completed' || status == 'Closed')
        ? ColorConstants.success
        : (status == 'Rejected' || status == 'Settled' || status == 'Write-OFF')
            ? ColorConstants.danger
            : (status == "Pending" || status == "Processing" || status == "Partially-Paid")
                ? ColorConstants.warning
                : ColorConstants.primary;
  }

  Widget _loanView(
      {required String appNo,
      required String status,
      required String name,
      required String amount,
      required String lead_id,
      required BuildContext context,
      required String applyDate}) {
    final Color statusColor = _statusColor(status);
    // Wallet for active/disbursed loans, clock for pending/processing states.
    final bool isPending = status == "Pending" || status == "Processing" || status == "Partially-Paid";
    final IconData badgeIcon = isPending ? Icons.access_time_rounded : Icons.account_balance_wallet_rounded;
    return InkWell(
      borderRadius: BorderRadius.circular(20.sp),
      onTap: () {
        Get.toNamed(RoutesName.DashDetailScreen, arguments: lead_id);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14.sp),
        padding: EdgeInsets.all(14.sp),
        decoration: BoxDecoration(
          color: ColorConstants.surfaceLight,
          borderRadius: BorderRadius.circular(20.sp),
          border: Border.all(color: ColorConstants.border),
          boxShadow: ColorConstants.softShadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left square icon badge, tinted by status.
            Container(
              height: 64,
              width: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(13.sp),
              ),
              child: Icon(badgeIcon, color: statusColor, size: 25),
            ),
            SizedBox(width: 12.sp),
            // Body: loan number + apply date • status.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loan #$appNo',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorConstants.ink,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.sp),
                  Text(
                    '${DateFormat('dd MMM yyyy').format(DateTime.parse(applyDate))} • $status',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: ColorConstants.muted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.sp),
            // Right: amount + status chip.
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '₹$amount',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: ColorConstants.ink,
                  ),
                ),
                SizedBox(height: 6.sp),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.sp, vertical: 4.sp),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(99.sp),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
