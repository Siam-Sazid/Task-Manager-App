import 'package:flutter/material.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/screens/sign_in_screen.dart';
import 'package:task_manager/widget/app_logo.dart';
import 'package:task_manager/widget/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToNextScreen();
  }


  Future<void> moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isUserLoggedIn = await AuthController.isUserLoggedIn();
    if(isUserLoggedIn){
      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
      debugPrint("Navigating with email: ${AuthController.userModel?.email}");


    }else{
      Navigator.pushReplacementNamed(context, SignInScreen.name);


    }

  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScreenBackground(
        child: Center(
          child: AppLogo(),
        ),
      ),

    );
  }
}





