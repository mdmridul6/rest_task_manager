import 'package:rest_task_manager/data/model/task_model.dart';

class TaskListWrapperModel {
  bool? status;
  List<TaskModel>? taskList;
  String? errorMessage;

  TaskListWrapperModel({this.status, this.taskList, this.errorMessage});

  TaskListWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskModel>[];
      json['data'].forEach((v) {
        taskList!.add(TaskModel.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskList != null) {
      data['data'] = taskList!.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = errorMessage;
    return data;
  }
}

