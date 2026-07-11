import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/color_constants.dart';

class CustomDDHeading extends StatelessWidget {
  String textHeading;
  var height;
  Widget dropDown;

  CustomDDHeading({super.key, required this.textHeading, required this.height, required this.dropDown});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 1.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 12.sp),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: textHeading,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: ColorConstants.ink,
                    ),
                  ),
                  TextSpan(
                    text: " *",
                    style: TextStyle(color: ColorConstants.danger, fontWeight: FontWeight.w900, fontSize: 16.sp),
                  ),
                ])),
                Spacer(),
              ],
            ),
          ),
          dropDown,
        ],
      ),
    );
  }
}
