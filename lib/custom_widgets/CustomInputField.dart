import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../main.dart';
import '../utils/shared_constants.dart';

class CustomInputField extends StatelessWidget {
  String textHeading;
  String hint;
  List<TextInputFormatter> formatter;
  TextInputType keyBroadType;
  var isCaps;
  var isButton;
  var isLoading;
  var readOnly;
  var maxLenght;
  var letterSpacing;
  var maxLines;
  var isEdit;
  var isFoused;
  var isEnabledResend;
  var isResend;
  var isOnChanged;
  var isMandatory;
  var isInteractive;

  var countdown_controller;
  var height;
  var heightOfTextField;
  Function()? onPressed;
  Function()? onResendPressed;
  Function(String)? onChanged;
  Function()? onResendFinished;
  Function()? onEditPressed;
  String buttonText;
  FocusNode? focusNode = FocusNode();
  TextEditingController? controller;

  CustomInputField(
      {Key? key,
      required this.keyBroadType,
      this.maxLenght = 10,
      this.maxLines = 1,
      this.letterSpacing = 5.0,
      required this.height,
      this.heightOfTextField = 0,
      this.isCaps = false,
      this.isFoused = false,
      this.isOnChanged = false,
      required this.textHeading,
      required this.hint,
      required this.formatter,
      this.controller,
      this.focusNode = null,
      this.countdown_controller,
      this.isButton = true,
      this.isInteractive = true,
      this.isLoading = false,
      this.isEnabledResend = false,
      this.isEdit = false,
      this.isResend = false,
      this.isMandatory = true,
      this.readOnly = false,
      this.onPressed,
      this.onEditPressed,
      this.onChanged,
      this.onResendPressed,
      this.onResendFinished,
      this.buttonText = "Send OTP"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 1.5,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Theme.of(context).textTheme.titleMedium!.color),
                  ),
                  isMandatory
                      ? TextSpan(
                          text: "*",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900, fontSize: 16.sp),
                        )
                      : TextSpan(),
                ])),
                Spacer(),
                isEdit
                    ? InkWell(
                        onTap: onEditPressed,
                        child: Icon(
                          Icons.edit,
                          color: Color(ColorConstants.primaryColor),
                          size: 18.sp,
                        ))
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            height: 15.sp,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.sp),
            // height: 30.sp,
            height: heightOfTextField == 0 ? Get.height * 0.075 : heightOfTextField,
            // alignment: Alignment.center,
            // clipBehavior: Clip.hardEdge,

            decoration: BoxDecoration(
              color: (prefs.getBool(SharedConstants.THEME) ?? false)
                  ? Theme.of(context).highlightColor
                  : ColorConstants.cardTintLight,
              border: Border.all(
                color: !isFoused ? ColorConstants.border : ColorConstants.primary,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: isButton ? 3 : 1,
                  child: TextFormField(
                    enableInteractiveSelection: isInteractive,
                    onChanged: isOnChanged
                        ? onChanged
                        : (text) {
                            // if (isCaps) {
                            controller!.value =
                                TextEditingValue(text: text.toUpperCase(), selection: controller!.selection);
                            // }
                          },
                    readOnly: readOnly,
                    controller: controller,
                    inputFormatters: formatter,
                    textInputAction: TextInputAction.go,
                    keyboardType: keyBroadType,
                    onTap: () {
                      isFoused = true;
                    },
                    maxLength: maxLenght,
                    style: TextStyle(
                      letterSpacing: 1.sp,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                    maxLines: maxLines,
                    textCapitalization: isCaps ? TextCapitalization.characters : TextCapitalization.none,
                    decoration: InputDecoration(
                      counter: SizedBox(),
                      hintText: hint,
                      hintStyle: TextStyle(
                        letterSpacing: 0.sp,
                        fontSize: 17.sp,
                        color: Theme.of(context).textTheme.titleLarge!.color,
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: isButton
                          ? InputBorder.none
                          : OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(ColorConstants.primaryColor),
                                width: 5.sp,
                              ),
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                      border: isButton
                          ? InputBorder.none
                          : OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54, width: 6.sp),
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                      contentPadding: isButton
                          ? EdgeInsets.symmetric(vertical: 0.sp, horizontal: 15.sp)
                          : EdgeInsets.symmetric(vertical: 19.sp, horizontal: 15.sp),
                    ),
                    onTapOutside: (pointer) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      isFoused = false;
                    },
                    onFieldSubmitted: (value) {
                      isFoused = false;
                    },
                  ),
                ),
                if (isButton)
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.w, horizontal: 1.h),
                      child: IconButton(
                          onPressed: onPressed,
                          icon: Icon(
                            Icons.calendar_month_rounded,
                            size: 23.sp,
                            color: Theme.of(context).textTheme.titleMedium!.color,
                          )
                          // Container(
                          //   alignment: Alignment.center,
                          //   height: 5.h,
                          //   width: 10.w,
                          //   child: FittedBox(
                          //     fit: BoxFit.fitWidth,
                          //     child: isLoading
                          //         ? Container(
                          //             padding: EdgeInsets.all(15.sp),
                          //             child: CircularProgressIndicator(
                          //               color: Colors.white,
                          //               strokeWidth: 5,
                          //             ),
                          //           )
                          //         : Text(
                          //             buttonText,
                          //             style: TextStyle(
                          //                 fontSize: 18.sp, color: Colors.white),
                          //           ),
                          //   ),
                          // ),
                          // style: ElevatedButton.styleFrom(
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(50)),
                          //   backgroundColor: Color(ColorConstants.primaryColor),
                          // ),
                          ),
                    ),
                  )
              ],
            ),
          ),
          if (isEnabledResend)
            Countdown(
              controller: countdown_controller,
              seconds: 60,
              build: (BuildContext context, double time) => isResend == false
                  ? Text('Resend in ' + time.toInt().toString(),
                      style: TextStyle(
                        color: isResend ? Colors.blue : Theme.of(context).textTheme.titleMedium!.color,
                      ))
                  : InkWell(
                      onTap: onResendPressed,
                      child: Text(
                        "RESEND",
                        style: TextStyle(color: Colors.blue, fontSize: 16.sp),
                      ),
                    ),
              interval: Duration(milliseconds: 100),
              onFinished: onResendFinished,
            )
          // : Container()
        ],
      ),
    );
  }
}
