import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/color_constants.dart';

/// Reference-style loan hero card for the Home page.
///
/// White card with: a titled header (logo mark + "Salary Loan" + a "Details"
/// link), a big loan amount with a pill "Borrow" button, a daily-interest note,
/// and a 3-step borrowing-process tracker (Certification → Evaluation →
/// Application). Fully presentational — all values + the tap callback are
/// passed in, so it holds no business logic. Uses the SalaryUncle green theme.
class SuLoanHero extends StatelessWidget {
  final String title;
  final String amountLabel;
  final String amount;
  final String interestNote;
  final String actionText;
  final bool loading;
  final VoidCallback? onAction;
  final VoidCallback? onDetails;

  /// Current borrowing-process step (0..2): 0 Certification, 1 Evaluation, 2 Application.
  final int currentStep;

  const SuLoanHero({
    super.key,
    this.title = 'Salary Loan',
    this.amountLabel = 'Loan amount (₹)',
    required this.amount,
    this.interestNote = 'Daily interest rate 0.025%',
    this.actionText = 'Borrow',
    this.loading = false,
    this.onAction,
    this.onDetails,
    required this.currentStep,
  });

  static const _steps = ['Certification', 'Evaluation', 'Application'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(22.sp),
        boxShadow: ColorConstants.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                height: 30.sp,
                width: 30.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorConstants.cardTintLight,
                  borderRadius: BorderRadius.circular(9.sp),
                ),
                child: Icon(Icons.account_balance_wallet_rounded, color: ColorConstants.primary, size: 21),
              ),
              SizedBox(width: 10.sp),
              Text(title,
                  style: TextStyle(color: ColorConstants.ink, fontSize: 16.sp, fontWeight: FontWeight.w800)),
              const Spacer(),
              GestureDetector(
                onTap: onDetails,
                child: Row(
                  children: [
                    Text('Details',
                        style: TextStyle(color: ColorConstants.muted, fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
                    Icon(Icons.chevron_right_rounded, color: ColorConstants.muted, size: 18),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          // Amount + Borrow button
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(amountLabel,
                        style: TextStyle(color: ColorConstants.muted, fontSize: 12.5.sp, fontWeight: FontWeight.w500)),
                    SizedBox(height: 4.sp),
                    // Shrink to fit instead of truncating: a long amount like
                    // ₹100000 must stay fully readable.
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        amount,
                        maxLines: 1,
                        style: TextStyle(
                          color: ColorConstants.ink,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.sp),
              GestureDetector(
                onTap: loading ? null : onAction,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.sp, vertical: 12.sp),
                  decoration: BoxDecoration(
                    gradient: ColorConstants.brandGradient,
                    borderRadius: BorderRadius.circular(30.sp),
                    boxShadow: [
                      BoxShadow(color: ColorConstants.primary.withOpacity(0.30), blurRadius: 14, offset: const Offset(0, 6)),
                    ],
                  ),
                  child: loading
                      ? SizedBox(
                          height: 18.sp,
                          width: 18.sp,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2.4, valueColor: AlwaysStoppedAnimation(Colors.white)),
                        )
                      : Text(actionText,
                          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.sp),
          Row(
            children: [
              Icon(Icons.circle, color: ColorConstants.gold, size: 16),
              SizedBox(width: 6.sp),
              Text(interestNote,
                  style: TextStyle(color: ColorConstants.muted, fontSize: 12.sp, fontWeight: FontWeight.w500)),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.sp),
            child: Divider(color: ColorConstants.border, height: 1),
          ),
          Text('Borrowing process',
              style: TextStyle(color: ColorConstants.ink, fontSize: 14.sp, fontWeight: FontWeight.w700)),
          SizedBox(height: 14.sp),
          _stepTracker(),
        ],
      ),
    );
  }

  Widget _stepTracker() {
    final int step = currentStep.clamp(0, _steps.length - 1);
    return Row(
      children: List.generate(_steps.length * 2 - 1, (i) {
        // Even indices = dots, odd indices = connecting lines.
        if (i.isOdd) {
          final int lineIndex = (i - 1) ~/ 2;
          final bool done = lineIndex < step;
          return Expanded(
            child: Container(
              height: 3,
              margin: EdgeInsets.only(bottom: 20.sp),
              color: done ? ColorConstants.primary : ColorConstants.border,
            ),
          );
        }
        final int dotIndex = i ~/ 2;
        final bool done = dotIndex < step;
        final bool active = dotIndex == step;
        final Color color = (done || active) ? ColorConstants.primary : ColorConstants.border;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 16.sp,
              width: 16.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (done || active) ? color : ColorConstants.surfaceLight,
                border: Border.all(color: color, width: 2),
              ),
              child: done ? Icon(Icons.check, size: 16, color: Colors.white) : null,
            ),
            SizedBox(height: 6.sp),
            Text(
              _steps[dotIndex],
              style: TextStyle(
                fontSize: 10.5.sp,
                color: (done || active) ? ColorConstants.ink : ColorConstants.muted,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        );
      }),
    );
  }
}
