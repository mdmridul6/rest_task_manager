import 'package:rest_task_manager/data/model/user_model.dart';

class TaskModel {
  int? id;
  String? title;
  String? description;
  String? status;
  int? userId;
  String? createdAt;
  String? updatedAt;
  UserModel? user;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
