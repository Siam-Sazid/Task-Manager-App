
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/screens/reset_password_screen.dart';
import 'package:task_manager/screens/sign_in_screen.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/widget/screen_background.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key});

  static const String name = '/forgot-password/verify-otp';

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() => _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState extends State<ForgotPasswordVerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();

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
                Text('Pin Verification', style: textTheme.titleLarge),
                const SizedBox(
                  height: 4,
                ),
                const Text('A 6 digits of OTP has been sent to your email adress',
                style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,

                ),
                ),
                const SizedBox(
                  height: 24,
                ),
                buildPinCodeTextField(),
                const SizedBox(
                  height: 24,
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ResetPasswordScreen.name);
                  },
                  child: const Text('Verify'),
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

  Widget buildPinCodeTextField() {
    return PinCodeTextField(
                keyboardType: TextInputType.number,
                length: 6,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  inactiveColor: AppColor.themeColor,


                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,

                controller: _otpTEController,
                appContext: context,
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
    _otpTEController.dispose();

    super.dispose();
  }
}
