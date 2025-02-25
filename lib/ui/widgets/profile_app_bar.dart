import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/network_cashed_image.dart';

AppBar profileAppbar() {
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
    title: Column(
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
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.logout, color: Colors.white),
      ),
    ],
  );
}
