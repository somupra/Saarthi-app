import 'package:flutter/material.dart';

class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rewards"),
      ),
      body: Center(
        child: Text("Rewards Page"),
      ),
    );
  }
}
