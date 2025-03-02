import 'package:flutter/material.dart';
import '../src/app_drawer.dart';

class LogHabitPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _LogHabitState();
  }

}

class _LogHabitState extends State<LogHabitPage>{

  @override
  Widget build(BuildContext context) {

    var user = ModalRoute.of(context)!.settings.arguments.toString(); 
    
    return Scaffold(
      appBar: AppBar(title: Text("Log habit")),
      body: SafeArea(child: _buildUI(context)),
      drawer: appDrawer(user: user)
    );
  }

  Widget _buildUI(BuildContext context){
    return Text("placeholder habit logging");
  }
}