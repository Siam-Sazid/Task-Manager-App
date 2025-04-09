import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/screens/sign_up_screen.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/widget/custom_circular_progress_indicator.dart';
import 'package:task_manager/widget/screen_background.dart';
import 'package:task_manager/widget/snackbar_message.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;

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
                Text('Get Started With', style: textTheme.titleLarge),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Email';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Password';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: _signInProgress == false,
                  replacement: const CustomCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapSignInButtom,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgotPasswordVerifyEmailScreen.name);
                        },
                        child: const Text('Forgot password?'),
                      ),
                      _buildSignUpSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _onTapSignInButtom() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _signInProgress = true;
    setState(() {});
    Map <String,dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text


    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.loginUrl,body: requestBody);

    if(response.isSuccess){
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      debugPrint("Extracted Email: ${userModel.email}");

      await AuthController.saveUserData(token, userModel);
      debugPrint("Saved Token: ${AuthController.accessToken}");
    Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
    }else{
      _signInProgress = false;
      setState(() {

      });
  showSnackBarMessage(context, response.errorMessage);
    }
  }

  Widget _buildSignUpSection() {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
                color: Colors.black54, fontWeight: FontWeight.w600),
            text: "Don't have an account? ",
            children: [
          TextSpan(
              text: "Sign up",
              style: const TextStyle(color: AppColor.themeColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, SignUpScreen.name);
                })
        ]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
