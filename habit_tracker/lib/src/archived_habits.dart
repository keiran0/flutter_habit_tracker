import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import '../Pages/habit_detail_page.dart';
import 'package:simple_heatmap_calendar/simple_heatmap_calendar.dart';

class ArchivedHabits extends StatefulWidget {

  BuildContext context;
  List<HabitModel> habits;

  ArchivedHabits(
    {required this.context,
    required this.habits}
  );

  @override
    State<StatefulWidget> createState() {
      return _ArchivedState(this.context, this.habits);
    }

}

class _ArchivedState extends State<ArchivedHabits> {

  BuildContext context;
  List<HabitModel> habits;

  _ArchivedState(this.context, this.habits);

  List<bool> showArchived = [false];

  @override
  Widget build(BuildContext context) {
    return _buildUI(context, habits);
  }

  Widget _buildUI(BuildContext context, List<HabitModel> habits) {
    return Column(children:[
      //showArchived[0] ? Text("button is switched on") : Text("Button is switched off") , //placeholder for actual builder todo: remove this
      _bottomButtons(context, showArchived),
      _archivedBuilder(context, habits)
    ]);
  }

  Widget _archivedBuilder(BuildContext context, List<HabitModel> habits) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: habits.length,
      itemBuilder: (context, index) {
        if (habits.length > 0) {
          return _habitFrame(context, habits[index]);
        } else {
          return SizedBox.shrink();
        }
      }   
    );
  }

  Widget _habitFrame(context, habit) { //todo: deduplicate code from across here and home_page.
 
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
          HeatmapCalendar<num>(
            startDate: DateTime(habit.dateAdded.year, habit.dateAdded.month, habit.dateAdded.day), 
            endedDate: DateTime(2026, 2, 1)
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons(BuildContext context, List<bool> showArchived){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.05,
        child: ListView(
          scrollDirection: Axis.horizontal, 
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(children:[
                Text("View archived"), 
                Switch(
                  value: showArchived[0], 
                  onChanged: (value)=> setState((){
                    showArchived[0] = value;
                  })
                )
              ])
            )
          ]
        ),
      )
    );
  }
}