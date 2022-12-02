import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Generate.dart';
import 'Home.dart';

class SendRequest {
  ///
  // Login Request
  ///
  static void loginReq({
    required BuildContext context,
    required String username,
    required String password,
    required GlobalKey<ScaffoldMessengerState> messengerKey,
  }) async {

      var body = {
        "code": username,
        "password": password
      };
      try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Response response = await post(
        Uri.parse('http://daneshpark.ir:1090/user/authenticate'),
        body: jsonEncode(body), 
        headers: {'Content-Type':'application/json'}
      );

      if (response.statusCode == 200) {
          var loginJson = json.decode(utf8.decode(response.bodyBytes));
          prefs.setBool('login', false);
          prefs.setString('token', loginJson['token']);
          prefs.setString('amount', loginJson['userinfo']['amount'].toString());
          prefs.setString('id', loginJson['userinfo']['_id'].toString());
  
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        var loginJson = json.decode(utf8.decode(response.bodyBytes));
        Generate.showMySnackBar(
            context,  loginJson['message'], messengerKey);
      }
      } catch (e) {
      Generate.showMySnackBar(
          context, "اتصال شما با سرور قطع می باشد", messengerKey);
    }
  }

  ///
  // Signup Request
  ///
  static void signupReq(
      {required BuildContext context,
      required String username,
      required String password,
      required String nationalCode,
      required String phoneNumber,
      required String firstName,
      required String lastName,
      required GlobalKey<ScaffoldMessengerState> messengerKey}) async {
    var signUpBody = {
      "firstname": firstName,
      "lastname": lastName,
      "code": nationalCode,
      "phone": phoneNumber,
      "email": username,
      "password": password,
    };
    try {
      Response signUpResponse = await post(
          Uri.parse('http://daneshpark.ir:1090/user/new'),
          body: jsonEncode(signUpBody),
          headers: {'Content-Type':'application/json'}
          );
 
      if (signUpResponse.statusCode == 200) {
        Generate.showMySnackBar(
            context, "ثبت  نام شما با موفقیت انحام شد", messengerKey);
      } else {
        var signupJson = json.decode(utf8.decode(signUpResponse.bodyBytes));
        Generate.showMySnackBar(
            context, signupJson["message"], messengerKey);
      }
    } catch (e) {
      Generate.showMySnackBar(
          context, "اتصال شما با سرور قطع می باشد", messengerKey);
    }
  }
}
