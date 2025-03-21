import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:rest_task_manager/data/model/user_model.dart';
import 'package:rest_task_manager/data/network_caller/network_caller.dart';
import 'package:rest_task_manager/data/utility/app_urls.dart';
import 'package:rest_task_manager/ui/controller/auth_controller.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';
import 'package:rest_task_manager/ui/widgets/profile_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_task_manager/ui/widgets/show_shack_bar_message.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? selectedImage;
  bool _profileUpdateInProgress = false;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.userData?.email ?? "";
    _firstNameTEController.text = AuthController.userData?.firstName ?? "";
    _lastNameTEController.text = AuthController.userData?.lastName ?? "";
    _phoneTEController.text = AuthController.userData?.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context, true),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  Visibility(
                    visible: _profileUpdateInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPickerWidget() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
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
        child: Row(
          children: [
            Container(
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
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                selectedImage?.name ?? "No Image Selected",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapPhotoPicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImage = pickedFile;

      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _updateProfile() async {
    _profileUpdateInProgress = true;
    if (mounted) {
      setState(() {});
    }
    String encodedImage = AuthController.userData?.photo ?? "";
    Map<String, dynamic> input = {
      "first_name": _firstNameTEController.text.trim(),
      "last_name": _lastNameTEController.text.trim(),
      "email": _emailTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
    };

    if (_passwordTEController.text != null) {
      input['password'] = _passwordTEController.text;
    }

    if (selectedImage != null) {
      File file = File(selectedImage!.path);
      encodedImage = base64Encode(file.readAsBytesSync());
      input['photo'] = encodedImage;
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      AppUrls.profileUpdate,
      input,
    );

    if (response.isSuccess && response.statusCode == 201) {
      UserModel userModel = UserModel(
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _phoneTEController.text.trim(),
        photo: encodedImage,
      );
      await AuthController.saveUserData(userModel);
      if (mounted) {
        showSnackBarMessage(context, "Profile Updated Successfully");
        setState(() {});
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? "Profile Updated Failed",
          true,
        );
      }
    }
    _profileUpdateInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

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
