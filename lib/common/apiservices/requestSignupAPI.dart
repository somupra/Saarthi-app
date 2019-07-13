import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saarthi/common/functions/saveCurrentLogin.dart';
import 'package:saarthi/model/json/loginModel.dart';
import 'package:saarthi/common/functions/showDialogSingleButton.dart';
import 'dart:convert';
import 'dart:io';
import 'package:saarthi/model/json/signupModel.dart';

// promises that in future, LoginModel will be returned
Future<LoginModel> requestSignupAPI(
  BuildContext context,
  String username,
  String email,
  String password1,
  String password2,
) async {
  final signupurl = "http://172.17.73.99:8000/rest-auth/registration/";
  final detailurl = "http://172.17.73.99:8000/rest-auth/user/";

  Map<String, String> body = {
    'username': username,
    'email': email,
    'password1': password1,
    'password2': password2,
  };

  // posting the data to signup url with body as user details
  final response = await http.post(
    signupurl,
    body: body,
  );


  // if code = 201, Created successfully!
  if (response.statusCode == 201) {
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
      showDialogSingleButton(
          context,
          "Unable to Login",
          "Your details are not fetched properly, maybe a server issue, however the user is created, you may login by SignIn page",
          "OK");
      return null;
    }
  } else {
    showDialogSingleButton(
        context,
        "Unable to Signup",
        "You may have entered mismatching passwords, or the username/email already exists. Please try again!",
        "TRY AGAIN");
    return null;
  }
}
