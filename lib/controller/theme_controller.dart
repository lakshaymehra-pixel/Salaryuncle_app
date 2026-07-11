import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tejas_loan/main.dart';

import '../utils/shared_constants.dart';

class ThemeController extends GetxController {
  var isDarkMode = (prefs.getBool(SharedConstants.THEME) ?? false).obs;

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool isOn) {
    isDarkMode.value = isOn;
    Get.changeThemeMode(isOn ? ThemeMode.dark : ThemeMode.light);
    prefs.setBool(SharedConstants.THEME, isOn);

  }
}
