import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rest_task_manager/ui/utility/image_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            ImageAssets.backgroundSvg,
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Center(child: SvgPicture.asset(ImageAssets.logoSvg)),
        ],
      ),
    );
  }
}
