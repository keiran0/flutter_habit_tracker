import 'package:flutter/material.dart';

class appDrawer extends StatefulWidget {
  String user;

  appDrawer({required this.user});

  @override
  State<StatefulWidget> createState() {
    return _DrawerState(this.user);
  }
}

class _DrawerState extends State<appDrawer> {
  String user;

  _DrawerState(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Column(children: [Text("Motive"), Text("Hello, $user !")])),
      ListTile(
          leading: Image.network(
              "https://img.icons8.com/clouds/100/project-setup.png"),
          title: Text("View Habits"),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home', arguments: user);
          }),
      ListTile(
          leading: Image.network(
              "https://img.icons8.com/clouds/100/edit-property.png"),
          title: Text("Log Habits"),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/log', arguments: user);
          }),

      ListTile(
          leading: Image.network(
              "https://img.icons8.com/clouds/100/add.png"),
          title: Text("Add New Habit"),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/add', arguments: user);
          }),

      ListTile(
          leading: Image.network(
              "https://img.icons8.com/clouds/100/apple-settings--v2.png"),
          title: Text("Settings"),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/settings', arguments: user);
          }),
    ]));
  }
}
