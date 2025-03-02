import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/controller/auth_controller.dart';
import 'package:rest_task_manager/ui/screens/auth/sing_in_screen.dart';
import 'package:rest_task_manager/ui/screens/update_profile_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/network_cashed_image.dart';

AppBar profileAppBar(context, [bool isUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColor.primaryColor,
    leading: Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        child: NetworkCashedImage(
          url:
              'https://www.torrentbd.net/posters/C1dcoocS8XLX4WZpxZRfDwYY32176689.jpg',
        ),
      ),
    ),
    title: GestureDetector(
      onTap: () {
        if (isUpdateProfile == true) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jon doe', style: TextStyle(fontSize: 16, color: Colors.white)),
          Text(
            'jone@gmail.com',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () async {
          // AuthController.clearAllData();
          final data = await AuthController.getUserData();
          debugPrint('=======================================================');
          debugPrint(data!.firstName);
          debugPrint('=======================================================');

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SingInScreen()),
            (route) => false,
          );
        },
        icon: Icon(Icons.logout, color: Colors.white),
      ),
    ],
  );
}
