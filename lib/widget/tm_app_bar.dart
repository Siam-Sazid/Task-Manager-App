import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/screens/sign_in_screen.dart';
import 'package:task_manager/screens/update_profile_screen.dart';
import 'package:task_manager/utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    required this.textTheme,
    this.fromUpdateProfile = false,
  });

  final TextTheme textTheme;
 final bool fromUpdateProfile;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.themeColor,
      title:  Row(
        children: [
          CircleAvatar(
            radius:  16,
            backgroundImage: MemoryImage(
                 base64Decode(AuthController.userModel?.photo ?? '')

            ),
            onBackgroundImageError: (_, __) => Icon(Icons.person),

          ),
          const SizedBox(width: 16,),
          Expanded(
            child: GestureDetector(
              onTap: (){
                if(!fromUpdateProfile){
                  print(!fromUpdateProfile);
                  Navigator.pushNamed(context, UpdateProfileScreen.name);

                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AuthController.userModel?.fullName ?? '',style: textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                  ),),
                  Text(AuthController.userModel?.email ?? '',style: textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),),
                ],
              ),
            ),
          ),
          IconButton(onPressed: () async {
            await AuthController.clearUserData();
            Navigator.pushNamedAndRemoveUntil(
                context, SignInScreen.name, (predicate) => false);
          }, icon: Icon(Icons.logout))

        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
