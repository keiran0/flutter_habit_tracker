import 'package:flutter/material.dart';
import 'package:simple_heatmap_calendar/simple_heatmap_calendar.dart';
import 'package:habit_tracker/pages/habit_detail_page.dart';
import '../models/habit_model.dart';

class HabitFrame extends StatefulWidget {

  BuildContext context;
  HabitModel habit;

  HabitFrame({
    required this.context,
    required this.habit
  });

  @override
  State<StatefulWidget> createState() {
    return _HabitFrameState(context, habit);
  }
}

class _HabitFrameState extends State<HabitFrame> {

  BuildContext context;
  HabitModel habit;
  _HabitFrameState(this.context, this.habit);

  @override
  Widget build(BuildContext context) {
    return _buildUI(context, habit);
  }

  Widget _buildUI(BuildContext context, HabitModel habit) {
    
    List<DateTime> trackingDates = [];

    if (habit.tracking.length > 0) {
      for (Object obj in habit.tracking) {
        if (obj != null) {
          trackingDates.add(DateTime.parse(obj as String));
        }
      }
    }
  
    var map1 = Map.fromIterable(trackingDates, key: (e) => DateTime(e.year, e.month, e.day), value: (e) => 1 as num);

    return ListTile(
      onTap: () { 
        Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return HabitDetailPage(habit: habit);
          })
        );
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(habit.title),
          Text(habit.tracking.toString()),
          HeatmapCalendar<num>(
            startDate: DateTime(habit.dateAdded.year, habit.dateAdded.month, habit.dateAdded.day), 
            endedDate: DateTime.now().add(Duration(days: 61)),
            colorMap: {
              1: const Color.fromARGB(255, 81, 255, 12)
            },
            // selectedMap: map1,
            selectedMap: map1
          ),
        ],
      ),
    );
  }

}
