import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/color_constants.dart';

class CustomHeadingText extends StatelessWidget {
  String text2;
  String text1;

  CustomHeadingText({super.key, required this.text2, required this.text1});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Padding(
        padding: EdgeInsets.only(left: 5.sp),
        child: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: "$text1\n",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: ColorConstants.ink,
              ),
            ),
            TextSpan(
              text: text2,
              style: TextStyle(color: ColorConstants.muted, fontSize: 15.sp, fontWeight: FontWeight.w500),
            )
          ]),
        ),
      ),
    );
  }
}
