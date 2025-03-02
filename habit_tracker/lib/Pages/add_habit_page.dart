import 'package:flutter/material.dart';
import '../src/app_drawer.dart';

class AddHabitPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _AddHabitState();
  }

}

class _AddHabitState extends State<AddHabitPage>{

  @override
  Widget build(BuildContext context) {

    var user = ModalRoute.of(context)!.settings.arguments.toString(); 
    
    return Scaffold(
      appBar: AppBar(title: Text("Add habit")),
      body: SafeArea(child: _buildUI(context)),
      drawer: appDrawer(user: user)
    );
  }

  Widget _buildUI(BuildContext context){
    return Text("placeholder add item");
  }
}