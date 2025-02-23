import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/screens/auth/sing_up_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
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
                      'Get Start With',
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
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {},
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

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
