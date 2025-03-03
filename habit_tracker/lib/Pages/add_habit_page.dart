import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    //Widget typeDropButton = dropButton(list: typeDropdown);

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Form(child: Column(
        children: [
          TextFormField(decoration: InputDecoration(hintText: "Title")),
          TextFormField(decoration: InputDecoration(hintText: "Description")),
          // Row(children: [
          //   Text("Habit Type"),
          //   typeDropButton
          // ]),
          Row(children: [
            Expanded(child: TextFormField(decoration: InputDecoration(hintText: "Number"))),
            Expanded(child: Text("times per day"))
          ]),
          Row(
            children: [
              Expanded(child: TextFormField(decoration: InputDecoration(hintText: "Number"))),
              Expanded(child: Text("minutes per day")),
            ]
          ),
          ElevatedButton(onPressed: (){print("ok");}, child: Text("Save"))
        ])),
    );
  }


}