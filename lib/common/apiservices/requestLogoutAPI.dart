import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saarthi/common/functions/getToken.dart';
import 'package:saarthi/common/functions/saveLogout.dart';
import 'package:saarthi/model/json/loginModel.dart';
import 'package:saarthi/common/functions/showDialogSingleButton.dart';

// Promises to return a LoginModel
Future<LoginModel> requestLogoutAPI(BuildContext context) async {

  // Logout URL
  final url = "http://172.17.73.99:8000/rest-auth/logout/";

  String token;
  await getToken().then((result) {
    token = result;

    // For debugging
    print("Token extracted successfully: $token");
  });


  final response = await http.post(
    url,
    headers: {
      HttpHeaders.AUTHORIZATION: "Token $token"
    },
  );

  if (response.statusCode == 200) {
    print("logged out successfully");
    saveLogout();
    Navigator.of(context).pushReplacementNamed('/login');
    return null;
  } else {
    saveLogout();
    Navigator.of(context).pushReplacementNamed('/login');
    return null;
  }
}