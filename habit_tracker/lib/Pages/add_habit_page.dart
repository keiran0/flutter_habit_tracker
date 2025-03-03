import 'package:flutter/material.dart';
import 'package:habit_tracker/src/dropdown.dart';
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

    List<String> typeDropdown = <String>['Count', 'Time'];

    return Form(child: Column(
      children: [
        TextFormField(decoration: InputDecoration(hintText: "Title")),
        TextFormField(decoration: InputDecoration(hintText: "Description")),
        dropButton(list: typeDropdown)
        
      ]));
  }


}