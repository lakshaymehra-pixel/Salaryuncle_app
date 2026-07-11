import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/image_constants.dart';

class OnbroadingPage extends StatelessWidget {
  OnbroadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var decoration = PageDecoration(
      bodyFlex: 4,
      imageFlex: 2,
      footerFlex: 1,
      imagePadding: EdgeInsets.zero,
      bodyPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      bodyAlignment: Alignment.center,
      fullScreen: false,
      imageAlignment: Alignment.topCenter,
      pageColor: Theme.of(context).scaffoldBackgroundColor,
    );

    var Logoimage = Center(
      child: Padding(
        padding: EdgeInsets.only(left: 10.sp),
        child: SizedBox(
          height: Get.height * 0.16,
          width: Get.width * 0.65,
          child: Image.asset(
            ImageConstants.logo,
            // colorFilter: const ColorFilter.mode(Color(ColorConstants.primaryColor), BlendMode.srcIn),
            // semanticsLabel: 'Tejas-Loan',
          ),
        ),
      ),
    );
    var listPagesViewModel = [
      // PageViewModel(
      //   title: "",
      //   footer: Text(
      //     textAlign: TextAlign.center,
      //     "\nMake Informed \nFinancial Decisions",
      //     style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800, color: Color(ColorConstants.primaryColor)),
      //   ),
      //   bodyWidget: ColoredBox(
      //     color: Colors.white,
      //     child: SizedBox(
      //       height: Get.height * 0.42,
      //       width: Get.width,
      //       child: Image.asset(
      //         ImageConstants.Page3,
      //         fit: BoxFit.contain,
      //       ),
      //     ),
      //   ),
      //   image: Logoimage,
      //   decoration: decoration,
      // ),
      PageViewModel(
        title: "",
        footer: Text(
          textAlign: TextAlign.center,
          "\nApproval and Disbursal \nin 10 minutes",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: ColorConstants.ink),
        ),
        bodyWidget: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SizedBox(
            height: Get.height * 0.4,
            width: Get.width,
            child: Image.asset(
              ImageConstants.Page1,
              fit: BoxFit.fitHeight,
              scale: 0.5,
            ),
          ),
        ),
        image: Logoimage,
        decoration: decoration,
      ),
      PageViewModel(
        title: "",
        footer: Text(
          textAlign: TextAlign.center,
          "\nGet Funds Directly To \nYour Bank Account ",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: ColorConstants.ink),
        ),
        bodyWidget: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SizedBox(
            height: Get.height * 0.3,
            width: Get.width,
            child: Image.asset(
              ImageConstants.Page2,
              fit: BoxFit.cover,
            ),
          ),
        ),
        image: Logoimage,
        decoration: decoration,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: ColorConstants.getBrightColorARD(context),
          statusBarBrightness: ColorConstants.getBrightColorIOS(context),
        ),
      ),
      body: IntroductionScreen(
        globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        pages: listPagesViewModel,
        showSkipButton: true,
        skip: Text("Skip",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: ColorConstants.muted)),
        next: Text("Next",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: ColorConstants.primary)),
        done: Text(
          "Done",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.primary),
        ),
        onDone: () {
          Get.offAllNamed(RoutesName.LoginScreen);
        },
        onSkip: () {
          Get.offAllNamed(RoutesName.LoginScreen);
        },
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(22.0, 10.0),
          activeColor: ColorConstants.primary,
          color: ColorConstants.primary.withOpacity(0.25),
          spacing: const EdgeInsets.symmetric(horizontal: 4.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }
}
