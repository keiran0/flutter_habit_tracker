import 'package:flutter/material.dart';
import '../models/habit_model.dart';
import '../services/http_service.dart';

class HabitDetailPage extends StatelessWidget {

  final HabitModel habit;
  final _httpService = HTTPService();

  HabitDetailPage({
    required this.habit
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detailed View")),
      body: _buildUI(context)
    );
  }

  Widget _buildUI(BuildContext context) {
    return Column(children:[
      Text(habit.title),
      Text(habit.description),
      Text("Status: ${habit.state}"),
      habit.duration == 0 ? 
        Text("${habit.count.toString()} times per ${habit.frequency}") : 
        Text("${habit.count.toString()} times per ${habit.frequency} for ${habit.duration} minutes"),
      Text("Date added: ${habit.dateAdded.toString()}"),
      Text("Habit ID: " + habit.habitId.toString()), //todo: remove this after done
      _detailButtons(context)
    ]);
  }

  Widget _detailButtons(BuildContext context) {
      String textString = "suspended";
      String buttonString = "Suspend habit";
      print(habit.state);
      if (habit.state == "suspended") {
        textString = "active";
        buttonString = "Unsuspend habit";
      }

    return Row(children:[
      //delete
      ElevatedButton(onPressed: (){
        _httpService.deleteHabit({ "habit": habit });
        _showMyDialog("Habit deleted.", "", context);

      }, child: Text("Delete habit")),
      //suspend
      habit.state == 'archived' ? SizedBox.shrink() : ElevatedButton(onPressed: () {
        _httpService.changeHabitState({ "type": textString, "habit": habit });
        _showMyDialog("Habit suspended.", "To unsuspend this habit, click on the button again.", context);
      }, child: Text(buttonString)),
      //archive
      habit.state == 'archived' ? SizedBox.shrink() : ElevatedButton(onPressed: () {
        _httpService.changeHabitState({ "type": "archive", "habit": habit });
        _showMyDialog("Archive", "This habit has been archived. You can view archived habits from the home screen.", context);
      }, child: Text("Archive habit")),
    ]);
  }

  Future<void> _showMyDialog(String dialogTitle, String dialogText, BuildContext context) async { 
    //bad practice duplicating this from login_page.dart.
    //but i'm kinda short on time now due to academic workload and looming midterms.
    //possibly will do more abstraction here in the future when i have the time.
    //todo: deduplicate
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(dialogText)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/home");
              },
            ),
          ],
        );
      },
    );
  }

}