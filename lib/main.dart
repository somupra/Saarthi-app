import 'package:flutter/material.dart';
import './ui/splash_screen.dart';
import './ui/login_page.dart';
import './ui/dashboard.dart';
import './ui/about.dart';
import './ui/help.dart';
import './ui/rewards.dart';
import './ui/profile.dart';
import './ui/notifications.dart';
import './ui/current_location.dart';
import './ui/./new_complaint.dart';

void main() => runApp(new Saarthi());

class Saarthi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saarthi',
      routes: <String, WidgetBuilder>{
        "/about": (BuildContext context) => About(),
        "/help": (BuildContext context) => Help(),
        "/current_location": (BuildContext context) => CurrentLocation(),
        "/notifications": (BuildContext context) => Notifications(),
        "/profile": (BuildContext context) => Profile(),
        "/rewards": (BuildContext context) => Rewards(),
        "/login": (BuildContext context) => LoginPage(),
        "/dashboard": (BuildContext context) => Dashboard(),
        "/new_complaint": (BuildContext context) => NewComplaint(),


      },
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),
    );
  }
}
