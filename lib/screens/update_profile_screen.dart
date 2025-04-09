import 'package:flutter/material.dart';
import 'package:task_manager/widget/screen_background.dart';
import 'package:task_manager/widget/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static const String name = '/update-profile';
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: TMAppBar(textTheme: textTheme,fromUpdateProfile: true,),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
          
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const SizedBox(
                height: 32,
              ),
              Text('Update Profile', style: textTheme.titleLarge),
              const SizedBox(
                height: 24,
              ),
             _buildPhotoPicker(),
              const SizedBox(height: 8,),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: _firstNameController,
          
                decoration: const InputDecoration(hintText: 'First Name'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: _lastNameController,
          
                decoration: const InputDecoration(hintText: 'Last Name'),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Mobile'),
              ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return Container(
           height: 50,
           padding: EdgeInsets.symmetric(horizontal: 16),
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(8),
           ),
           child: Row(
             children: [
               Container(
                 height: 50,
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 decoration: BoxDecoration(
                   color: Colors.grey,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(8),
                     bottomLeft: Radius.circular(8),

                   ),
                 ),
                 alignment: Alignment.center,
                 child: const Text('Photo',
                 style: TextStyle(color: Colors.white),
                 ),
               ),
               const SizedBox(width: 12,),
               const Text('No items selected',maxLines: 1,)
             ],
           ),
         );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();

    super.dispose();
  }
}
