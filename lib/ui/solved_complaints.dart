import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saarthi/common/functions/getToken.dart';
import 'package:saarthi/model/json/complaintModel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class SolvedComplaints extends StatefulWidget {
  @override
  _SolvedComplaintsState createState() => _SolvedComplaintsState();
}

class _SolvedComplaintsState extends State<SolvedComplaints> {

  // API endpoint
  final url = "http://172.17.73.99:8000/api/complaints/settled";

  List<Complaint> list = List();
  var isLoading = false;

  Future<void>fetchData() async {
    setState(() {
      isLoading = true;
    });

    var token;
    await getToken().then((result) {
      token = result;
      print("Token extracted successfully for pending apis: $token");
    });

    final response = await http
        .get(url, headers: {HttpHeaders.AUTHORIZATION: "Token $token"});
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Complaint.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });

//      return Complaint.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : LiquidPullToRefresh(
          height: 60.0,
          color: Colors.teal,
          backgroundColor: Colors.white,
          onRefresh: fetchData, // refresh callback
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: ListTile(
                      isThreeLine: true,
                      contentPadding: EdgeInsets.all(10.0),
                      title: new Text("ID:"+(list[index].complaintId).substring(0,8)),
                      subtitle: Text(list[index].description+"\n"+list[index].dateFiled.toString().substring(0,10)),
                      trailing: new Image.network(
                        list[index].refImage,
                        fit: BoxFit.cover,
                        height: 160.0,
                        width: 150.0,
                      ),
                    ));
              }), // scroll view
        ));
  }
}
