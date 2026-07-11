import 'package:flutter/material.dart';
import 'package:tejas_loan/utils/shared_constants.dart';

import '../main.dart';

class ImageConstants {
  static const logo = 'lib/images/logo.png';
  static const logo_gif = 'lib/images/SOT_LOGO_GIF.gif';
  static const logo_gif_light = 'lib/images/SOT_gif_white.gif';
  static const cibil = 'lib/images/speedometer.png';
  static const cibil1 = 'lib/images/check_cibil.png';
  static const calculator = 'lib/images/management.png';
  static const twitter = 'lib/images/twitter.png';
  static const youtube = 'lib/images/youtube.png';
  static const instagram = 'lib/images/instagram.png';
  static const facebook = 'lib/images/facebook.png';
  static const banner = 'lib/images/banner.jpg';
  static const banner2 = 'lib/images/banner2.jpg';
  static const registerPageLogo = 'lib/images/registerpage.jpg';
  static const panCardLogo = 'lib/images/id-card.png';
  static const incomeLogo = 'lib/images/income.png';
  static const personalLogo = 'lib/images/profile.png';
  static const residenceLogo = 'lib/images/residence.png';
  static const uploadLogo = 'lib/images/file.png';
  static const loanLogo = 'lib/images/loan.png';
  static const loanLogo1 = 'lib/images/loan1.png';
  static const support = 'lib/images/support.png';
  static const CompanyLogo = 'lib/images/SL_LOGO_DARK.png';
  static const PhotoIcon = 'lib/images/photo_icon.png';
  static const Photo = 'lib/images/photos.png';
  static const Feedback = 'lib/images/feedback.jpg';
  static const Page1 = 'lib/images/PAGE-1.png';
  static const Page2 = 'lib/images/PAGE-2.png';
  static const Page3 = 'lib/images/PAGE-3.png';
  static const DotBorder = 'lib/images/dotborder.png';
  static const CompanyLogoWhite = 'lib/images/SL_LOGO_WHITE.png';

  static String getAppLogo(BuildContext context) {
    if ((prefs.getBool(SharedConstants.THEME) ?? false)) {
      return ImageConstants.CompanyLogoWhite;
    } else {
      return ImageConstants.CompanyLogo;
    }
  }

  static String getAppLogoForAppBar(BuildContext context) {
    if (!(prefs.getBool(SharedConstants.THEME) ?? false)) {
      return ImageConstants.CompanyLogoWhite;
    } else {
      return ImageConstants.CompanyLogo;
    }
  }
}
