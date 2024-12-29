import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_manager/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDir.path);
  await Hive.openBox('preferences');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1242, 2208),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            primaryColor: Colors.teal,
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.teal,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 70.sp,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.teal, foregroundColor: Colors.white),
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: 80.sp, color: Colors.black),
              bodyMedium: TextStyle(
                  fontSize: 70.sp,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold),
              bodySmall: TextStyle(
                  fontSize: 55.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            cardTheme: CardTheme(
              color: Colors.teal.shade50,
              shadowColor: Colors.teal.shade100,
            ),
            buttonTheme: const ButtonThemeData(buttonColor: Colors.teal),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.grey.shade900,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 70.sp,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white),
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: 80.sp, color: Colors.white),
              bodyMedium: TextStyle(
                  fontSize: 70.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              bodySmall: TextStyle(
                  fontSize: 55.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            cardTheme: CardTheme(
              color: Colors.grey.shade800,
              shadowColor: Colors.black,
            ),
            buttonTheme: const ButtonThemeData(buttonColor: Colors.deepPurple),
          ),
          themeMode:
              Hive.box('preferences').get('themeMode', defaultValue: 'light') ==
                      'light'
                  ? ThemeMode.light
                  : ThemeMode.dark,
          home: SplashScreen(),
        );
      },
    );
  }
}
