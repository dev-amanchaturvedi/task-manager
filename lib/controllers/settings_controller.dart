import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingsController extends GetxController {
  RxString themeMode = 'light'.obs;

  @override
  void onInit() {
    super.onInit();
    themeMode.value =
        Hive.box('preferences').get('themeMode', defaultValue: 'light');
  }

  void toggleTheme(bool isDarkMode) {
    final newTheme = isDarkMode ? 'dark' : 'light';
    Hive.box('preferences').put('themeMode', newTheme);
    themeMode.value = newTheme;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
