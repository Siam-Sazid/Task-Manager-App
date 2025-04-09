import 'dart:convert';
import 'package:task_manager/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/screens/sign_in_screen.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage ;

  NetworkResponse(
      {required this.statusCode,
      this.responseData,
      required this.isSuccess,
         this.errorMessage = 'Something Went Wrong'});
}

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url , Map<String,dynamic>? params }) async{
  try  {
      Uri uri = Uri.parse(url);
      debugPrint('URL => $url');
      debugPrint("Sending Token: ${AuthController.accessToken}");
      Response response = await get(uri,
      headers: {
        'token':AuthController.accessToken ?? ''

      }
      );
      debugPrint('Response => ${response.statusCode}');
      debugPrint('Response data => ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedResponse,
        );
      } else if(response.statusCode == 401){
      await  _logOut();
      return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false

      );

      } else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false

        );
      }
    } catch (e){
    return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),

    );

  }
  }



  static Future<NetworkResponse> postRequest({required String url , Map<String,dynamic>? body }) async{
  try  {
      Uri uri = Uri.parse(url);
      debugPrint('URL => $url');
      debugPrint('BODY => $body');
      debugPrint("Sending Token post request: ${AuthController.accessToken}");
      Response response = await post(
          uri,
          headers: {
            'content-type' : 'application/json',
            'token' : AuthController.accessToken ?? ''
          },
          body: jsonEncode(body));
      debugPrint('Response => ${response.statusCode}');
      debugPrint('Response data => ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodedResponse,
        );
      } else if(response.statusCode == 401){
        await  _logOut();
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false

        );

      }else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false

        );
      }
    } catch (e){
    return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),

    );

  }
  }


  static Future<void> _logOut() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(TaskManagerApp.navigatorKey.currentContext!, SignInScreen.name, (_)=>false);

  }
}
