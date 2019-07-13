

import 'package:shared_preferences/shared_preferences.dart';
import 'package:saarthi/model/json/loginModel.dart';

saveCurrentLogin(Map responseJson, String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();


  var username = (responseJson != null && responseJson.isNotEmpty) ? LoginModel.fromJson(responseJson).username : "";
  var first_name = (responseJson != null && responseJson.isNotEmpty) ? LoginModel.fromJson(responseJson).first_name : "";
  var last_name = (responseJson != null && responseJson.isNotEmpty) ? LoginModel.fromJson(responseJson).last_name : "";
  var email = (responseJson != null && responseJson.isNotEmpty) ? LoginModel.fromJson(responseJson).email : "";
  var pk = (responseJson != null && responseJson.isNotEmpty) ? LoginModel.fromJson(responseJson).userId : 0;

  await preferences.setString('LastUsername', (username != null && username.length > 0) ? username : "");
  await preferences.setString('LastEmail', (email != null && email.length > 0) ? email : "");
  await preferences.setString('LastFirst_name', (first_name != null && first_name.length > 0) ? first_name : "");
  await preferences.setString('LastLast_name', (last_name != null && last_name.length > 0) ? last_name : "");
  await preferences.setInt('LastUserId', (pk != null && pk > 0) ? pk : 0);
  await preferences.setString('LastToken', token);

}