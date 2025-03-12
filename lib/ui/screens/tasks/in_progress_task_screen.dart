import 'package:flutter/material.dart';
import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:rest_task_manager/data/model/task_list_wrapper_model.dart';
import 'package:rest_task_manager/data/model/task_model.dart';
import 'package:rest_task_manager/data/network_caller/network_caller.dart';
import 'package:rest_task_manager/data/utility/app_urls.dart';
import 'package:rest_task_manager/ui/widgets/show_shack_bar_message.dart';
import 'package:rest_task_manager/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool getInProgressTaskInProgress = false;
  List<TaskModel> inProgressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getInProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: inProgressTaskList.length,
        itemBuilder: (context, index) {
          return TaskItem(taskItem: inProgressTaskList[index], onDeleteTask: () { 
            _getInProgressTaskList();
           },);
        },
      ),
    );
  }

  Future<void> _getInProgressTaskList() async {
    getInProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
      AppUrls.inProgressTaskList,
    );

    if (response.isSuccess && response.statusCode == 200) {
      getInProgressTaskInProgress = false;

      TaskListWrapperModel taskListWraperModel = TaskListWrapperModel.fromJson(
        response.responseData,
      );
      inProgressTaskList = taskListWraperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage ?? "No Task Found");
      }
    }
    if (mounted) {
      setState(() {});
    }
  }
}
