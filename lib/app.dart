import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/screens/splash_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.globalKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: _lightThemeData(),
      themeMode: ThemeMode.system,
    );
  }

  ThemeData _lightThemeData() {
    return ThemeData(
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
      // brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderSide: BorderSide.none),
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
