import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './pending_complaints.dart';
import './approved_complaints.dart';
import './solved_complaints.dart';
import '../common/apiservices/requestLogoutAPI.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  String username = "Dashboard", email = "somupra9@gmail.com";

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text(
          "Saarthi",
          style: TextStyle(fontSize: 22.0),
        ),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal
            ),
            accountName: Text(
              "$username",
              style: TextStyle(fontSize: 15.0),
            ),
            accountEmail: Text("$email"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "${username.substring(0, 1)}",
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
          ListTile(
            title: Text("New Complaint"),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/current_location");
            },
          ),
          ListTile(
            title: Text("Notifications"),
            trailing: Icon(Icons.notifications),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/notifications");
            },
          ),
          ListTile(
            title: Text("Rewards"),
            trailing: Icon(Icons.account_balance_wallet),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/rewards");
            },
          ),
          Divider(),
          ListTile(
            title: Text("Help"),
            trailing: Icon(Icons.help),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/help");
            },
          ),
          ListTile(
            title: Text("About"),
            trailing: Icon(Icons.info),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/about");
            },
          ),
          Divider(),
          ListTile(
            title: Text("Logout"),
            trailing: Icon(Icons.directions_walk),
            onTap: () {
              Navigator.of(context).pop();
              requestLogoutAPI(context);
            },
          ),
        ],
      )),
      body: TabBarView(
        children: <Widget>[
          PendingComplaints(),
          ApprovedComplaints(),
          SolvedComplaints(),
        ],
        controller: tabController,
      ),
      bottomNavigationBar: Material(
        color: Colors.teal,
          child: TabBar(controller: tabController, tabs: <Widget>[
        Tab(icon: Icon(Icons.list)),
        Tab(icon: Icon(Icons.playlist_add_check)),
            Tab(icon: Icon(Icons.check_circle)),


          ])),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: Icon(
            Icons.location_on,
            size: 25.0,
          ),
          onPressed: (){
            Navigator.of(context).pushNamed("/current_location");
          }
          ),
    );
  }
}
