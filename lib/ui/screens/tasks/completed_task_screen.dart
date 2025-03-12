import 'package:flutter/material.dart';
import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:rest_task_manager/data/model/task_list_wrapper_model.dart';
import 'package:rest_task_manager/data/model/task_model.dart';
import 'package:rest_task_manager/data/network_caller/network_caller.dart';
import 'package:rest_task_manager/data/utility/app_urls.dart';
import 'package:rest_task_manager/ui/widgets/show_shack_bar_message.dart';
import 'package:rest_task_manager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool getCompletedTaskInProgress = false;
  List<TaskModel> completedTaskList = [];

@override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: getCompletedTaskInProgress == false,
        replacement: Center(child: CircularProgressIndicator()),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: getCompletedTaskInProgress == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: ListView.builder(
              itemCount: completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskItem(taskItem: completedTaskList[index], onDeleteTask: () {
                  _getCompletedTaskList();
                 },);
              },
            ),
          ),
        ),
      ),
    );
  }

    Future<void> _getCompletedTaskList() async {
    getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
      AppUrls.completeTaskList,
    );

    if (response.isSuccess && response.statusCode == 200) {
      getCompletedTaskInProgress = false;

      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(
        response.responseData,
      );
      completedTaskList = taskListWrapperModel.taskList ?? [];
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
