import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/screens/splash_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: _lightThemeData(),
      themeMode: ThemeMode.system,
    );
  }

  ThemeData _lightThemeData() {
    return ThemeData(
      // brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: AppColor.whiteColor,
        hintStyle: TextStyle(color: Colors.grey.shade400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.whiteColor,
          fixedSize: Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
