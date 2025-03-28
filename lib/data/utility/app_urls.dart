class AppUrls {
  static const String rootUrls = "http://192.168.31.88:8000/api";
  static const String regUrl = "$rootUrls/register";
  static const String logInUrl = "$rootUrls/login";
  static const String profileUpdate = "$rootUrls/user/update";
  static const String newTaskList = "$rootUrls/task/new";
  static const String countTaskList = "$rootUrls/task/count";
  static const String inProgressTaskList = "$rootUrls/task/inProgress";
  static const String completeTaskList = "$rootUrls/task/completed";
  static const String canceledTaskList = "$rootUrls/task/canceled";
  static const String postCreate = "$rootUrls/task/create";
  static String updateTask(int id) => "$rootUrls/task/update/$id";
  static String deleteTask(int id) => "$rootUrls/task/delete/$id";
}
