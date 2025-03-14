import 'package:flutter/material.dart';
import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:rest_task_manager/data/model/task_model.dart';
import 'package:rest_task_manager/data/network_caller/network_caller.dart';
import 'package:rest_task_manager/data/utility/app_urls.dart';
import 'package:rest_task_manager/ui/widgets/show_shack_bar_message.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskItem,
    required this.onDeleteTask,
  });

  final TaskModel taskItem;
  final VoidCallback onDeleteTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteInProgress = false;
  bool _editInProgress = false;
  List<String> taskStatus = ['New', 'Completed', 'In Progress', 'Canceled'];

  String dropDownValue = "";
  String selectedValue="";

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    dropDownValue = widget.taskItem.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(widget.taskItem.title!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskItem.description!),
            Text(
              'Date: ${widget.taskItem.createdAt!}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(widget.taskItem.status!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                ),
                OverflowBar(
                  children: [
                    Visibility(
                      visible: _editInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: PopupMenuButton<String>(
                        initialValue: dropDownValue,
                        onSelected: (String value) {
                          selectedValue = value;
                          if (mounted) {
                            setState(() {});
                          }
                          _editTask();
                        },
                        itemBuilder:
                            (context) =>
                                taskStatus.map((element) {
                                  return PopupMenuItem<String>(
                                    value: element,
                                    child: ListTile(
                                      title: Text(element),
                                      trailing:
                                          dropDownValue == element
                                              ? Icon(Icons.check)
                                              : null,
                                    ),
                                  );
                                }).toList(),
                      ),
                    ),

                    Visibility(
                      visible: _deleteInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: IconButton(
                        onPressed: () {
                          _deleteTask();
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask() async {
    _deleteInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
      AppUrls.deleteTask(widget.taskItem.id!),
    );

    if (response.isSuccess && response.statusCode == 200) {
      widget.onDeleteTask();
    }

    _deleteInProgress = false;
    if (mounted) {
      showSnackBarMessage(context, "Task delete Successfully");
      setState(() {});
    }
  }

  Future<void> _editTask() async {
    _editInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, String> inputData = {'status': selectedValue};
    NetworkResponse response = await NetworkCaller.postRequest(
      AppUrls.updateTask(widget.taskItem.id!),
      inputData,
    );

    if (response.isSuccess && response.statusCode == 200) {
      widget.onDeleteTask();
    }

    _editInProgress = false;
    if (mounted) {
      showSnackBarMessage(context, "Task Update Successfully");
      setState(() {});
    }
  }
}
