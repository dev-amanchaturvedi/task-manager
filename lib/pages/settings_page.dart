import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controllers/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Settings'),
      ),
      body: Obx(() {
        return SwitchListTile(
          title: const Text('Dark Mode'),
          value: controller.themeMode.value == 'dark',
          onChanged: (value) => controller.toggleTheme(value),
        );
      }),
    );
  }
}
