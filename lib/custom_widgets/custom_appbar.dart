import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';

import '../utils/color_constants.dart';
import '../utils/image_constants.dart';

AppBar CustomAppbar(
    {String title = "",
    required BuildContext context,
    bool isEnableLogout = false,
    bool isImage = false,
    Widget? leading,
    Widget? leading2}) {
  DashbroadController controller = Get.put(DashbroadController());
  return AppBar(
    leading: leading2,
    actions: [
      isEnableLogout
          ? IconButton(
              onPressed: () {
                controller.logout(context);
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
                semanticLabel: "Logout",
              ))
          : Container(),
    ],
    iconTheme: const IconThemeData(color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(22.sp),
      ),
    ),
    toolbarHeight: Get.height * 0.1,
    title: isImage
        ? SizedBox(
            height: 44,
            child: Image.asset(
              ImageConstants.logo,
              // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              // semanticsLabel: 'Tejas-Loan',
            ), // Set the width of the container to 300.sp,
          )
        : Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
          ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.grey,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).primaryColor,
      statusBarIconBrightness: ColorConstants.getBrightColorARD(context),
      statusBarBrightness: ColorConstants.getBrightColorIOS(context),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: ColorConstants.brandGradient,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(22.sp),
        ),
      ),
    ),
  );
}
