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
        // Resume at the stage the server last reported instead of assuming
        // anything but PAN means the application is finished.
        final stage = prefs.getString(SharedConstants.STEP_STAGE) ?? "";
        if (stage.isEmpty || stage == Events.COMPLETED) {
          Get.offAllNamed(RoutesName.DashbroadScreen);
        } else {
          Events.getNextEvent(stage);
        }
      }
    });
    super.onInit();
  }
}
