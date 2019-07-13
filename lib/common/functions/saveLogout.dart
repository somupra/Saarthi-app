
import 'package:shared_preferences/shared_preferences.dart';

saveLogout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await preferences.setString('LastUsername', "");
  await preferences.setString('LastToken', "");
  await preferences.setString('LastEmail', "");
  await preferences.setString('LastFirst_name', "");
  await preferences.setString('LastLast_name', "");
  await preferences.setInt('LastUserId', 0);
}