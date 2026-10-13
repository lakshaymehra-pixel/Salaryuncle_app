import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tejas_loan/main.dart';
import 'package:tejas_loan/utils/image_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/color_constants.dart';
import '../utils/shared_constants.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.sp),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.sp),
              child: SizedBox(
                height: Get.height * 0.2,
                width: Get.width,
                child: Image.asset(
                  ImageConstants.support,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 22.sp),
            Text(
              'Contact Detail',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: FaIcon(
                FontAwesomeIcons.phone,
                size: 22,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Call Us',
              value: prefs.getString(SharedConstants.CONTACT_US_NUMBER) ?? SharedConstants.Company_Number,
              onTap: () async {
                final Uri telLaunchUri = Uri(
                  scheme: 'tel',
                  path: prefs.getString(SharedConstants.CONTACT_US_NUMBER) ?? SharedConstants.Company_Number,
                );
                launchUrl(telLaunchUri);
              },
            ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: FaIcon(
                FontAwesomeIcons.whatsapp,
                size: 22,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Text Us',
              value: prefs.getString(SharedConstants.CONTACT_US_WHATSAPP) ?? SharedConstants.Company_WaNumber,
              onTap: () async {
                final Uri whatsAppLaunchUri = Uri.parse(
                    "https://api.whatsapp.com/send?phone=${prefs.getString(SharedConstants.CONTACT_US_WHATSAPP) ?? SharedConstants.Company_WaNumber}&text=Hi");
                launchUrl(whatsAppLaunchUri);
              },
            ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: Icon(
                size: 22,
                Icons.mail,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Email Us',
              value: prefs.getString(SharedConstants.CONTACT_US_EMAIL) ?? SharedConstants.Company_Email,
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: prefs.getString(SharedConstants.CONTACT_US_EMAIL) ?? SharedConstants.Company_Email,
                );

                launchUrl(emailLaunchUri);
              },
            ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: Icon(
                size: 22,
                Icons.alarm_on_rounded,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Available Time',
              value: '9:30 AM - 10:30 PM',
              // Informational only - null keeps the InkWell from rippling as
              // though it were going to do something.
              onTap: null,
            ),
            // SizedBox(height: 13.sp),
            // _buildDivider(
            //   context: context,
            //   icon: Icon(
            //     size: 22,
            //     FontAwesomeIcons.rankingStar,
            //     color: Theme.of(context).primaryColor,
            //   ),
            //   title: 'Give Rating & Review',
            //   value: 'App Store / Play Store',
            //   onTap: () async {
            //     final InAppReview inAppReview = InAppReview.instance;
            //
            //     if (await inAppReview.isAvailable()) {
            //       // inAppReview.requestReview();
            //       inAppReview.openStoreListing(appStoreId: '');
            //     }
            //   },
            // ),
            SizedBox(height: 13.sp),
            _buildDivider(
              context: context,
              icon: FaIcon(
                FontAwesomeIcons.link,
                size: 22,
                color: Theme.of(context).primaryColor,
              ),
              title: 'Website',
              value: SharedConstants.Company_Website,
              onTap: () async {
                final Uri whatsAppLaunchUri = Uri.parse(SharedConstants.Company_Website);
                launchUrl(whatsAppLaunchUri, mode: LaunchMode.externalApplication);
              },
            ),
            SizedBox(height: 20.sp),
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
              decoration: BoxDecoration(
                color: ColorConstants.cardTintLight,
                borderRadius: BorderRadius.circular(14.sp),
                border: Border.all(color: ColorConstants.border),
              ),
              child: Text(
                'Our customer support team is available [9:30AM-10:30PM] to assist you with any inquiries or concerns. Feel free to reach out - we\'re always ready to lend a helping hand!',
                style: TextStyle(
                  fontSize: 14.5.sp,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.body,
                ),
              ),
            ),
            SizedBox(height: 22.sp),
            Text(
              SharedConstants.Company_Name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 13.sp),
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
              decoration: BoxDecoration(
                color: ColorConstants.surfaceLight,
                borderRadius: BorderRadius.circular(14.sp),
                border: Border.all(color: ColorConstants.border),
                boxShadow: ColorConstants.softShadow,
              ),
              child: Row(
                children: [
                  Container(
                    height: 53,
                    width: 53,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.cardTintLight,
                    ),
                    child: Icon(
                      Icons.map,
                      color: ColorConstants.primary,
                      size: 25,
                    ),
                  ),
                  SizedBox(
                    width: 15.sp,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        var uri = Uri.parse(SharedConstants.gmaps);
                        if (!await launchUrl(uri)) {
                          throw Exception('Could not launch $uri');
                        }
                      },
                      child: Text(
                        SharedConstants.Company_Address,
                        style: TextStyle(
                          fontSize: 15.sp,
                          height: 1.35,
                          color: ColorConstants.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.sp),
            Text(
              'Connect with us on social media',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: ColorConstants.ink,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 16.sp),
              decoration: BoxDecoration(
                color: ColorConstants.surfaceLight,
                borderRadius: BorderRadius.circular(14.sp),
                border: Border.all(color: ColorConstants.border),
                boxShadow: ColorConstants.softShadow,
              ),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    var uri = Uri.parse(SharedConstants.facebook);

                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: CircleAvatar(
                    radius: 18.sp,
                    foregroundImage: const AssetImage(ImageConstants.facebook),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var uri = Uri.parse(SharedConstants.instagram);

                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: CircleAvatar(
                    radius: 18.sp,
                    foregroundImage: const AssetImage(ImageConstants.instagram),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var uri = Uri.parse(SharedConstants.twitter);

                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: CircleAvatar(
                    radius: 18.sp,
                    foregroundImage: const AssetImage(ImageConstants.twitter),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var uri = Uri.parse(SharedConstants.youtube);
                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: CircleAvatar(
                    radius: 18.sp,
                    foregroundImage: const AssetImage(ImageConstants.youtube),
                  ),
                ),
              ],
            ),
            ), SizedBox(height: 53),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider({
    required String title,
    required String value,
    required Widget icon,
    required BuildContext context,
    required Function()? onTap,
  }) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
      decoration: BoxDecoration(
        color: ColorConstants.surfaceLight,
        borderRadius: BorderRadius.circular(14.sp),
        border: Border.all(color: ColorConstants.border),
        boxShadow: ColorConstants.softShadow,
      ),
      child: Row(
        children: [
          Container(
            height: 53,
            width: 53,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstants.cardTintLight,
            ),
            child: icon,
          ),
          SizedBox(
            width: 20.sp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: ColorConstants.muted,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                InkWell(
                  onTap: onTap,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: ColorConstants.primary,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
