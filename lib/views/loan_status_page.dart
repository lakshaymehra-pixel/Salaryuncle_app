import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/controller/status_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_button.dart';
import 'package:tejas_loan/routes/routes_names.dart';
import 'package:tejas_loan/utils/color_constants.dart';
import 'package:tejas_loan/utils/image_constants.dart';

import '../main.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';

class LoanStatusScreen extends GetView<StatusController> {

  StatusController controller = Get.put(StatusController());
  var dashbroadController = Get.put(DashbroadController());

  @override
  Widget build(BuildContext context) {
    controller.isEligible.value = prefs.getBool(SharedConstants.ELIGIBLE) ?? false;
    if (kDebugMode) {
      print(controller.isEligible.value);
    }
    return Scaffold(
      body: Obx(() {
        return controller.loading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(height: 15.sp),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: SizedBox(
                      width: Get.width,
                      height: Events.getCurrentEvent() > 7
                          ? GetPlatform.isIOS
                              ? Get.height * .62
                              : Get.height * .67
                          : Get.height * .7,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.2,
                                  child: Center(
                                    child: SizedBox(
                                      height: 140,
                                      width: 140,
                                      child: SizedBox(
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                width: 140,
                                                height: 140,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 10,
                                                  valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                                                  backgroundColor: ColorConstants.border,
                                                  strokeCap: StrokeCap.round,
                                                  value: prefs.getInt(SharedConstants.STEP_COMPLETE_PERCENT) != null
                                                      ? prefs
                                                              .getInt(SharedConstants.STEP_COMPLETE_PERCENT)!
                                                              .toDouble() /
                                                          100
                                                      : 0.0,
                                                ),
                                              ),
                                            ),
                                            Center(
                                                child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              "${prefs.getInt(SharedConstants.STEP_COMPLETE_PERCENT)}%\n",
                                                          style: TextStyle(
                                                              color: Theme.of(context).primaryColor,
                                                              fontSize: 25.sp,
                                                              fontWeight: FontWeight.bold)),
                                                      TextSpan(
                                                          text:
                                                              prefs.getInt(SharedConstants.STEP_COMPLETE_PERCENT) == 100
                                                                  ? "Completed"
                                                                  : "In Progress",
                                                          style: TextStyle(
                                                              color: Theme.of(context).textTheme.titleLarge!.color,
                                                              fontSize: 15.sp,
                                                              fontWeight: FontWeight.bold))
                                                    ]))),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  prefs.getInt(SharedConstants.STEP_COMPLETE_PERCENT) == 100
                                      ? !controller.isEligible.value
                                          ? prefs.getString(SharedConstants.USER_TYPE).toString().contains("REPEAT") &&
                                                  prefs.getString(SharedConstants.STEP_STAGE) == Events.REGISTER_NOW
                                              ? 'Please Click On RE-LOAN To Apply For Your Re-Loan'
                                              : 'Please Click On Check Eligibility To Get Your Loan'
                                          : 'Application has been submitted successfully Please wait for approval'
                                      : 'Complete your profile to get instant loan\n approval',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.titleMedium!.color,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            buildListItem(
                              icon: ImageConstants.panCardLogo,
                              title: 'PAN VERIFICATION',
                              context: context,
                              isJoinLine: true,
                              inProgress: Events.getCurrentEvent() == 3 ? true : false,
                              isDone: Events.getCurrentEvent() > 3 ? true : false,
                              scale: 4.7.sp,
                              status: Events.getCurrentEvent() > 3
                                  ? LoanStatus.completed.status
                                  : Events.getCurrentEvent() == 3
                                      ? LoanStatus.inProgress.status
                                      : LoanStatus.locked.status,
                              statusTextColor: Events.getCurrentEvent() > 3
                                  ? LoanStatus.completed.statusTextColor
                                  : Events.getCurrentEvent() == 3
                                      ? LoanStatus.inProgress.statusTextColor
                                      : LoanStatus.locked.statusTextColor,
                              joinLineColor: Events.getCurrentEvent() > 3
                                  ? LoanStatus.completed.joinLineColor
                                  : Events.getCurrentEvent() == 3
                                      ? LoanStatus.inProgress.joinLineColor
                                      : LoanStatus.locked.joinLineColor,
                              trailing: Events.getCurrentEvent() > 3
                                  ? LoanStatus.completed.trailingIcon
                                  : Events.getCurrentEvent() == 3
                                      ? LoanStatus.inProgress.trailingIcon
                                      : LoanStatus.locked.trailingIcon,
                              tittleColor: Events.getCurrentEvent() > 3
                                  ? LoanStatus.completed.titleColor
                                  : Events.getCurrentEvent() == 3
                                      ? LoanStatus.inProgress.titleColor
                                      : LoanStatus.locked.titleColor,
                            ),
                            buildListItem(
                              icon: ImageConstants.personalLogo,
                              title: 'PERSONAL INFORMATION',
                              context: context,
                              isJoinLine: true,
                              inProgress: Events.getCurrentEvent() == 4 ? true : false,
                              isDone: Events.getCurrentEvent() > 4 ? true : false,
                              scale: 4.9.sp,
                              status: Events.getCurrentEvent() > 4
                                  ? LoanStatus.completed.status
                                  : Events.getCurrentEvent() == 4
                                      ? LoanStatus.inProgress.status
                                      : LoanStatus.locked.status,
                              statusTextColor: Events.getCurrentEvent() > 4
                                  ? LoanStatus.completed.statusTextColor
                                  : Events.getCurrentEvent() == 4
                                      ? LoanStatus.inProgress.statusTextColor
                                      : LoanStatus.locked.statusTextColor,
                              joinLineColor: Events.getCurrentEvent() > 4
                                  ? LoanStatus.completed.joinLineColor
                                  : Events.getCurrentEvent() == 4
                                      ? LoanStatus.inProgress.joinLineColor
                                      : LoanStatus.locked.joinLineColor,
                              trailing: Events.getCurrentEvent() > 4
                                  ? LoanStatus.completed.trailingIcon
                                  : Events.getCurrentEvent() == 4
                                      ? LoanStatus.inProgress.trailingIcon
                                      : LoanStatus.locked.trailingIcon,
                              tittleColor: Events.getCurrentEvent() > 4
                                  ? LoanStatus.completed.titleColor
                                  : Events.getCurrentEvent() == 4
                                      ? LoanStatus.inProgress.titleColor
                                      : LoanStatus.locked.titleColor,
                            ),
                            buildListItem(
                              icon: ImageConstants.residenceLogo,
                              title: 'RESIDENCE INFORMATION',
                              context: context,
                              isJoinLine: true,
                              inProgress: Events.getCurrentEvent() == 5 ? true : false,
                              isDone: Events.getCurrentEvent() > 5 ? true : false,
                              scale: 5.1.sp,
                              status: Events.getCurrentEvent() > 5
                                  ? LoanStatus.completed.status
                                  : Events.getCurrentEvent() == 5
                                      ? LoanStatus.inProgress.status
                                      : LoanStatus.locked.status,
                              statusTextColor: Events.getCurrentEvent() > 5
                                  ? LoanStatus.completed.statusTextColor
                                  : Events.getCurrentEvent() == 5
                                      ? LoanStatus.inProgress.statusTextColor
                                      : LoanStatus.locked.statusTextColor,
                              joinLineColor: Events.getCurrentEvent() > 5
                                  ? LoanStatus.completed.joinLineColor
                                  : Events.getCurrentEvent() == 5
                                      ? LoanStatus.inProgress.joinLineColor
                                      : LoanStatus.locked.joinLineColor,
                              trailing: Events.getCurrentEvent() > 5
                                  ? LoanStatus.completed.trailingIcon
                                  : Events.getCurrentEvent() == 5
                                      ? LoanStatus.inProgress.trailingIcon
                                      : LoanStatus.locked.trailingIcon,
                              tittleColor: Events.getCurrentEvent() > 5
                                  ? LoanStatus.completed.titleColor
                                  : Events.getCurrentEvent() == 5
                                      ? LoanStatus.inProgress.titleColor
                                      : LoanStatus.locked.titleColor,
                            ),
                            buildListItem(
                              icon: ImageConstants.incomeLogo,
                              title: 'INCOME INFORMATION',
                              context: context,
                              inProgress: Events.getCurrentEvent() == 6 ? true : false,
                              isJoinLine:
                                  (prefs.getString(SharedConstants.MOBILE) ?? "") != "9999999999" ? true : false,
                              isDone: Events.getCurrentEvent() > 6 ? true : false,
                              scale: 4.7.sp,
                              status: Events.getCurrentEvent() > 6
                                  ? LoanStatus.completed.status
                                  : Events.getCurrentEvent() == 6
                                      ? LoanStatus.inProgress.status
                                      : LoanStatus.locked.status,
                              statusTextColor: Events.getCurrentEvent() > 6
                                  ? LoanStatus.completed.statusTextColor
                                  : Events.getCurrentEvent() == 6
                                      ? LoanStatus.inProgress.statusTextColor
                                      : LoanStatus.locked.statusTextColor,
                              joinLineColor: Events.getCurrentEvent() > 6
                                  ? LoanStatus.completed.joinLineColor
                                  : Events.getCurrentEvent() == 6
                                      ? LoanStatus.inProgress.joinLineColor
                                      : LoanStatus.locked.joinLineColor,
                              trailing: Events.getCurrentEvent() > 6
                                  ? LoanStatus.completed.trailingIcon
                                  : Events.getCurrentEvent() == 6
                                      ? LoanStatus.inProgress.trailingIcon
                                      : LoanStatus.locked.trailingIcon,
                              tittleColor: Events.getCurrentEvent() > 6
                                  ? LoanStatus.completed.titleColor
                                  : Events.getCurrentEvent() == 6
                                      ? LoanStatus.inProgress.titleColor
                                      : LoanStatus.locked.titleColor,
                            ),
                            if ((prefs.getString(SharedConstants.MOBILE) ?? "") != "9999999999")
                              buildListItem(
                                icon: ImageConstants.Photo,
                                title: 'PHOTO UPLOAD',
                                context: context,
                                inProgress: Events.getCurrentEvent() == 7 ? true : false,
                                isJoinLine: controller.isEligible.value ? true : false,
                                isDone: Events.getCurrentEvent() > 7 ? true : false,
                                scale: 17.sp,
                                status: Events.getCurrentEvent() > 7
                                    ? LoanStatus.completed.status
                                    : Events.getCurrentEvent() == 7
                                        ? LoanStatus.inProgress.status
                                        : LoanStatus.locked.status,
                                statusTextColor: Events.getCurrentEvent() > 7
                                    ? LoanStatus.completed.statusTextColor
                                    : Events.getCurrentEvent() == 7
                                        ? LoanStatus.inProgress.statusTextColor
                                        : LoanStatus.locked.statusTextColor,
                                joinLineColor: Events.getCurrentEvent() > 7
                                    ? LoanStatus.completed.joinLineColor
                                    : Events.getCurrentEvent() == 7
                                        ? LoanStatus.inProgress.joinLineColor
                                        : LoanStatus.locked.joinLineColor,
                                trailing: Events.getCurrentEvent() > 7
                                    ? LoanStatus.completed.trailingIcon
                                    : Events.getCurrentEvent() == 7
                                        ? LoanStatus.inProgress.trailingIcon
                                        : LoanStatus.locked.trailingIcon,
                                tittleColor: Events.getCurrentEvent() > 7
                                    ? LoanStatus.completed.titleColor
                                    : Events.getCurrentEvent() == 7
                                        ? LoanStatus.inProgress.titleColor
                                        : LoanStatus.locked.titleColor,
                              ),
                            if (controller.isEligible.value)
                              buildListItem(
                                icon: ImageConstants.loanLogo,
                                title: 'LOAN DETAILS',
                                context: context,
                                isJoinLine: true,
                                inProgress: Events.getCurrentEvent() == 9 ? true : false,
                                isDone: Events.getCurrentEvent() > 9 ? true : false,
                                scale: 17.sp,
                                status: Events.getCurrentEvent() > 9
                                    ? LoanStatus.completed.status
                                    : Events.getCurrentEvent() == 9
                                        ? LoanStatus.inProgress.status
                                        : LoanStatus.locked.status,
                                statusTextColor: Events.getCurrentEvent() > 9
                                    ? LoanStatus.completed.statusTextColor
                                    : Events.getCurrentEvent() == 9
                                        ? LoanStatus.inProgress.statusTextColor
                                        : LoanStatus.locked.statusTextColor,
                                joinLineColor: Events.getCurrentEvent() > 9
                                    ? LoanStatus.completed.joinLineColor
                                    : Events.getCurrentEvent() == 9
                                        ? LoanStatus.inProgress.joinLineColor
                                        : LoanStatus.locked.joinLineColor,
                                trailing: Events.getCurrentEvent() > 9
                                    ? LoanStatus.completed.trailingIcon
                                    : Events.getCurrentEvent() == 9
                                        ? LoanStatus.inProgress.trailingIcon
                                        : LoanStatus.locked.trailingIcon,
                                tittleColor: Events.getCurrentEvent() > 9
                                    ? LoanStatus.completed.titleColor
                                    : Events.getCurrentEvent() == 9
                                        ? LoanStatus.inProgress.titleColor
                                        : LoanStatus.locked.titleColor,
                              ),
                            if (controller.isEligible.value)
                              buildListItem(
                                icon: ImageConstants.incomeLogo,
                                title: 'EMPLOYMENT DETAILS',
                                context: context,
                                isJoinLine: true,
                                inProgress: Events.getCurrentEvent() == 10 ? true : false,
                                isDone: Events.getCurrentEvent() > 10 ? true : false,
                                scale: 4.9.sp,
                                status: Events.getCurrentEvent() > 10
                                    ? LoanStatus.completed.status
                                    : Events.getCurrentEvent() == 10
                                        ? LoanStatus.inProgress.status
                                        : LoanStatus.locked.status,
                                statusTextColor: Events.getCurrentEvent() > 10
                                    ? LoanStatus.completed.statusTextColor
                                    : Events.getCurrentEvent() == 10
                                        ? LoanStatus.inProgress.statusTextColor
                                        : LoanStatus.locked.statusTextColor,
                                joinLineColor: Events.getCurrentEvent() > 10
                                    ? LoanStatus.completed.joinLineColor
                                    : Events.getCurrentEvent() == 10
                                        ? LoanStatus.inProgress.joinLineColor
                                        : LoanStatus.locked.joinLineColor,
                                trailing: Events.getCurrentEvent() > 10
                                    ? LoanStatus.completed.trailingIcon
                                    : Events.getCurrentEvent() == 10
                                        ? LoanStatus.inProgress.trailingIcon
                                        : LoanStatus.locked.trailingIcon,
                                tittleColor: Events.getCurrentEvent() > 10
                                    ? LoanStatus.completed.titleColor
                                    : Events.getCurrentEvent() == 10
                                        ? LoanStatus.inProgress.titleColor
                                        : LoanStatus.locked.titleColor,
                              ),
                            if (controller.isEligible.value)
                              buildListItem(
                                icon: ImageConstants.uploadLogo,
                                title: 'DOCUMENT UPLOAD',
                                context: context,
                                isJoinLine: true,
                                inProgress: Events.getCurrentEvent() == 11 ? true : false,
                                isDone: Events.getCurrentEvent() > 11 ? true : false,
                                scale: 15.sp,
                                status: Events.getCurrentEvent() > 11
                                    ? LoanStatus.completed.status
                                    : Events.getCurrentEvent() == 11
                                        ? LoanStatus.inProgress.status
                                        : LoanStatus.locked.status,
                                statusTextColor: Events.getCurrentEvent() > 11
                                    ? LoanStatus.completed.statusTextColor
                                    : Events.getCurrentEvent() == 11
                                        ? LoanStatus.inProgress.statusTextColor
                                        : LoanStatus.locked.statusTextColor,
                                joinLineColor: Events.getCurrentEvent() > 11
                                    ? LoanStatus.completed.joinLineColor
                                    : Events.getCurrentEvent() == 11
                                        ? LoanStatus.inProgress.joinLineColor
                                        : LoanStatus.locked.joinLineColor,
                                trailing: Events.getCurrentEvent() > 11
                                    ? LoanStatus.completed.trailingIcon
                                    : Events.getCurrentEvent() == 11
                                        ? LoanStatus.inProgress.trailingIcon
                                        : LoanStatus.locked.trailingIcon,
                                tittleColor: Events.getCurrentEvent() > 11
                                    ? LoanStatus.completed.titleColor
                                    : Events.getCurrentEvent() == 11
                                        ? LoanStatus.inProgress.titleColor
                                        : LoanStatus.locked.titleColor,
                              ),
                            if (controller.isEligible.value)
                              buildListItem(
                                icon: ImageConstants.incomeLogo,
                                title: 'BANK DETAILS',
                                context: context,
                                isJoinLine: false,
                                inProgress: Events.getCurrentEvent() == 12 ? true : false,
                                isDone: Events.getCurrentEvent() > 12 ? true : false,
                                scale: 4.9.sp,
                                status: Events.getCurrentEvent() > 12
                                    ? LoanStatus.completed.status
                                    : Events.getCurrentEvent() == 12
                                        ? LoanStatus.inProgress.status
                                        : LoanStatus.locked.status,
                                statusTextColor: Events.getCurrentEvent() > 12
                                    ? LoanStatus.completed.statusTextColor
                                    : Events.getCurrentEvent() == 12
                                        ? LoanStatus.inProgress.statusTextColor
                                        : LoanStatus.locked.statusTextColor,
                                joinLineColor: Events.getCurrentEvent() > 12
                                    ? LoanStatus.completed.joinLineColor
                                    : Events.getCurrentEvent() == 12
                                        ? LoanStatus.inProgress.joinLineColor
                                        : LoanStatus.locked.joinLineColor,
                                trailing: Events.getCurrentEvent() > 12
                                    ? LoanStatus.completed.trailingIcon
                                    : Events.getCurrentEvent() == 12
                                        ? LoanStatus.inProgress.trailingIcon
                                        : LoanStatus.locked.trailingIcon,
                                tittleColor: Events.getCurrentEvent() > 12
                                    ? LoanStatus.completed.titleColor
                                    : Events.getCurrentEvent() == 12
                                        ? LoanStatus.inProgress.titleColor
                                        : LoanStatus.locked.titleColor,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (Events.getCurrentEvent() > 7)
                    SizedBox(
                      width: Get.width,
                      height: 45,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.sp),
                        child: Center(
                          child: SizedBox(
                            width: Get.width * 0.8,
                            height: 30.sp,
                            child: CustomButton(
                              onPressed: () {
                                dashbroadController.selectedIndex1.value = 0;
                                if (!controller.isEligible.value) {
                                  controller.checkEligiblity(isRedirect: true);
                                } else {
                                  Get.toNamed(RoutesName.PreviewScreen);
                                }
                                // Action when Preview Details is pressed
                              },
                              text: controller.isEligible.value
                                  ? 'PREVIEW DETAILS'
                                  : prefs.getString(SharedConstants.USER_TYPE).toString().contains("REPEAT") &&
                                          prefs.getString(SharedConstants.STEP_STAGE) == Events.REGISTER_NOW
                                      ? "RE-LOAN"
                                      : 'CHECK ELIGIBILITY',
                              isLoading: controller.loadingOnCheckEligiblity.value,
                              height: Get.height * 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  // SizedBox(
                  //   height: 20.sp,
                  // )
                ],
              );
      }),
    );
  }

  Widget buildListItem({
    required String icon,
    required String title,
    required BuildContext context,
    required bool isJoinLine,
    required bool isDone,
    required bool inProgress,
    required var scale,
    required Icon trailing,
    required Color joinLineColor,
    required String status,
    required Color statusTextColor,
    required Color tittleColor,
  }) {
    return GestureDetector(
      onTap: () {
        // print(isDone);
        if (inProgress) {
          if (kDebugMode) {
            print(inProgress);
          }
          Events.getNextEvent(prefs.getString(SharedConstants.STEP_STAGE) ?? '');
        }
        if (isDone) {
          dashbroadController.selectedIndex1.value = 0;
          Get.toNamed(RoutesName.PreviewScreen);
          // print("is done 1");
        }
        // Action when tapping on the item
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: Get.height * 0.12,
              decoration: BoxDecoration(
                color: Get.theme.brightness == Brightness.dark
                    ? Theme.of(context).highlightColor
                    : ColorConstants.surfaceLight,
                borderRadius: BorderRadius.circular(18.sp),
                boxShadow: Get.theme.brightness == Brightness.dark ? null : ColorConstants.softShadow,
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 15.sp,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 30.sp,
                  width: 30.sp,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Get.theme.brightness == Brightness.dark ? Theme.of(context).primaryColor : joinLineColor,
                          width: 8.sp),
                      shape: BoxShape.circle),
                  child: Image.asset(
                    icon,
                    scale: scale,
                  ),
                ),
                SizedBox(
                  width: 20.sp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(title,
                          style: TextStyle(
                              color: Get.theme.brightness == Brightness.dark ? Colors.white : tittleColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(status,
                          style: TextStyle(color: statusTextColor, fontSize: 15.sp, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                trailing,
                SizedBox(
                  width: 20.sp,
                )
              ])
              // trailing: Icon(Icons.arrow_forward),
              ),
          if (isJoinLine)
            Container(
              margin: EdgeInsets.only(left: 20.sp),
              height: 20.sp,
              width: 7.sp,
              color: Get.theme.brightness == Brightness.dark ? Theme.of(context).primaryColor : joinLineColor,
            ),
        ],
      ),
    );
  }
}

enum LoanStatus {
  inProgress(
    titleColor: ColorConstants.ink,
    status: 'IN PROGRESS',
    backgroundColor: ColorConstants.surfaceLight,
    statusTextColor: ColorConstants.primary,
    joinLineColor: ColorConstants.border,
    trailingIcon: Icon(
      Icons.arrow_forward_outlined,
      color: ColorConstants.primary,
    ),
  ),
  completed(
      titleColor: ColorConstants.ink,
      joinLineColor: ColorConstants.primary,
      status: 'Completed',
      backgroundColor: ColorConstants.surfaceLight,
      statusTextColor: ColorConstants.primary,
      trailingIcon: Icon(
        Icons.check_circle,
        color: ColorConstants.success,
        size: 22,
      )),
  locked(
    titleColor: ColorConstants.muted,
    joinLineColor: ColorConstants.border,
    status: 'Locked',
    backgroundColor: ColorConstants.surfaceLight,
    statusTextColor: ColorConstants.muted,
    trailingIcon: Icon(
      Icons.lock,
      color: ColorConstants.muted,
    ),
  );

  // getString() {
  //   switch (this) {
  //     case LoanStatus.inProgress:
  //       return 'IN PROGRESS';
  //     case LoanStatus.completed:
  //       return 'Completed';
  //     case LoanStatus.locked:
  //       return 'Locked';
  //   }
  // }

  final String status;
  final Color backgroundColor;
  final Color statusTextColor;
  final Color titleColor;
  final Color joinLineColor;
  final Icon trailingIcon;

  const LoanStatus({
    required this.status,
    required this.backgroundColor,
    required this.statusTextColor,
    required this.titleColor,
    required this.joinLineColor,
    required this.trailingIcon,
  });
}
