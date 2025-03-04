import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/screens/tasks/new_task_screen.dart';
import 'package:rest_task_manager/ui/screens/tasks/canceled_task_screen.dart';
import 'package:rest_task_manager/ui/screens/tasks/completed_task_screen.dart';
import 'package:rest_task_manager/ui/screens/tasks/in_progress_task_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/profile_app_bar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedTabIndex = 0;

  final List<Widget> _screen = [
    NewTaskScreen(),
    CanceledTaskScreen(),
    InProgressTaskScreen(),
    CompletedTaskScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: _screen[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          if (mounted) {
            _selectedTabIndex = index;
            setState(() {});
          }
        },
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'All Task'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: 'Canceled'),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bike_rounded),
            label: 'In Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Complete',
          ),
        ],
      ),
    );
  }
}
