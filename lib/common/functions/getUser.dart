import 'package:shared_preferences/shared_preferences.dart';

Future<String>getUser() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  String getUser = await preferences.getString("LastToken");
  return getUser;
}