import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/screens/auth/sing_in_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _conformTEController = TextEditingController();
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
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Minimum length password 8 character with letter and cumber combination ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _conformTEController,
                      decoration: InputDecoration(hintText: 'Conform Password'),
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
                      child:Text('Verify'),
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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SingInScreen()),
      (context) => false,
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _conformTEController.dispose();

    super.dispose();
  }
}
