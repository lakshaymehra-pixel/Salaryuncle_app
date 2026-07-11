import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/controller/dashbroadController.dart';
import 'package:tejas_loan/controller/internet_connectivity_controller.dart';
import 'package:tejas_loan/custom_widgets/custom_drawer.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/views/home_page.dart';
import 'package:tejas_loan/views/all_leads_page.dart';
import 'package:tejas_loan/views/repayment_history_page.dart';
import 'package:tejas_loan/views/profile_page.dart';

import '../controller/status_controller.dart';
import '../services/api_constant/api_constants.dart';
import '../utils/color_constants.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';

class DashbroadPage extends GetView<DashbroadController> {
  DashbroadController controller = Get.put(DashbroadController());
  StatusController controller1 = Get.put(StatusController());
  ConnectionManagerController connectionManagerController = Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    if (!APIConstants.isModeDevelopment()) checkVersion(context);
    List<Widget> widgetOptions = <Widget>[
      HomePage(),
      AllLeadsPage(),
      RepaymentHistoryPage(),
      const ProfilePage(),
    ];
    return Obx(() {
      return AdvancedDrawer(
        backdrop: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                  // height: GetPlatform.isIOS ? 57.sp : 55.sp,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  )),
            ),
            Expanded(
              flex: 17,
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
        disabledGestures: false,
        openRatio: .8,
        childDecoration: BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: ColorConstants.primary.withOpacity(0.18),
              blurRadius: 20.sp,
              offset: Offset(0, 8.sp),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(25.sp)),
        ),
        drawer: CustomDrawer(
          advancedDrawerController: controller.advancedDrawerController.value,
        ),
        child: Scaffold(
            bottomNavigationBar: _SuBottomNav(
              currentIndex: controller.selectedIndex.value,
              onTap: controller.onItemTapped,
              onFab: () {
                // New Loan — continue the application flow (or go Home if complete).
                if (prefs.getString(SharedConstants.STEP_STAGE) != Events.COMPLETED) {
                  Events.getNextEvent(prefs.getString(SharedConstants.STEP_STAGE) ?? "");
                } else {
                  controller.onItemTapped(0);
                }
              },
            ),
            // Mockup has no top app bar — each screen renders its own header.
            appBar: null,
            backgroundColor: ColorConstants.scaffoldLight,
            extendBody: true,
            body: DoubleBackToCloseApp(
                snackBar: SnackBar(
                    elevation: 10,
                    content: const Text("Press again to exit !!"),
                    backgroundColor: ColorConstants.primary,
                    margin: const EdgeInsets.all(15),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    )),
                // child: _widgetOptions.elementAt(_selectedIndex),
                child: widgetOptions.elementAt(controller.selectedIndex.value))),
      );
    });
  }
}

/// Floating dark-green glass dock with a gold center FAB (reference mockup).
/// Left: Home, Application. Center gold FAB = New Loan. Right: Status, Support.
/// Active tab expands to show its label in gold.
class _SuBottomNav extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final VoidCallback onFab;

  const _SuBottomNav({required this.currentIndex, required this.onTap, required this.onFab});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(14.sp, 0, 14.sp, GetPlatform.isAndroid ? 14.sp : 20.sp),
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
      decoration: BoxDecoration(
        color: ColorConstants.greenDeep.withOpacity(0.94),
        borderRadius: BorderRadius.circular(28.sp),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(color: ColorConstants.greenDeep.withOpacity(0.4), blurRadius: 30, offset: const Offset(0, 14)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(0, Icons.home_rounded, 'Home'),
          _navItem(1, Icons.account_balance_wallet_rounded, 'Loans'),
          // Gold center FAB (fixed size so it doesn't scale huge)
          GestureDetector(
            onTap: onFab,
            child: Container(
              height: 52,
              width: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: ColorConstants.goldGradient,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: ColorConstants.gold.withOpacity(0.5), blurRadius: 18, offset: const Offset(0, 6))],
              ),
              child: const Icon(Icons.add_rounded, color: Color(0xFF0B3D2E), size: 26),
            ),
          ),
          _navItem(2, Icons.bar_chart_rounded, 'Payments'),
          _navItem(3, Icons.person_rounded, 'Profile'),
        ],
      ),
    );
  }

  Widget _navItem(int i, IconData icon, String label) {
    final bool active = i == currentIndex;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: active ? 11.sp : 8.sp),
        decoration: BoxDecoration(
          color: active ? Colors.white.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 21.sp, color: active ? ColorConstants.goldText : Colors.white.withOpacity(0.55)),
            if (active) ...[
              SizedBox(width: 6.sp),
              Text(label,
                  style: TextStyle(color: ColorConstants.goldText, fontSize: 11.5.sp, fontWeight: FontWeight.w700)),
            ],
          ],
        ),
      ),
    );
  }
}
//Padding(
//                         padding:
//                             EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10),
//                         child: Card(
//                           elevation: 4,
//                           color: Color(ColorConstants.secondaryColor),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.sp)),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 10.sp, horizontal: 13.sp),
//                             //getPadding(),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: Get.width,
//                                   alignment: Alignment.center,
//                                   child: RichText(
//                                     text: TextSpan(children: <TextSpan>[
//                                       TextSpan(
//                                         text: "LOAN APPLICATION - ",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16.sp),
//                                       ),
//                                       TextSpan(
//                                         text: "( ",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15.sp),
//                                       ),
//                                       TextSpan(
//                                         text: controller
//                                                     .allLead.value[index].status
//                                                     .toString() ==
//                                                 "LEAD-NEW"
//                                             ? "INCOMPLETE"
//                                             : controller.allLead.value[index]
//                                                     .status ??
//                                                 "INCOMPLETE",
//                                         style: TextStyle(
//                                             color: controller.allLead
//                                                         .value[index].status
//                                                         .toString() ==
//                                                     "DISBURSED"
//                                                 ? Colors.greenAccent
//                                                 : controller
//                                                             .allLead
//                                                             .value[index]
//                                                             .status ==
//                                                         "CLOSED"
//                                                     ? Colors
//                                                         .greenAccent.shade400
//                                                     : controller
//                                                                 .allLead
//                                                                 .value[index]
//                                                                 .status ==
//                                                             "REJECT"
//                                                         ? Colors.red
//                                                         : Colors.orange,
//                                             fontSize: 15.sp),
//                                       ),
//                                       TextSpan(
//                                         text: " )",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 15.sp),
//                                       ),
//                                     ]),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10.sp,
//                                 ),
//                                 Row(
//                                   children: [
//                                     // CircleAvatar(
//                                     //   radius: 24.sp,
//                                     //   foregroundImage: NetworkImage(
//                                     //       "https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpg"),
//                                     // ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           border:
//                                               Border.all(color: Colors.white),
//                                           shape: BoxShape.circle),
//                                       height: 35.sp,
//                                       width: 35.sp,
//                                       child: Icon(
//                                         Icons.person,
//                                         color: Colors.white,
//                                         size: 30.sp,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 15.sp,
//                                     ),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                         RichText(
//                                           text: TextSpan(children: <TextSpan>[
//                                             TextSpan(
//                                               text: "NAME : ",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15.sp),
//                                             ),
//                                             TextSpan(
//                                               text: prefs.getString(
//                                                       SharedConstants.NAME) ??
//                                                   "- - - -",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15.sp),
//                                             ),
//                                           ]),
//                                         ),
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                         RichText(
//                                           text: TextSpan(children: <TextSpan>[
//                                             TextSpan(
//                                               text: "APPLY DATE : ",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15.sp),
//                                             ),
//                                             TextSpan(
//                                               text: controller.df.format(
//                                                   DateTime.parse(controller
//                                                           .allLead
//                                                           .value[index]
//                                                           .leadEntryDate ??
//                                                       "0000-00-00 00:00:00")),
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15.sp),
//                                             ),
//                                           ]),
//                                         ),
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                         RichText(
//                                           text: TextSpan(children: <TextSpan>[
//                                             TextSpan(
//                                               text: "LOAN AMT : ",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15.sp),
//                                             ),
//                                             TextSpan(
//                                               text: controller
//                                                       .allLead
//                                                       .value[index]
//                                                       .loanAmount ??
//                                                   "- - - -",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 15.sp),
//                                             ),
//                                           ]),
//                                         ),
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                         RichText(
//                                           text: TextSpan(children: <TextSpan>[
//                                             TextSpan(
//                                               text: "APPLICATION No: ",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 14.sp),
//                                             ),
//                                             TextSpan(
//                                               text: controller
//                                                       .allLead
//                                                       .value[index]
//                                                       .application_no ??
//                                                   "- - - -",
//                                               style: TextStyle(
//                                                   // overflow:
//                                                   //     TextOverflow.ellipsis,
//                                                   color: Colors.white,
//                                                   fontSize: 14.sp),
//                                             ),
//                                           ]),
//                                         ),
//                                         SizedBox(
//                                           height: 10.sp,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10.sp,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     controller.allLead.value[index].status
//                                                 .toString() !=
//                                             "LEAD-NEW"
//                                         ? Container()
//                                         : InkWell(
//                                             onTap: () {
//                                               controller.getLeadStatus(
//                                                   controller.allLead
//                                                       .value[index].leadId
//                                                       .toString());
//                                             },
//                                             child: Card(
//                                               color: Colors.transparent,
//                                               shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   side: BorderSide(
//                                                       color: Colors.white,
//                                                       width: 2.sp)),
//                                               // child: Container(
//                                               //     alignment: Alignment.center,
//                                               //     width: Get.width * 0.15,
//                                               //     height: Get.height * 0.03,
//                                               //     decoration: BoxDecoration(
//                                               //       borderRadius: BorderRadius.all(
//                                               //           Radius.circular(5)),
//                                               //     ),
//                                               //     child: controller
//                                               //             .loadingOnApply.value
//                                               //         ? Center(
//                                               //             child: SizedBox(
//                                               //                 height:
//                                               //                     Get.height * 0.02,
//                                               //                 width:
//                                               //                     Get.width * 0.1,
//                                               //                 child:
//                                               //                     CircularProgressIndicator()),
//                                               //           )
//                                               //         : Text("Apply Now",
//                                               //             style: TextStyle(
//                                               //                 fontSize: 12.sp,
//                                               //                 color:
//                                               //                     Colors.white))
//                                               // ),
//                                             )),
//                                     InkWell(
//                                         onTap: () {
//                                           Get.toNamed(
//                                               RoutesName.DashDetailScreen,
//                                               arguments: controller
//                                                   .allLead.value[index].leadId
//                                                   .toString());
//                                         },
//                                         child: Card(
//                                           color: Colors.transparent,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               side: BorderSide(
//                                                   color: Colors.white,
//                                                   width: 2.sp)),
//                                           child: Container(
//                                               alignment: Alignment.center,
//                                               width: Get.width * 0.15,
//                                               height: Get.height * 0.03,
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(5)),
//                                               ),
//                                               child: Text("View Details",
//                                                   style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       color: Colors.white))),
//                                         )),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
