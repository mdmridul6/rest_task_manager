import 'package:rest_task_manager/data/model/task_list_count_model.dart';

class TaskCountWrapperModel {
  bool? status;
  List<TaskListCountModel>? taskListCountModel;
  String? errorMessage;

  TaskCountWrapperModel({
    this.status,
    this.taskListCountModel,
    this.errorMessage,
  });

  TaskCountWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskListCountModel = <TaskListCountModel>[];
      json['data'].forEach((v) {
        taskListCountModel!.add(TaskListCountModel.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskListCountModel != null) {
      data['data'] = taskListCountModel!.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = errorMessage;
    return data;
  }
}
