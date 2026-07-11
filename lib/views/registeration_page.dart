import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meta_sdk/flutter_meta_sdk.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/image_constants.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../custom_widgets/HeadingText.dart';
import '../routes/routes_names.dart';

class RegisterPage extends StatelessWidget {
  final metaSdk = FlutterMetaSdk();
  final facebookAppEvents = FacebookAppEvents();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldLight,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomHeadingText(
                // text1: "  Get Loan For Your", text2: "Different Needs "),
                text2: "  Your emergency speed",
                text1: "funds partner "),
            Text(
              "Get Loan For Your Different Needs ",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 17.sp,
                  color: ColorConstants.primary),
            ),
            Image.asset(
                            ImageConstants.registerPageLogo,
                            width: Get.width,
                            height: Get.height * 0.35,
                          ),
            ElevatedButton(
              onPressed: () async {
                await facebookAppEvents.logEvent(
                  name: "Registeration",
                  parameters: {
                    "event_name": "Registeration",
                  },
                );
                // var result = await facebookAppEvents.getApplicationId();
                // metaSdk.logEvent(
                //   name: 'button_clicked',
                //   parameters: {
                //     'button_id': 'the_clickme_button',
                //   },
                // );
                // print("Pressed" + result.toString());

                Get.toNamed(RoutesName.LoginScreen);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primary,
                  elevation: 0,
                  shadowColor: ColorConstants.primary.withOpacity(0.3),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.sp))),
              child: Container(
                width: Get.width * 0.7,
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                  gradient: ColorConstants.brandGradient,
                  borderRadius: BorderRadius.circular(14.sp),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.primary.withOpacity(0.30),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Center(
                    child: Text(
                  "REGISTER NOW",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      color: Colors.white,
                      fontSize: 16.sp),
                )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Text(
                textAlign: TextAlign.center,
                "©2024 Copyright. All Rights Reserved by ${SharedConstants.Company_Name}.",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5.sp,
                    color: ColorConstants.muted),
              ),
            ),
          ]),
    );
  }
}
