import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/color_constants.dart';

/// SalaryUncle signature "hero" loan card — MoneyView-inspired.
///
/// A bold gradient card that shows a big amount with a label, an optional
/// caption row, and an optional trailing action. Purely presentational —
/// all values and callbacks are passed in, so it holds no business logic.
class SuHeroCard extends StatelessWidget {
  final String label;
  final String amount;
  final String? caption;
  final String? actionText;
  final IconData? actionIcon;
  final VoidCallback? onAction;
  final bool loading;
  final List<Widget> footerChips;

  const SuHeroCard({
    super.key,
    required this.label,
    required this.amount,
    this.caption,
    this.actionText,
    this.actionIcon,
    this.onAction,
    this.loading = false,
    this.footerChips = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        children: [
          // Decorative soft circle (MoneyView-style depth)
          Positioned(
            right: -30,
            top: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.sp),
                        loading
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.sp),
                                child: SizedBox(
                                  height: 22.sp,
                                  width: 22.sp,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  ),
                                ),
                              )
                            : FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  amount,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                        if (caption != null) ...[
                          SizedBox(height: 6.sp),
                          Text(
                            caption!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (actionText != null && onAction != null)
                    GestureDetector(
                      onTap: onAction,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 10.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.sp),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (actionIcon != null) ...[
                              Icon(actionIcon, color: ColorConstants.primary, size: 18),
                              SizedBox(width: 5.sp),
                            ],
                            Text(
                              actionText!,
                              style: TextStyle(
                                color: ColorConstants.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.5.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              if (footerChips.isNotEmpty) ...[
                SizedBox(height: 16.sp),
                Container(height: 1, color: Colors.white.withOpacity(0.15)),
                SizedBox(height: 14.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: footerChips,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// A small stat block used inside [SuHeroCard.footerChips] (e.g. "Tenure • 30d").
class SuHeroStat extends StatelessWidget {
  final String title;
  final String value;
  const SuHeroStat({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12.sp),
        ),
        SizedBox(height: 3.sp),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 14.5.sp, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
