class TaskListCountModel {
  String? status;
  int? count;

  TaskListCountModel({this.status, this.count});

  TaskListCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['count'] = count;
    return data;
  }
}
