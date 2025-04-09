
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/widget/custom_circular_progress_indicator.dart';
import 'package:task_manager/widget/screen_background.dart';
import 'package:task_manager/widget/snackbar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;
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
                Text('Join With Us', style: textTheme.titleLarge),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter your email';
                    }
                    return null;

                  }
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _firstNameController,

                  decoration: const InputDecoration(hintText: 'First Name'),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your First Name';
                      }
                      return null;
                    }
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _lastNameController,

                  decoration: const InputDecoration(hintText: 'Last Name'),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your Last Name';
                      }
                      return null;

                    }
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your Mobile';
                      }
                      return null;

                    }
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your password';
                      }
                      if(value!.length<6){
                        return 'Please enter your password more than six letters';
                      }
                      return null;

                    }
                ),
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: _signUpInProgress == false,
                  replacement: const CustomCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () {
                      _onTapSignUpButton();
                    },
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                Center(
                  child:
                  _buildSignInSection(),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
 void _onTapSignUpButton()
  {
if(_formKey.currentState!.validate()){
  _registerUser();
}

}
Future<void> _registerUser()async{
 _signUpInProgress = true ;
 setState(() {
 });
 Map <String,dynamic> requestBody = {
   "email":_emailController.text.trim(),
   "firstName":_firstNameController.text.trim(),
   "lastName":_lastNameController.text.trim(),
   "mobile":_mobileController.text.trim(),
   "password":  _passwordController.text.trim(),
   "photo":""

 };

 final NetworkResponse response = await NetworkCaller.postRequest(
     url: Urls.registrationUrl,
     body: requestBody
 );
 _signUpInProgress = false;
 setState(() {

 });
 if(response.isSuccess){
    _clearTextFields();
    showSnackBarMessage(context, 'Registration Successfull');
 }else{
   showSnackBarMessage(context, response.errorMessage);

 }

}

void _clearTextFields(){
    _emailController.clear();
    _passwordController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
}
  Widget _buildSignInSection() {
    return RichText(
                      text:  TextSpan(
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                          text: "Already have an account? ",
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
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();

    super.dispose();
  }
}
