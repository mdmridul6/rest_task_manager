import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/screens/tasks/new_task_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/task_item.dart';
import 'package:rest_task_manager/ui/widgets/task_summery_card.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummerySection(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TaskItem();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.whiteColor,
        onPressed: _onTapFloatingActionButton,
        label: Text('Add Task'),
        icon: Icon(Icons.add),
      ),
    );
  }

  SingleChildScrollView _buildSummerySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummeryCard(title: 'New Task', count: '34'),
          TaskSummeryCard(title: 'Completed', count: '34'),
          TaskSummeryCard(title: 'In Progress', count: '34'),
          TaskSummeryCard(title: 'Cancel', count: '34'),
        ],
      ),
    );
  }
  void _onTapFloatingActionButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewTaskScreen()),
    );
  }
}
