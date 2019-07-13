import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:saarthi/common/functions/getLocation.dart';
import 'package:saarthi/common/functions/getToken.dart';
import 'package:saarthi/common/functions/getUser.dart';
import 'package:saarthi/common/functions/base64.dart';
import 'package:saarthi/common/functions/showDialogSingleButton.dart';

void CreateComplaint(BuildContext context ,File image, String description)async{

  final createurl = "http://172.17.73.99:8000/api/complaints/create/";

  String locationurl = await getmyLocation();



  String base64Image;

  await tobase64(image).then((result){
    base64Image = result;
  });

  var token, username;
  await getToken().then((result) {
    token = result;
  });
  await getUser().then((result) {
    username = result;
  });

  print("Here are the details posted to $createurl");
  print("Token : $token");
  print(base64Image);
  print(locationurl);
  print(description);

  Map<String, String> body = {
    'location': locationurl,
    'ref_image': base64Image,
    'description': description,
    'filer': "username",
  };


  await http.post(
    createurl,
    headers: {
      HttpHeaders.AUTHORIZATION : "Token $token",
    },
    body: body,
  ).then((response){
    if(response.statusCode == 201){
      showDialogSingleButton(context, "Success", "Your complaint is registered successfully!", "OK");
      Navigator.of(context).pushReplacementNamed('/dashboard');
      return null;
    }else{
      print(response.body);
      showDialogSingleButton(context, "ERROR", "Please Try Again", "OK");
    }
  });


}
