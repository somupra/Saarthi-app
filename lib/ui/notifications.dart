import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saarthi/common/functions/getToken.dart';
import 'package:saarthi/model/json/notificationModel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  final url = "http://172.17.73.99:8000/api/user/notifications/";

  List<CustomNotification> list = List();
  var isLoading = false;

  Future<void>fetchNotifications() async {
    setState(() {
      isLoading = true;
    });

    var token;
    await getToken().then((result) {
      token = result;
      print("Token extracted successfully for notifications: $token");
    });

    final response = await http
        .get(url, headers: {HttpHeaders.AUTHORIZATION: "Token $token"});

    print(response.body);
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new CustomNotification.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });

    } else {
      throw Exception('Failed to load notifications');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : LiquidPullToRefresh(
          height: 60.0,
          color: Colors.teal,
          backgroundColor: Colors.white,
          onRefresh: fetchNotifications, // refresh callback
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      title: new Text(list[index].notification),
                      trailing: Icon(Icons.notifications)
                    ));
              }), // scroll view
        )
    );
  }
}

