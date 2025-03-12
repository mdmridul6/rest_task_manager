import 'package:flutter/material.dart';
import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:rest_task_manager/data/model/task_list_wrapper_model.dart';
import 'package:rest_task_manager/data/model/task_model.dart';
import 'package:rest_task_manager/data/network_caller/network_caller.dart';
import 'package:rest_task_manager/data/utility/app_urls.dart';
import 'package:rest_task_manager/ui/widgets/show_shack_bar_message.dart';
import 'package:rest_task_manager/ui/widgets/task_item.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool getCanceledTaskInProgress = false;
  List<TaskModel> canceledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCanceledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: getCanceledTaskInProgress == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.builder(
            itemCount: canceledTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskItem: canceledTaskList[index],
                onDeleteTask: () {
                  _getCanceledTaskList();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCanceledTaskList() async {
    getCanceledTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
      AppUrls.canceledTaskList,
    );

    if (response.isSuccess && response.statusCode == 200) {
      getCanceledTaskInProgress = false;

      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(
        response.responseData,
      );
      canceledTaskList = taskListWrapperModel.taskList ?? [];
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
