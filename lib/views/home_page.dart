import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tejas_loan/controller/homeController.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/controller/internet_connectivity_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_profile_pic_view.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/events.dart';
import 'package:tejas_loan/utils/shared_constants.dart';
import 'package:tejas_loan/views/repayment_page.dart';

import '../routes/routes_names.dart';
import '../utils/color_constants.dart';

class HomePage extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  ConnectionManagerController connectionManagerController = Get.put(
    ConnectionManagerController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: ColorConstants.scaffoldLight,
        body: RefreshIndicator(
          onRefresh: () async {
            if (homeController.number != "9999999999") {
              await homeController.getDashboard();
              await homeController.getLeadDetails();
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Skeletonizer(
              enabled: homeController.loading.value,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.sp, 6.sp, 16.sp, 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _topBar(context),
                      SizedBox(height: 16.sp),
                      _loanCard(context),
                      _repayCard(context),
                      _eligibleStrip(context),
                      SizedBox(height: 20.sp),
                      Text('Quick actions', style: TextStyle(color: ColorConstants.ink, fontSize: 17.sp, fontWeight: FontWeight.w700)),
                      SizedBox(height: 14.sp),
                      _quickActions(context),
                      _tip(context),
                      if (homeController.allLead.isNotEmpty) ...[
                        SizedBox(height: 22.sp),
                        Text('Recent Loans', style: TextStyle(color: ColorConstants.ink, fontSize: 17.sp, fontWeight: FontWeight.w700)),
                        SizedBox(height: 14.sp),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeController.allLead.length < 2 ? homeController.allLead.length : 2,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(RoutesName.DashDetailScreen,
                                    arguments: homeController.allLead[index].leadId.toString());
                              },
                              child: _recentLoan(
                                context: context,
                                appliedDate: homeController.allLead[index].leadEntryDate.toString(),
                                status: homeController.allLead[index].status ?? '',
                                amount: homeController.allLead[index].loanAmount ?? '0',
                                tenure: homeController.allLead[index].tenure ?? '0',
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // ── Top bar ──────────────────────────────────────────────────────────────
  Widget _topBar(BuildContext context) {
    final rawName = (prefs.getString(SharedConstants.NAME) ?? 'User');
    final name = rawName.trim().isEmpty
        ? 'User'
        : rawName.trim().split(' ').map((w) => w.isEmpty ? w : w.capitalizeFirst!).join(' ');
    return Row(
      children: [
        const CustomProfilePicView(),
        SizedBox(width: 10.sp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Namaste 👋', style: TextStyle(color: ColorConstants.muted, fontSize: 12.sp)),
              SizedBox(height: 2.sp),
              Text(name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: ColorConstants.ink, fontSize: 15.sp, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        Container(
          height: 42.sp,
          width: 42.sp,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorConstants.surfaceLight,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: ColorConstants.greenDeep.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.notifications_none_rounded, color: ColorConstants.greenDeep, size: 20.sp),
              Positioned(
                top: 10.sp,
                right: 11.sp,
                child: Container(
                  height: 8.sp,
                  width: 8.sp,
                  decoration: BoxDecoration(
                    color: ColorConstants.gold,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Active loan card (dark green) ────────────────────────────────────────
  Widget _loanCard(BuildContext context) {
    final bool hasOutstanding = _hasOutstanding();
    final String amount = hasOutstanding
        ? "₹${prefs.getString(SharedConstants.OUT_AMT) ?? "0"}"
        : "₹${prefs.getString(SharedConstants.LOAN_AMOUNT) ?? "1,00,000"}";
    final bool completed = prefs.getString(SharedConstants.STEP_STAGE) == Events.COMPLETED;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        gradient: ColorConstants.loanCardGradient,
        borderRadius: BorderRadius.circular(22.sp),
        boxShadow: [BoxShadow(color: ColorConstants.greenDeep.withOpacity(0.30), blurRadius: 26, offset: const Offset(0, 12))],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -14.sp,
            top: -18.sp,
            child: Container(
              width: 90.sp,
              height: 90.sp,
              decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF1C6A50).withOpacity(0.5)),
              alignment: Alignment.center,
              child: Text('₹', style: TextStyle(color: ColorConstants.goldText.withOpacity(0.85), fontSize: 30.sp, fontWeight: FontWeight.w800)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(hasOutstanding ? 'Active Loan' : 'Available Loan',
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13.sp)),
                  SizedBox(width: 8.sp),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.sp, vertical: 3.sp),
                    decoration: BoxDecoration(
                      color: ColorConstants.gold.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: ColorConstants.gold.withOpacity(0.45)),
                    ),
                    child: Text(hasOutstanding ? 'RUNNING' : 'READY',
                        style: TextStyle(color: ColorConstants.goldText, fontSize: 10.sp, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
                  ),
                ],
              ),
              SizedBox(height: 10.sp),
              Text(amount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 32.sp, fontWeight: FontWeight.w800, letterSpacing: -1)),
              SizedBox(height: 14.sp),
              if (completed)
                Container(
                  padding: EdgeInsets.only(top: 14.sp),
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.white.withOpacity(0.14)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _loanMeta('Loan Amount', "₹${prefs.getString(SharedConstants.LOAN_AMOUNT) ?? "-"}", false),
                      _loanMeta('Status', 'Active', true),
                    ],
                  ),
                )
              else
                GestureDetector(
                  onTap: () {
                    if (connectionManagerController.connectivityResult == ConnectivityResult.none) {
                      ShortMessage.toast(title: "Check your internet connection");
                    } else {
                      Events.getNextEvent(prefs.getString(SharedConstants.STEP_STAGE) ?? "");
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 13.sp),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(gradient: ColorConstants.goldGradient, borderRadius: BorderRadius.circular(14.sp)),
                    child: homeController.loadingOnContinue.value
                        ? SizedBox(height: 20.sp, width: 20.sp, child: CircularProgressIndicator(strokeWidth: 2.4, valueColor: AlwaysStoppedAnimation(ColorConstants.greenDeep)))
                        : Text(
                            prefs.getString(SharedConstants.USER_TYPE).toString().contains("REPEAT") &&
                                    prefs.getString(SharedConstants.STEP_STAGE) == Events.REGISTER_NOW
                                ? 'Apply Re-Loan'
                                : 'Complete Your Application',
                            style: TextStyle(color: ColorConstants.greenDeep, fontSize: 14.5.sp, fontWeight: FontWeight.w800)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _loanMeta(String k, String v, bool gold) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(k, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11.5.sp)),
        SizedBox(height: 3.sp),
        Text(v, style: TextStyle(color: gold ? ColorConstants.goldText : Colors.white, fontSize: 14.5.sp, fontWeight: FontWeight.w700)),
      ],
    );
  }

  // ── Repayment card ───────────────────────────────────────────────────────
  Widget _repayCard(BuildContext context) {
    if (!_hasOutstanding()) return const SizedBox.shrink();
    final String due = "₹${prefs.getString(SharedConstants.OUT_AMT) ?? "0"}";
    return Container(
      margin: EdgeInsets.only(top: 16.sp),
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(22.sp),
        border: Border.all(color: const Color(0xFFE4EDE8)),
        boxShadow: [BoxShadow(color: ColorConstants.greenDeep.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Repayment', style: TextStyle(color: ColorConstants.ink, fontSize: 14.sp, fontWeight: FontWeight.w700)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
                decoration: BoxDecoration(color: const Color(0xFFFBEAE8), borderRadius: BorderRadius.circular(99)),
                child: Text('View details', style: TextStyle(color: ColorConstants.danger, fontSize: 11.sp, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          SizedBox(height: 12.sp),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(due, style: TextStyle(color: ColorConstants.ink, fontSize: 26.sp, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                    SizedBox(height: 2.sp),
                    Text('Outstanding amount till due date', style: TextStyle(color: ColorConstants.muted, fontSize: 11.5.sp, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(width: 10.sp),
              GestureDetector(
                onTap: () => Get.to(RepaymentPage()),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 12.sp),
                  decoration: BoxDecoration(
                    gradient: ColorConstants.goldGradient,
                    borderRadius: BorderRadius.circular(14.sp),
                    boxShadow: [BoxShadow(color: ColorConstants.gold.withOpacity(0.35), blurRadius: 14, offset: const Offset(0, 6))],
                  ),
                  child: Text('Repay Now', style: TextStyle(color: ColorConstants.greenDeep, fontSize: 13.5.sp, fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Eligibility strip ────────────────────────────────────────────────────
  Widget _eligibleStrip(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (prefs.getString(SharedConstants.STEP_STAGE) != Events.COMPLETED) {
          Events.getNextEvent(prefs.getString(SharedConstants.STEP_STAGE) ?? "");
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 16.sp),
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [ColorConstants.goldSoft, Colors.white], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(20.sp),
          border: Border.all(color: const Color(0xFFEFDFAE)),
        ),
        child: Row(
          children: [
            Container(
              height: 40.sp,
              width: 40.sp,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorConstants.gold, shape: BoxShape.circle, boxShadow: [BoxShadow(color: ColorConstants.gold.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))]),
              child: Icon(Icons.bolt_rounded, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 12.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("You're eligible for ₹${prefs.getString(SharedConstants.LOAN_AMOUNT) ?? "1,00,000"}",
                      style: TextStyle(color: ColorConstants.ink, fontSize: 13.5.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 2.sp),
                  Text('Repay on time & unlock a higher limit', style: TextStyle(color: ColorConstants.muted, fontSize: 12.sp)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: ColorConstants.gold, size: 22.sp),
          ],
        ),
      ),
    );
  }

  // ── Quick actions ────────────────────────────────────────────────────────
  Widget _quickActions(BuildContext context) {
    return Row(
      children: [
        _action(Icons.add_box_outlined, 'New Loan', () {
          if (prefs.getString(SharedConstants.STEP_STAGE) != Events.COMPLETED) {
            Events.getNextEvent(prefs.getString(SharedConstants.STEP_STAGE) ?? "");
          } else {
            ShortMessage.toast(title: "Application Already Completed");
          }
        }),
        SizedBox(width: 12.sp),
        _action(Icons.history_rounded, 'History', () => _jumpTab(1)),
        SizedBox(width: 12.sp),
        _action(Icons.description_outlined, 'Status', () => _jumpTab(2)),
        SizedBox(width: 12.sp),
        _action(Icons.headset_mic_rounded, 'Support', () => _jumpTab(3)),
      ],
    );
  }

  Widget _action(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 4.sp),
          decoration: BoxDecoration(
            color: ColorConstants.surfaceLight,
            borderRadius: BorderRadius.circular(18.sp),
            boxShadow: [BoxShadow(color: ColorConstants.greenDeep.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Column(
            children: [
              Container(
                height: 40.sp,
                width: 40.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: ColorConstants.greenSoft, shape: BoxShape.circle),
                child: Icon(icon, color: ColorConstants.greenDeep, size: 20.sp),
              ),
              SizedBox(height: 8.sp),
              Text(label, style: TextStyle(color: ColorConstants.ink, fontSize: 11.5.sp, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  void _jumpTab(int index) {
    try {
      Get.find<DashbroadController>().onItemTapped(index);
    } catch (_) {}
  }

  // ── Tip ──────────────────────────────────────────────────────────────────
  Widget _tip(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.sp),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [BoxShadow(color: ColorConstants.greenDeep.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40.sp,
            width: 40.sp,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: ColorConstants.greenSoft, shape: BoxShape.circle),
            child: Text('💡', style: TextStyle(fontSize: 18.sp)),
          ),
          SizedBox(width: 12.sp),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: const Color(0xFF3A4A42), fontSize: 13.sp, height: 1.5, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(text: 'Salary Uncle Tip: ', style: TextStyle(color: ColorConstants.ink, fontWeight: FontWeight.w800)),
                  const TextSpan(text: 'Repay early and save on interest — early repayment also boosts your next loan limit!'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Recent loan card ─────────────────────────────────────────────────────
  Widget _recentLoan(
      {required String appliedDate, required String status, required String amount, required String tenure, required BuildContext context}) {
    final Color statusColor = (status == 'Disbursed' || status == 'Completed' || status == 'Closed')
        ? ColorConstants.success
        : (status == 'Rejected' || status == 'Settled' || status == 'Write-OFF')
            ? ColorConstants.danger
            : (status == "Pending" || status == "Processing" || status == "Partially-Paid")
                ? ColorConstants.warning
                : ColorConstants.primary;
    return Container(
      margin: EdgeInsets.only(bottom: 14.sp),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [BoxShadow(color: ColorConstants.greenDeep.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 42.sp,
                    width: 42.sp,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: ColorConstants.greenSoft, borderRadius: BorderRadius.circular(12.sp)),
                    child: Icon(Icons.account_balance_wallet_rounded, color: ColorConstants.greenDeep, size: 22.sp),
                  ),
                  SizedBox(width: 12.sp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Salary Loan', style: TextStyle(color: ColorConstants.ink, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                        SizedBox(height: 2.sp),
                        Text('Applied ${_fmtDate(appliedDate)}', style: TextStyle(color: ColorConstants.muted, fontSize: 11.5.sp, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
              decoration: BoxDecoration(color: statusColor.withOpacity(0.12), borderRadius: BorderRadius.circular(20.sp)),
              child: Text(status, style: TextStyle(color: statusColor, fontSize: 11.sp, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 12.sp), child: Divider(color: ColorConstants.border, height: 1)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amount', style: TextStyle(color: ColorConstants.muted, fontSize: 11.5.sp, fontWeight: FontWeight.w500)),
                SizedBox(height: 2.sp),
                Text('₹ $amount', style: TextStyle(color: ColorConstants.primary, fontSize: 15.sp, fontWeight: FontWeight.w800)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Duration', style: TextStyle(color: ColorConstants.muted, fontSize: 11.5.sp, fontWeight: FontWeight.w500)),
                SizedBox(height: 2.sp),
                Text('$tenure Days', style: TextStyle(color: ColorConstants.ink, fontSize: 15.sp, fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  bool _hasOutstanding() {
    final o = prefs.getString(SharedConstants.OUT_AMT);
    return o != null && o != "0" && o != "null" && o.isNotEmpty;
  }

  String _fmtDate(String raw) {
    try {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(raw));
    } catch (_) {
      return raw;
    }
  }
}
