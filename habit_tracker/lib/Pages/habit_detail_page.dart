import 'package:flutter/material.dart';
import '../models/habit_model.dart';

class HabitDetailPage extends StatelessWidget {

  final HabitModel habit;

  HabitDetailPage({
    required this.habit
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(habit.title)),
      body: _buildUI()
    );
  }

  Widget _buildUI() {
    return Column(children:[
      Text(habit.description),
      Text("Status: ${habit.state}"),
      habit.duration == 0 ? 
        Text("${habit.count.toString()} times per ${habit.frequency}") : 
        Text("${habit.count.toString()} times per ${habit.frequency} for ${habit.duration} minutes"),
      Text("Date added: ${habit.dateAdded.toString()}"),
      Text("Habit ID: " + habit.habitId.toString()), //todo: remove this after done
      _detailButtons()
    ]);
  }

  Widget _detailButtons() {
    return Row(children:[
      ElevatedButton(onPressed: (){print('Delete habit');}, child: Text("Delete habit")),
      ElevatedButton(onPressed: (){print('Suspend habit');}, child: Text("Suspend habit")),
      ElevatedButton(onPressed: (){print('Archive habit');}, child: Text("Archive habit")),
    ]);
  }

}