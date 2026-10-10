import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../utils/color_constants.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';

/// Profile tab — mockup style. Shows the user's identity, KYC badge, and
/// grouped settings/legal menu rows, plus logout. All data comes from prefs;
/// logout uses the existing Events.logout(). No new business logic.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final rawName = (prefs.getString(SharedConstants.NAME) ?? 'User');
    final name = rawName.trim().isEmpty
        ? 'User'
        : rawName.trim().split(' ').map((w) => w.isEmpty ? w : w.capitalizeFirst!).join(' ');
    final mobile = prefs.getString(SharedConstants.MOBILE) ?? '';
    final email = prefs.getString(SharedConstants.EMAIL) ?? '';
    final maskedMobile = mobile.length == 10 ? '+91 ${mobile.substring(0, 2)}XXXXXX${mobile.substring(8)}' : '+91 $mobile';

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldLight,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(18.sp, 10.sp, 18.sp, 90),
          child: Column(
            children: [
              // ── Profile head ──
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: ColorConstants.loanCardGradient,
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorConstants.goldText, width: 3),
                      boxShadow: [BoxShadow(color: ColorConstants.greenDeep.withOpacity(0.25), blurRadius: 24, offset: const Offset(0, 8))],
                    ),
                    child: Icon(Icons.person_rounded, color: ColorConstants.goldText, size: 44),
                  ),
                  SizedBox(height: 12.sp),
                  Text(name, style: TextStyle(color: ColorConstants.ink, fontSize: 19.sp, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4.sp),
                  Text(
                    email.isNotEmpty ? '$maskedMobile • $email' : maskedMobile,
                    style: TextStyle(color: ColorConstants.muted, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.sp),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 5.sp),
                    decoration: BoxDecoration(color: ColorConstants.greenSoft, borderRadius: BorderRadius.circular(99)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified_rounded, color: ColorConstants.success, size: 16),
                        SizedBox(width: 5.sp),
                        Text('KYC Verified', style: TextStyle(color: ColorConstants.success, fontSize: 11.sp, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.sp),
              // ── Account group ──
              _menuGroup([
                _MenuData(Icons.person_outline_rounded, 'Personal Details', null),
                _MenuData(Icons.account_balance_outlined, 'Bank Account & eMandate', null),
                _MenuData(Icons.description_outlined, 'Documents & KYC', null),
                _MenuData(Icons.bar_chart_rounded, 'Credit Limit', null),
              ]),
              SizedBox(height: 14.sp),
              // ── Settings / legal group ──
              _menuGroup([
                _MenuData(Icons.notifications_none_rounded, 'Notifications', null),
                _MenuData(Icons.help_outline_rounded, 'Help & Support', null),
                _MenuData(Icons.gavel_rounded, 'Grievance Redressal (RBI)', null),
                _MenuData(Icons.lock_outline_rounded, 'Privacy Policy & Terms', () async {
                  await launchUrl(Uri.parse(SharedConstants.Privacy_Policy_Url), mode: LaunchMode.inAppWebView);
                }),
              ]),
              SizedBox(height: 14.sp),
              // ── Logout ──
              _menuGroup([
                _MenuData(Icons.logout_rounded, 'Logout', () => _confirmLogout(context), danger: true),
              ]),
              SizedBox(height: 16.sp),
              Text(
                '${SharedConstants.Brand_Name} • v1.1.0\nNBFC: ${SharedConstants.Company_Name}',
                textAlign: TextAlign.center,
                style: TextStyle(color: ColorConstants.muted, fontSize: 10.5.sp, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuGroup(List<_MenuData> items) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(20.sp),
        border: Border.all(color: const Color(0xFFEDF3F0)),
        boxShadow: [BoxShadow(color: ColorConstants.greenDeep.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final it = items[i];
          final bool last = i == items.length - 1;
          return InkWell(
            onTap: it.onTap,
            borderRadius: BorderRadius.circular(20.sp),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
              decoration: BoxDecoration(
                border: last ? null : const Border(bottom: BorderSide(color: Color(0xFFF1F5F3))),
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: it.danger ? const Color(0xFFFBEAE8) : ColorConstants.greenSoft,
                      borderRadius: BorderRadius.circular(12.sp),
                    ),
                    child: Icon(it.icon, color: it.danger ? ColorConstants.danger : ColorConstants.greenDeep, size: 21),
                  ),
                  SizedBox(width: 13.sp),
                  Expanded(
                    child: Text(it.label,
                        style: TextStyle(
                            color: it.danger ? ColorConstants.danger : ColorConstants.ink,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                  Icon(Icons.chevron_right_rounded, color: const Color(0xFFB9C6C0), size: 21),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.sp)),
        title: Text('Logout?', style: TextStyle(color: ColorConstants.ink, fontWeight: FontWeight.w800)),
        content: Text('Are you sure you want to logout?', style: TextStyle(color: ColorConstants.body)),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel', style: TextStyle(color: ColorConstants.muted))),
          TextButton(
            onPressed: () {
              Get.back();
              Events.logout();
            },
            child: Text('Logout', style: TextStyle(color: ColorConstants.danger, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _MenuData {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool danger;
  _MenuData(this.icon, this.label, this.onTap, {this.danger = false});
}
