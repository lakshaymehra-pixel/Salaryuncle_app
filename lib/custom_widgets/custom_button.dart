import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/utils/color_constants.dart';

class CustomButton extends StatelessWidget {
  var height;
  var text;
  var isLoading;
  Function()? onPressed;

  CustomButton({super.key, required this.height, required this.onPressed, required this.text, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: Get.width * 0.9,
        height: height,
        decoration: BoxDecoration(
          gradient: enabled ? ColorConstants.brandGradient : null,
          color: enabled ? null : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(14.sp),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: ColorConstants.primary.withOpacity(0.30),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14.sp),
            onTap: onPressed,
            child: Center(
              child: isLoading
                  ? const SpinKitThreeBounce(
                      color: Colors.white,
                      size: 22,
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
