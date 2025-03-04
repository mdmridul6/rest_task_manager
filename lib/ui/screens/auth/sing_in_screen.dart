import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rest_task_manager/data/model/login_model.dart';
import 'package:rest_task_manager/data/model/network_response.dart';
import 'package:rest_task_manager/data/network_caller/network_caller.dart';
import 'package:rest_task_manager/data/utility/app_urls.dart';
import 'package:rest_task_manager/ui/controller/auth_controller.dart';
import 'package:rest_task_manager/ui/screens/auth/email_verification_screen.dart';
import 'package:rest_task_manager/ui/screens/auth/sing_up_screen.dart';
import 'package:rest_task_manager/ui/screens/tasks/main_bottom_nav_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';
import 'package:rest_task_manager/ui/widgets/show_shack_bar_message.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  bool loginRequestInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 16),
                    Visibility(
                      visible: loginRequestInProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_fromKey.currentState!.validate()) {
                            _onTapSingInButton();
                          }
                        },
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: _onTapForgetPasswordButton,
                            child: Text('Forgot password'),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Don't have and account? ",
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.8),
                                letterSpacing: 0.4,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sing up",
                                  style: TextStyle(
                                    color: AppColor.primaryColor,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = _onTapSingUpButton,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSingUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SingUpScreen()),
    );
  }

  void _onTapSingInButton() {
    _singInRequest();
  }

  Future<void> _singInRequest() async {
    loginRequestInProgress = true;

    if (mounted) {
      setState(() {});
    }

    Map<String, String> inputBody = {
      'email': _emailTEController.text.trim(),
      'password': _passwordTEController.text,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      AppUrls.logInUrl,
      inputBody,
    );

    if (response.statusCode == 200 && response.isSuccess == true) {
      loginRequestInProgress = false;
      if (mounted) {
        setState(() {});
      }
      LoginModel loginModel = LoginModel.fromJson(response.responseData);

      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);


      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainBottomNavScreen()),
        );
      }
    } else {
      if (mounted) {
        loginRequestInProgress = false;

        if (mounted) {
          setState(() {});
        }
        showSnackBarMessage(
          context,
          response.errorMessage ?? "User credentials does not match",
        );
      }
    }
  }

  void _onTapForgetPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
