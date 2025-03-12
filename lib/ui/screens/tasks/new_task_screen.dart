import 'package:flutter/material.dart';
import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:rest_task_manager/data/model/task_count_wrapper_model.dart';
import 'package:rest_task_manager/data/model/task_list_count_model.dart';
import 'package:rest_task_manager/data/model/task_list_wrapper_model.dart';
import 'package:rest_task_manager/data/model/task_model.dart';
import 'package:rest_task_manager/data/network_caller/network_caller.dart';
import 'package:rest_task_manager/data/utility/app_urls.dart';
import 'package:rest_task_manager/ui/screens/tasks/add_new_task_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/show_shack_bar_message.dart';
import 'package:rest_task_manager/ui/widgets/task_item.dart';
import 'package:rest_task_manager/ui/widgets/task_summery_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;
  bool _getTaskCountInProgress = false;
  List<TaskModel> newTaskList = [];
  List<TaskListCountModel> taskListCount = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTaskList();
          _getTaskCount();
        },

        child: Padding(
          padding: EdgeInsets.all(16),
          child: Visibility(
            visible: _getNewTaskInProgress == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: Column(
              children: [
                _buildSummerySection(),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskItem: newTaskList[index],
                        onDeleteTask: () {
                          _getNewTaskList();
                          _getTaskCount();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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
      child: Visibility(
        visible: _getTaskCountInProgress == false,
        replacement: Center(child: CircularProgressIndicator()),
        child: Row(
          children:
              taskListCount.map((element) {
                return TaskSummeryCard(
                  title: element.status ?? "Unknown",
                  count: element.count.toString(),
                );
              }).toList(),
        ),
      ),
    );
  }

  void _onTapFloatingActionButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
  }

  Future<void> _getNewTaskList() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
      AppUrls.newTaskList,
    );

    if (response.isSuccess && response.statusCode == 200) {
      _getNewTaskInProgress = false;

      TaskListWrapperModel taskListWraperModel = TaskListWrapperModel.fromJson(
        response.responseData,
      );
      newTaskList = taskListWraperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage ?? "No Task Found");
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getTaskCount() async {
    _getTaskCountInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
      AppUrls.countTaskList,
    );

    if (response.isSuccess && response.statusCode == 200) {
      TaskCountWrapperModel taskCountWrapperModel =
          TaskCountWrapperModel.fromJson(response.responseData);
      taskListCount = taskCountWrapperModel.taskListCountModel ?? [];
    }

    _getTaskCountInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
