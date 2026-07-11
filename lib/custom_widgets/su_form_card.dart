import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/color_constants.dart';

/// SalaryUncle premium form card.
///
/// Purely presentational wrapper used by the loan-application form screens to
/// group related fields inside a soft white card with an optional accent icon
/// badge + section heading, echoing the polish of the login card. It takes
/// arbitrary [children] (typically the existing `CustomInputField` /
/// `CustomRBHeading` / `CustomDropdown` widgets) and lays them out unchanged.
class SuFormCard extends StatelessWidget {
  /// Section heading shown at the top of the card.
  final String? title;

  /// Short helper line under the title, in muted tone.
  final String? subtitle;

  /// Accent icon rendered inside a tinted badge next to the title.
  final IconData? icon;

  /// The form widgets to display inside the card, unchanged.
  final List<Widget> children;

  const SuFormCard({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14.sp, 16.sp, 14.sp, 18.sp),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(20.sp),
        border: Border.all(color: ColorConstants.border),
        boxShadow: ColorConstants.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.sp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Container(
                      height: 34.sp,
                      width: 34.sp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorConstants.cardTintLight,
                        borderRadius: BorderRadius.circular(11.sp),
                      ),
                      child: Icon(icon, color: ColorConstants.primary, size: 18.sp),
                    ),
                    SizedBox(width: 12.sp),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title!,
                          style: TextStyle(
                            color: ColorConstants.ink,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.2,
                          ),
                        ),
                        if (subtitle != null) ...[
                          SizedBox(height: 2.sp),
                          Text(
                            subtitle!,
                            style: TextStyle(
                              color: ColorConstants.muted,
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.sp),
            Divider(color: ColorConstants.border, height: 18.sp, thickness: 1),
            SizedBox(height: 2.sp),
          ],
          ...children,
        ],
      ),
    );
  }
}
