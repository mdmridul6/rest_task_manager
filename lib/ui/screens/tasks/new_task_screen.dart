import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';
import 'package:rest_task_manager/ui/widgets/profile_app_bar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackgroundWidget(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(decoration: InputDecoration(hintText: 'Title')),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Description'),
                  maxLines: 4,
                ),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: _onTapAddButton, child: Text('Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddButton() {
    Navigator.pop(context);
  }
}
