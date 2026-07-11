// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// import '../utils/color_constants.dart';
//
// AnimatedNotchBottomBar CustomNavBar(
//     {required NotchBottomBarController notchBottomBarController,
//     required void Function(int) onTap,
//     required PageController pageController}) {
//   return AnimatedNotchBottomBar(
//     /// Provide NotchBottomBarController
//     notchBottomBarController: notchBottomBarController,
//     showLabel: true,
//     textOverflow: TextOverflow.visible,
//     maxLine: 1,
//     shadowElevation: 5,
//     kBottomRadius: 20.sp,
//     color: Colors.white,
//     notchShader: const SweepGradient(
//       startAngle: 0,
//       endAngle: 3.14 / 2,
//       colors: [
//         Color(ColorConstants.tertiaryColor),
//         Color(ColorConstants.secondaryColor),
//         Color(ColorConstants.primaryColor)
//       ],
//       tileMode: TileMode.mirror,
//     ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
//
//     /// restart app if you change removeMargins
//     removeMargins: false,
//     bottomBarWidth: 500,
//     showShadow: true,
//     durationInMilliSeconds: 300,
//
//     itemLabelStyle: const TextStyle(fontSize: 10),
//
//     elevation: 1,
//     bottomBarItems: const [
//       BottomBarItem(
//         inActiveItem: Icon(
//           Icons.home_filled,
//           color: Colors.blueGrey,
//         ),
//         activeItem: Icon(
//           Icons.home_filled,
//           color: Colors.white,
//         ),
//         itemLabel: 'Home',
//       ),
//       BottomBarItem(
//         inActiveItem: Icon(Icons.list_alt_rounded, color: Colors.blueGrey),
//         activeItem: Icon(
//           Icons.list_alt_rounded,
//           color: Colors.white,
//         ),
//         itemLabel: 'All Leads',
//       ),
//       BottomBarItem(
//         inActiveItem: Icon(
//           Icons.list_outlined,
//           color: Colors.blueGrey,
//         ),
//         activeItem: Icon(
//           Icons.list_outlined,
//           color: Colors.white,
//         ),
//         itemLabel: 'Status',
//       ),
//       BottomBarItem(
//         inActiveItem: Icon(
//           Icons.person,
//           color: Colors.blueGrey,
//         ),
//         activeItem: Icon(
//           Icons.person,
//           color: Colors.white,
//         ),
//         itemLabel: 'Support',
//       ),
//     ],
//     onTap: onTap,
//     kIconSize: 24.0,
//   );
// }
