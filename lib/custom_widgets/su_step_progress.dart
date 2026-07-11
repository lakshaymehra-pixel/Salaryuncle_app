import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/color_constants.dart';

/// SalaryUncle application step-progress header — KreditBee-inspired.
///
/// Shows the user's position in the loan application journey as a set of
/// condensed phase dots plus a percentage bar. Purely presentational: the
/// caller passes the current step index and the total, so this widget stays
/// free of any routing / GetX logic. Map [Events.getCurrentEvent()] (0..13)
/// into a small number of phases before passing it in.
class SuStepProgress extends StatelessWidget {
  /// Current phase index (0-based).
  final int currentPhase;

  /// Labels for each phase, in order. Its length defines the phase count.
  final List<String> phases;

  /// Optional title shown above the tracker.
  final String? title;

  const SuStepProgress({
    super.key,
    required this.currentPhase,
    this.phases = const ['Verify', 'Profile', 'Documents', 'Loan'],
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final int total = phases.length;
    final int clamped = currentPhase.clamp(0, total - 1);
    // Progress fraction: completed phases + a little into the current one.
    final double fraction = ((clamped + 0.5) / total).clamp(0.02, 1.0);
    final int percent = (fraction * 100).round();

    return Container(
      padding: EdgeInsets.fromLTRB(16.sp, 14.sp, 16.sp, 16.sp),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(18.sp),
        boxShadow: ColorConstants.softShadow,
        border: Border.all(color: ColorConstants.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? 'Application progress',
                style: TextStyle(
                  color: ColorConstants.ink,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
                decoration: BoxDecoration(
                  color: ColorConstants.cardTintLight,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Text(
                  '$percent%',
                  style: TextStyle(
                    color: ColorConstants.primaryDeep,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.sp),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(20.sp),
            child: Stack(
              children: [
                Container(height: 8.sp, color: ColorConstants.border),
                LayoutBuilder(
                  builder: (context, c) => Container(
                    height: 8.sp,
                    width: c.maxWidth * fraction,
                    decoration: const BoxDecoration(
                      gradient: ColorConstants.accentGradient,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.sp),
          // Phase dots + labels
          Row(
            children: List.generate(total, (i) {
              final bool done = i < clamped;
              final bool active = i == clamped;
              final Color color = done
                  ? ColorConstants.primary
                  : active
                      ? ColorConstants.primaryDeep
                      : ColorConstants.muted.withOpacity(0.4);
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 22.sp,
                      height: 22.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (done || active) ? color : ColorConstants.cardTintLight,
                        border: Border.all(
                          color: active ? ColorConstants.primaryDeep : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        done ? Icons.check_rounded : Icons.circle,
                        size: done ? 13.sp : 8.sp,
                        color: (done || active) ? Colors.white : ColorConstants.muted,
                      ),
                    ),
                    SizedBox(height: 6.sp),
                    Text(
                      phases[i],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        color: (done || active) ? ColorConstants.ink : ColorConstants.muted,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  /// Maps the app's fine-grained event index (0..13 from
  /// `Events.getCurrentEvent()`) to one of 4 high-level phases:
  /// 0 Verify (login/otp), 1 Profile (pan/personal/residence/income/selfie),
  /// 2 Documents (register/quote/employment/uploads), 3 Loan (bank/completed).
  static int phaseFromEvent(int eventIndex) {
    if (eventIndex <= 2) return 0; // login / otp / resend
    if (eventIndex <= 7) return 1; // pan..selfie
    if (eventIndex <= 11) return 2; // register..uploads
    return 3; // banking / completed
  }
}
