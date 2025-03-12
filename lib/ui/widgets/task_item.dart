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
                      visible: _deleteInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: IconButton(
                        onPressed: () {
                          _deleteTask();
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
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
}
