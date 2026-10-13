import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/controller/homeController.dart';
import 'package:tejas_loan/custom_widgets/custom_toast_snack_bar.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/views/feedback_page.dart';
import 'package:tejas_loan/views/repay_page.dart';
import 'package:tejas_loan/views/terms_conditions_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/theme_controller.dart';
import '../services/api_constant/api_constants.dart';
import '../utils/color_constants.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';
import '../views/dev_page.dart';
import '../views/privacy_policy_page.dart';
import '../views/repay_page.dart';
import 'custom_profile_pic_view.dart';

class CustomDrawer extends StatelessWidget {
  DashbroadController controller = Get.put(DashbroadController());
  HomeController homeController = Get.put(HomeController());

  AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();
  final ThemeController themeController = Get.find();

  CustomDrawer({super.key, required this.advancedDrawerController});

  /// "+91 98765 43210", or whatever is stored if it is not 10 digits.
  /// The previous version called substring(0, 5) unguarded, which threw for
  /// any shorter value.
  String _formattedMobile() {
    final n = prefs.getString(SharedConstants.MOBILE) ?? '';
    if (n.length < 10) return n.isEmpty ? '' : '+91 $n';
    return '+91 ${n.substring(0, 5)} ${n.substring(5, 10)}';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.only(bottom: 15.sp),
            decoration: const BoxDecoration(gradient: ColorConstants.brandGradient),
            child: Padding(
              padding: EdgeInsets.only(top: 12.sp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomProfilePicView(),
                  SizedBox(width: 12.sp),
                  // Take the rest of the row instead of a fixed 120px box:
                  // a full name at this size does not fit 120px and was being
                  // wrapped and clipped mid-word.
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 14.sp, right: 8.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            (prefs.getString(SharedConstants.NAME) ?? 'hi user')
                                .split(' ')
                                .map((word) => word.capitalize!)
                                .join(' '),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6.sp),
                          Text(
                            _formattedMobile(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white.withOpacity(0.85),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
            child: ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (APIConstants.isModeDevelopment())
                      _createDrawerItem(
                        context: context,
                        icon: Icons.developer_mode,
                        text: 'Developer Mode',
                        onTap: () {
                          controller.advancedDrawerController.value.hideDrawer();
                          Get.to(const RouteButtons());
                        },
                        active: false,
                      ),
                    homeController.loadingOnContinue.value
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 8.sp,
                              color: ColorConstants.primary,
                              backgroundColor: ColorConstants.cardTintLight,
                            ),
                          )
                        :

                        // _createDrawerItem(
                        //   icon: Icons.notifications,
                        //   text: 'Notifications',
                        //   onTap: () {
                        //     // Handle Notifications tap
                        //   },
                        // ),
                        _createDrawerItem(
                            context: context,
                            icon: Icons.credit_card_rounded,
                            text: 'Apply Now',
                            onTap: () {
                              controller.advancedDrawerController.value.hideDrawer();

                              if ((prefs.getString(SharedConstants.STEP_STAGE) ?? "") != Events.COMPLETED) {
                                Events.getNextEvent(prefs.getString(SharedConstants.STEP_STAGE) ?? "");
                                controller.selectedDrawerIndex.value == 1;
                              } else {
                                ShortMessage.toast(title: "Your Application has submitted No action is required!!");
                              }

                              // Handle Subscribe tap
                            },
                            active: controller.selectedDrawerIndex.value == 1,
                          ),
                    _createDrawerItem(
                      context: context,
                      icon: Icons.folder_rounded,
                      text: 'All Applications',
                      onTap: () {
                        // controller.pageController.value.jumpToPage(1);
                        // controller.notchBottomBarController.value.jumpTo(1);

                        controller.selectedIndex.value = 1;
                        controller.selectedIndex1.value = 1;
                        controller.selectedDrawerIndex.value = 2;
                        // Get.offAllNamed(RoutesName.DashbroadScreen);

                        controller.advancedDrawerController.value.hideDrawer();

                        // Handle Settings tap
                      },
                      active: controller.selectedDrawerIndex.value == 2,
                    ),
                    _createDrawerItem(
                      context: context,
                      icon: Icons.history_rounded,
                      text: 'Repayment History',
                      onTap: () {
                        controller.advancedDrawerController.value.hideDrawer();

                        Get.toNamed(RoutesName.RepayHisScreen);
                        controller.selectedDrawerIndex.value = 3;

                        // Handle Settings tap
                      },
                      active: controller.selectedDrawerIndex.value == 3,
                    ),_createDrawerItem(
                      context: context,
                      icon: Icons.account_balance_rounded,
                      text: 'Repay Loan',
                      onTap: () {
                        controller.advancedDrawerController.value.hideDrawer();
                        // In-app WebView (not launchUrl) so the user keeps a
                        // back button and a way home.
                        Get.to(() => const RepayPage());
                        controller.selectedDrawerIndex.value = 4;

                        // Handle Settings tap
                      },
                      active: controller.selectedDrawerIndex.value == 4,
                    ),
                    _createDrawerItem(
                      context: context,
                      icon: Icons.help_outline_rounded,
                      text: 'Help & Support',
                      onTap: () {
                        controller.advancedDrawerController.value.hideDrawer();
                        controller.selectedDrawerIndex.value = 5;

                        // controller.pageController.value.jumpToPage(3);
                        // controller.notchBottomBarController.value.jumpTo(3);
                        controller.selectedIndex.value = 3;
                        controller.selectedIndex1.value = 3;

                        // Handle Help & Support tap
                      },
                      active: controller.selectedDrawerIndex.value == 5,
                    ),
                    // _createDrawerItem(
                    //   context: context,
                    //   icon: Icons.rate_review_rounded,
                    //   text: 'Add Feedback',
                    //   onTap: () {
                    //     controller.advancedDrawerController.value.hideDrawer();
                    //
                    //     Get.to(FeedbackPage());
                    //
                    //     // Handle Help & Support tap
                    //   },
                    //   active: controller.selectedDrawerIndex.value == 5,
                    // ),
                    // Container(
                    //   margin: EdgeInsets.all(10.sp),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15.sp), color: Theme.of(context).highlightColor),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: ListTile(
                    //           leading: Icon(Icons.dark_mode, color: Theme.of(context).textTheme.titleMedium!.color),
                    //           title: Text('Dark Mode',
                    //               style: TextStyle(
                    //                   color: Theme.of(context).textTheme.titleMedium!.color,
                    //                   fontWeight: FontWeight.w700)),
                    //         ),
                    //       ),
                    //       Obx(() => CupertinoSwitch(
                    //             activeTrackColor: Theme.of(context).primaryColor,
                    //             value: themeController.isDarkMode.value,
                    //             onChanged: (val) {
                    //               themeController.toggleTheme(val);
                    //             },
                    //           )),
                    //     ],
                    //   ),
                    // ),
                    _createDrawerItem(
                      context: context,
                      icon: Icons.logout,
                      text: 'Log Out',
                      onTap: () {
                        controller.advancedDrawerController.value.hideDrawer();

                        controller.logout(context);
                        // Handle Help & Support tap
                      },
                      active: controller.selectedDrawerIndex.value == 6,
                    ),
                    SizedBox(
                      height: APIConstants.isModeDevelopment() ? 0 : 10.sp,
                    ),
                    Divider(
                      color: ColorConstants.border,
                      thickness: 1,
                      indent: 18.sp,
                      endIndent: 18.sp,
                    ),
                    if (!APIConstants.isModeDevelopment())
                      SizedBox(
                        height: 20.sp,
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async{
                              // Get.to(const TermsAndConditionsScreen());

                              await launchUrl(Uri.parse(SharedConstants.Terms_Condition_Url),
                              mode: LaunchMode.inAppWebView);
                            },
                            child: Text(
                              '   Terms & Conditions',
                              style: TextStyle(color: ColorConstants.muted, fontSize: 17.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () async{
                              // Get.to(const PrivacyPolicyScreen());
                              await launchUrl(Uri.parse(SharedConstants.Privacy_Policy_Url),
                              mode: LaunchMode.inAppWebView);

                            },
                            child: Text(
                              textAlign: TextAlign.left,
                              '   Privacy Policy         ',
                              style: TextStyle(color: ColorConstants.muted, fontSize: 17.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          )

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
    required bool active,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.sp),
          color: active ? ColorConstants.cardTintLight : ColorConstants.surfaceLight,
          border: Border.all(
            color: active ? ColorConstants.primary.withOpacity(0.2) : Colors.transparent,
            width: 1,
          )),
      child: ListTile(
        leading: Icon(icon, color: active ? ColorConstants.primary : ColorConstants.muted),
        title: Text(text,
            style: TextStyle(
                color: active ? ColorConstants.primary : ColorConstants.body,
                fontWeight: FontWeight.w700)),
        onTap: onTap,
      ),
    );
  }
}
