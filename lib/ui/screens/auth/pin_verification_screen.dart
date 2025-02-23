import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rest_task_manager/ui/screens/auth/reset_password_screen.dart';
import 'package:rest_task_manager/ui/screens/auth/sing_in_screen.dart';
import 'package:rest_task_manager/ui/utility/app_color.dart';
import 'package:rest_task_manager/ui/widgets/background_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

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
                      'Pin Verification',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'A six digit verification pin will send to your email address',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 16),

                    PinCodeTextField(
                      keyboardType: TextInputType.number,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        selectedColor: AppColor.primaryColor,
                        inactiveColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      controller: _pinTEController,
                      appContext: context,
                    ),

                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_fromKey.currentState!.validate()) {
                          _onTapPinVerificationButton();
                        }
                      },
                      child: Text('Verify'),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have account? ",
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

  void _onTapPinVerificationButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
    );
  }

  @override
  void dispose() {
    _pinTEController.dispose();
    super.dispose();
  }
}
