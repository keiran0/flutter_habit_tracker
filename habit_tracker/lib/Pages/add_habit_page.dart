import 'package:flutter/material.dart';

class AddHabitPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _AddHabitState();
  }

}

class _AddHabitState extends State<AddHabitPage>{

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Add habit")),
      body: SafeArea(child: _buildUI(context))
    );
  }

  Widget _buildUI(BuildContext context){
    return Text("placeholder add item");
  }
}