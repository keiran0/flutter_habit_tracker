import 'package:flutter/material.dart';
import 'package:habit_tracker/services/http_service.dart';
import '../src/app_drawer.dart';

class AddHabitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddHabitState();
  }
}

class _AddHabitState extends State<AddHabitPage> {

  GlobalKey<FormState> _HabitAddFormKey = GlobalKey();
  String? title, description, count, minutes;
  final _httpService = HTTPService();

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
        appBar: AppBar(title: Text("Add habit")),
        body: SafeArea(child: _buildUI(context)),
        drawer: appDrawer(user: user));
  }

  Widget _buildUI(BuildContext context) {
    //List<String> typeDropdown = <String>['Count', 'Time'];
    var user = ModalRoute.of(context)!.settings.arguments.toString();

    //Widget typeDropButton = dropButton(list: typeDropdown);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
          width: MediaQuery.sizeOf(context).width, 
          child: Column(
            children: [
              _Form(context),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_HabitAddFormKey.currentState?.validate() ?? false) {
                      _HabitAddFormKey.currentState?.save();
                      final response = await _httpService.addHabit({ 
                        "title": title,
                        "description": description,
                        "count": int.parse(count!),
                        "minutes" : int.parse(minutes!),
                        "dateAdded": DateTime.now().toIso8601String(),
                        "username": user,
                      });
                      if (response!.statusCode == 200) {
                        print("successful req");
                        Navigator.pushReplacementNamed(context, '/home', arguments: user);
                      } else if (response.statusCode == 404) {
                        print('unsuccessful');
                      } else {
                       print("this isnt supposed to happen");
                      }
                    }
                  },
                  child: Text("Save")
                ),
              )
                 
            ],
          )),
    );
  }

  Widget _Form(BuildContext context) {
    return Form(
        key: _HabitAddFormKey,
        child: Column(children: [
          TextFormField(validator: (value) {
              if (value == null || value.isEmpty) {
                return "Field cannot be empty";
              }
            },decoration: InputDecoration(hintText: "Title"), onSaved: (value) {
              setState(() {
                title = value;
              });
            },),
          TextFormField(validator: (value) {
              if (value == null || value.isEmpty) {
                return "Field cannot be empty";
              }
            },decoration: InputDecoration(hintText: "Description"), onSaved: (value) {
              setState(() {
                description = value;
              });
            },),
          // Row(children: [
          //   Text("Habit Type"),
          //   typeDropButton
          // ]),
          Row(children: [
            Expanded(
                child: TextFormField(
                    validator: (value) {
              if (value == null || value.isEmpty) {
                return "Field cannot be empty";
              }
            },
                    decoration: InputDecoration(hintText: "Number"),
                    onSaved: (value) {
              setState(() {
                count = value;
              });
            },)),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("times per day"),
            ))
          ]),
          // Row(children: [
          //   Expanded(
          //       child: TextFormField(validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return "Field cannot be empty";
          //     }
          //   },
          //           decoration: InputDecoration(hintText: "Number"),
          //           onSaved: (value) {
          //     setState(() {
          //       minutes = value;
          //     });
          //   },)),
          //   Expanded(child: Padding(
          //     padding: const EdgeInsets.all(15.0),
          //     child: Text("minutes per day"),
          //   )),
          // ]),
          
        ]));
  }
}
