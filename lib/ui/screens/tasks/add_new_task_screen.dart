import 'package:flutter/material.dart';
import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:rest_task_manager/data/network_caller/network_caller.dart';
import 'package:rest_task_manager/data/utility/app_urls.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';
import 'package:rest_task_manager/ui/widgets/profile_app_bar.dart';
import 'package:rest_task_manager/ui/widgets/show_shack_bar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  bool _addRequestInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackgroundWidget(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _globalFormKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Title'),
                    controller: _titleTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter task title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    decoration: InputDecoration(hintText: 'Description'),
                    maxLines: 4,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter task description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: _addRequestInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: _onTapAddButton,
                      child: Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddButton() {
    _taskAddRequest();
  }

  Future<void> _taskAddRequest() async {
    _addRequestInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> inputData = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "new",
    };

    NetworkResponse networkResponse = await NetworkCaller.postRequest(
      AppUrls.postCreate,
      inputData,
    );

    if (networkResponse.isSuccess && networkResponse.statusCode == 201) {
      _addRequestInProgress = false;
      if (mounted) {
        setState(() {});
        _clearInputsFields();
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        _addRequestInProgress = false;
        if (mounted) {
          setState(() {});
        }
        showSnackBarMessage(
          context,
          networkResponse.errorMessage ??
              "Something wrong please try again later",
        );
      }
    }
  }

  void _clearInputsFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
