
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_manager/screens/sign_up_screen.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/widget/screen_background.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  static const String name = '/forgot-password/verify-email';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text('Your Email Address', style: textTheme.titleLarge),
                const SizedBox(
                  height: 4,
                ),
                const Text('A 6 digits of OTP will be sent to your email adress',
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,

                ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 24,
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPasswordVerifyOtpScreen.name);
                  },
                  child: const Icon(Icons.arrow_circle_right_outlined),
                ),
                const SizedBox(
                  height: 48,
                ),
                Center(
                  child: _buildSignInSection(),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildSignInSection() {
    return RichText(
                      text:  TextSpan(
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          text: "Have an account? ",
                          children: [
                        TextSpan(
                            text: "Sign in",
                            style: const TextStyle(color: AppColor.themeColor),
                        recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.pop(context);
                        }


                        )
                      ]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();

    super.dispose();
  }
}
