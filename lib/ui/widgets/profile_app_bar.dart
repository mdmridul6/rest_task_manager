import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/controller/auth_controller.dart';
import 'package:rest_task_manager/ui/screens/auth/sing_in_screen.dart';
import 'package:rest_task_manager/ui/screens/update_profile_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';

AppBar profileAppBar(context, [bool isUpdateProfile = false]) {
  return AppBar(
    backgroundColor: AppColor.primaryColor,
    leading: Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.memory(
            base64Decode(AuthController.userData?.photo ?? ""),
          ),
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
          Text(
            AuthController.userData?.fullName ?? '',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            AuthController.userData?.email ?? '',
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
          await AuthController.clearAllData();
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
