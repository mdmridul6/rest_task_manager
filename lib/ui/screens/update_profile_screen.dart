import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';
import 'package:rest_task_manager/ui/widgets/profile_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48),
                Text(
                  'Upload Photos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 24),
                _buildPhotoPickerWidget(),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(hintText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(hintText: "First Name"),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: InputDecoration(hintText: "Last Name"),
                ),
                SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneTEController,
                  decoration: InputDecoration(hintText: "Mobile Number"),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _onTapUpdateProfileButton,
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPickerWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 48,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Container(
        height: 48,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
        child: const Text('Photo', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _onTapUpdateProfileButton() {}

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
