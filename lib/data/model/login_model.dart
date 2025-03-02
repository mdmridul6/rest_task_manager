import 'package:rest_task_manager/data/model/user_model.dart';

class LoginModel {
  bool? status;
  String? token;
  UserModel? userModel;
  String? errorMessage;

  LoginModel({this.status, this.token, this.userModel, this.errorMessage});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userModel = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    if (userModel != null) {
      data['data'] = userModel!.toJson();
    }
    data['errorMessage'] = errorMessage;
    return data;
  }
}
