import 'package:get/get.dart';

import '../main.dart';
import '../routes/routes_names.dart';
import '../utils/events.dart';
import '../utils/shared_constants.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(milliseconds: GetPlatform.isIOS ? 2000 : 2000), () {
      if (prefs.getBool(SharedConstants.ISLOGIN).toString() == "null" ||
          (prefs.getBool(SharedConstants.ISLOGIN) == false)) {
        Get.toNamed(RoutesName.LoginScreen);
      } else {
        if (prefs.getString(SharedConstants.STEP_STAGE) == Events.PANCARD) {
          Get.offAllNamed(RoutesName.PanScreen);
        } else {
          Get.offAllNamed(RoutesName.DashbroadScreen);
        }
      }
    });
    super.onInit();
  }
}
