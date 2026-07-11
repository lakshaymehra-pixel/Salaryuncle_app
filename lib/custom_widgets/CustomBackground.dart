import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/custom_widgets/custom_appbar.dart';
import 'package:tejas_loan/utils/color_constants.dart';

import '../controller/dashbroadController.dart';
import '../routes/routes_names.dart';
import '../utils/image_constants.dart';
import '../views/all_leads_page.dart';
import '../views/loan_status_page.dart';
import '../views/support_page.dart';
import 'custom_drawer.dart';

class CustomBackground extends StatelessWidget {
  List<Widget> children;
  var height;
  var backEnabled;
  var enableBottomNav;
  var heightOfUpperBox;
  var doubleBackToCloseApp;
  var isScrollable;
  var isAppBarVisible;
  var isBanner;
  var isUpLifted;
  var isTagLine;
  var isDrawer;
  var isUpperBoxVisible;

  CustomBackground({
    Key? key,
    required this.children,
    this.height = 0.0,
    this.doubleBackToCloseApp = true,
    this.enableBottomNav = false,
    required this.heightOfUpperBox,
    this.isScrollable = true,
    this.backEnabled = true,
    this.isAppBarVisible = true,
    this.isDrawer = true,
    this.isBanner = false,
    this.isUpperBoxVisible = true,
    this.isUpLifted = false,
    this.isTagLine = false,
  }) : super(key: key);

  DashbroadController controller = Get.put(DashbroadController());

  @override
  Widget build(BuildContext context) {
    var widgetOptions = <Widget>[customBackground(), AllLeadsPage(), LoanStatusScreen(), SupportPage()].obs;
    return Obx(() {
      return AdvancedDrawer(
        backdrop: Column(
          children: [
            Container(
                height: 57.sp,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: ColorConstants.brandGradient,
                )),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ),
          ],
        ),
        controller: controller.advancedDrawerController.value,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 350),
        animateChildDecoration: true,
        rtlOpening: false,
        openScale: 1,
        disabledGestures: !isDrawer,
        openRatio:.8,
        childDecoration: BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15.sp,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(25.sp)),
        ),
        drawer: CustomDrawer(
          advancedDrawerController: controller.advancedDrawerController.value,
        ),
        child: Scaffold(
            backgroundColor: ColorConstants.scaffoldLight,
            resizeToAvoidBottomInset: true,
            // Clean deep-green header (back button) instead of the old logo app bar.
            appBar: isAppBarVisible
                ? AppBar(
                    elevation: 0,
                    backgroundColor: ColorConstants.greenDeep,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: ColorConstants.greenDeep,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    leading: backEnabled
                        ? IconButton(
                            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                            onPressed: () => Get.back(),
                          )
                        : null,
                    title: const Text('Loan Application',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                    centerTitle: true,
                  )
                : AppBar(
                    elevation: 0,
                    backgroundColor: ColorConstants.greenDeep,
                    toolbarHeight: 0,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: ColorConstants.greenDeep,
                      statusBarIconBrightness: Brightness.light,
                    ),
                  ),
            // bottomNavigationBar:
            // widget.isAppBarVisible
            //     ? CustomNavBar(
            //         onTap: controller.onItemTapped,
            //         notchBottomBarController:
            //             controller.notchBottomBarController.value,
            //         pageController: controller.pageController.value)
            //     : null,
            //

            // Flow screens are a linear apply journey — no bottom nav here.
            bottomNavigationBar: null,
            body: doubleBackToCloseApp != false
                ? DoubleBackToCloseApp(
                    snackBar: SnackBar(
                        elevation: 10,
                        content: Text("Press again to exit !!"),
                        backgroundColor: Color(ColorConstants.primaryColor),
                        margin: EdgeInsets.all(15),
                        behavior: SnackBarBehavior.fixed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    // child: _widgetOptions.elementAt(_selectedIndex),
                    child:
                        // PageView(
                        //   controller: controller.pageController.value,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   children: List.generate(
                        //       widgetOptions.length, (index) => widgetOptions[index]),
                        // ),
                        widgetOptions.elementAt(controller.selectedIndex1.value),
                  )
                : widgetOptions.elementAt(controller.selectedIndex1.value)
            // PageView(
            //         controller: controller.pageController.value,
            //         physics: const NeverScrollableScrollPhysics(),
            //         children: List.generate(
            //             widgetOptions.length, (index) => widgetOptions[index]),
            //       ),
            ),
      );
    });
  }

  Widget customBackground() {
    try {
      controller.selectedDrawerIndex.value = 1;
    } catch (e) {
      print(e);
    }
    return Container(
        padding: EdgeInsets.all(12.sp),
        // color: Colors.black,
        height: GetPlatform.isIOS ? Get.height * 0.78 : Get.height * 0.8,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: children,
          ),
        ));
  }
}
