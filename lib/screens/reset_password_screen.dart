
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/screens/sign_in_screen.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/widget/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String name = '/forgot-password/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();

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
                Text('Set Password', style: textTheme.titleLarge),
                const SizedBox(
                  height: 4,
                ),
                const Text('Minimum password length should be more than 8 letters',
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,

                ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _newPasswordTEController,
                  decoration: const InputDecoration(
                    hintText: 'New password'
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _confirmPasswordTEController,
                  decoration: const InputDecoration(
                      hintText: 'Confirm new password'
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Confirm'),
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
                          Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (vale) => false);
                        }


                        )
                      ]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _newPasswordTEController.dispose();
    _confirmPasswordTEController.dispose();

    super.dispose();
  }
}
