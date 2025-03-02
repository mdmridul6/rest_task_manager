import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rest_task_manager/ui/controller/auth_controller.dart';
import 'package:rest_task_manager/ui/screens/auth/sing_in_screen.dart';
import 'package:rest_task_manager/ui/screens/tasks/main_bottom_nav_screen.dart';
import 'package:rest_task_manager/ui/utility/image_assets.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isLogin = await AuthController.checkAuthState();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => isLogin ? MainBottomNavScreen() : SingInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(child: SvgPicture.asset(ImageAssets.logoSvg)),
      ),
    );
  }
}
