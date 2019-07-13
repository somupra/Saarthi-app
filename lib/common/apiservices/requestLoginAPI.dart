import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saarthi/common/functions/saveCurrentLogin.dart';
import 'package:saarthi/model/json/signupModel.dart';
import 'package:saarthi/common/functions/showDialogSingleButton.dart';
import 'dart:convert';

import 'package:saarthi/model/json/loginModel.dart';

// Promises that in future LoginModel will be returned
Future<LoginModel> requestLoginAPI(BuildContext context, String username,
    String password) async {
  // Our URLs
  final signinurl = "http://172.17.73.99:8000/rest-auth/login/";
  final detailurl = "http://172.17.73.99:8000/rest-auth/user/";


  // This body will be passed to API
  Map<String, String> body = {
    'username': username,
    'password': password,
  };

  final response = await http.post(
    signinurl,
    body: body,
  );

  // If server responds OK
  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);


    String token = new SignupModel.fromJson(responseJson).token;

    // for debugging
    print(token);


    // pass the token to detailurl's headers to get the authenticated information
    final detailresponse = await http.get(detailurl,
        headers: {HttpHeaders.AUTHORIZATION: 'Token $token'});

    // if detail response is OK
    if (detailresponse.statusCode == 200) {
      // decode the details to map
      final detailJson = json.decode(detailresponse.body);

      // for debugging
      var userdetails = new LoginModel.fromJson(detailJson);
      print(userdetails.username);


      // save the current login and token to respective shared preferences for later use
      saveCurrentLogin(detailJson, token);


      Navigator.of(context).pushReplacementNamed('/dashboard');

      return LoginModel.fromJson(detailJson);
    } else {
      // Show that login was unsuccessful
      print("Entered the else block");
      final responseJson = json.decode(response.body);
      saveCurrentLogin(responseJson, "");
      print("Now showing the dialog");
      showDialogSingleButton(context, "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.",
          "OK");
      return null;
    }
  }
}
