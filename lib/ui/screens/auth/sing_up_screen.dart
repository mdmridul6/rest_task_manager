import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/screens/auth/sing_in_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: 'First Name'),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: 'Last Name'),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileTEController,
                      decoration: InputDecoration(hintText: 'Mobile'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_fromKey.currentState!.validate()) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => {}),
                          // );
                        }
                      },
                      child: Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have account! ",
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.8),
                            letterSpacing: 0.4,
                          ),
                          children: [
                            TextSpan(
                              text: "Sing in",
                              style: TextStyle(color: AppColor.primaryColor),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = _onTapSingInButton,
                            ),
                          ],
                        ),
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

  void _onTapSingInButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SingInScreen()),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    super.dispose();
  }
}
