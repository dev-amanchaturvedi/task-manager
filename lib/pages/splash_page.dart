import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:task_manager/controllers/task_controller.dart';
import 'package:task_manager/pages/task_home_page.dart';

class SplashScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () async {
      await taskController.initDatabase();
      Get.off(
        () => TaskHomePage(),
      );
    });
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/splash.json'),
          ],
        ),
      ),
    );
  }
}
