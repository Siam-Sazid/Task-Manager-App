import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/widget/custom_circular_progress_indicator.dart';
import 'package:task_manager/widget/screen_background.dart';
import 'package:task_manager/widget/snackbar_message.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile?  _pickedImage;
  bool _updateProfileInProgress = false ;

  @override
  void initState() {
    super.initState();
    _emailController.text = AuthController.userModel?.email ?? '';
    _firstNameController.text = AuthController.userModel?.firstName ?? '';
    _lastNameController.text = AuthController.userModel?.lastName ?? '';
    _mobileController.text = AuthController.userModel?.mobile ?? '';

  }
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
                enabled: false,
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
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter First Name';
                  }

                },
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: _lastNameController,
          
                decoration: const InputDecoration(hintText: 'Last Name'),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter Last Name';
                  }

                },
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
                    return 'Enter Mobile Number';
                  }

                },
              ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Password'),

                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CustomCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapUpdateButton,
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
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
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
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
                  Text( _pickedImage == null ? 'No items selected' : _pickedImage!.name ,maxLines: 1,)
               ],
             ),
           ),
    );
  }
  Future <void> _pickImage() async{
    ImagePicker imagePicker = ImagePicker();
   XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
   if(image != null){
     _pickedImage = image;
     setState(() {

     });
   }
}

 void _onTapUpdateButton() {
    if(_formKey.currentState!.validate()){
   _updateProfile();
    }

 }

 Future <void> _updateProfile () async{
   _updateProfileInProgress = true;
   setState(() {

   });
  Map < String, dynamic> requestBody = {
    "email":_emailController.text.trim(),
    "firstName":_firstNameController.text.trim(),
    "lastName":_lastNameController.text.trim(),
    "mobile":_mobileController.text.trim(),

  };

  if(_pickedImage != null){
  List <int> imageBytes = await _pickedImage!.readAsBytes();
  requestBody['photo'] = base64Encode(imageBytes);

  }
  if(_passwordController.text.isNotEmpty){
    requestBody['password'] = _passwordController.text;

  }
   final NetworkResponse response = await NetworkCaller.postRequest(
       url: Urls.updateProfile,
       body: requestBody,

   );
   _updateProfileInProgress = false;
   setState(() {

   });
  if(response.isSuccess){

  _passwordController.clear();
  }
  else{
    showSnackBarMessage(context, response.errorMessage);

  }

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
