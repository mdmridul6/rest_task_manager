import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rest_task_manager/ui/utility/image_assets.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});

  final Widget child;

  
  Future<void> _moveToNextScreen() async{
    await Future.delayed(Duration(seconds: 2));

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          ImageAssets.backgroundSvg,
          height: double.maxFinite,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  }
}
