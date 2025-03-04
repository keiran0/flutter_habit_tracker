import 'package:flutter/material.dart';
import '../src/app_drawer.dart';

class SettingsPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<SettingsPage>{

  @override
  Widget build(BuildContext context) {

    var user = ModalRoute.of(context)!.settings.arguments.toString(); 
    
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: SafeArea(child: _buildUI(context)),
      drawer: appDrawer(user: user)
    );
  }

  Widget _buildUI(BuildContext context){
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Under construction! It's dusty here, so please go to another page."),
          Image.network("https://img.icons8.com/clouds/100/road-closure.png")
        ],
      ),
    )
    ;
  }
}