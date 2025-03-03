import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import '../src/habit_frame.dart';

class HiddenHabits extends StatefulWidget {

  BuildContext context;
  List<HabitModel> habits;
  String buttonText;

  HiddenHabits(
    {required this.context,
    required this.habits,
    required this.buttonText}
  );

  @override
    State<StatefulWidget> createState() {
      return _HiddenState(this.context, this.habits, this.buttonText);
    }

}

class _HiddenState extends State<HiddenHabits> {

  BuildContext context;
  List<HabitModel> habits;
  String buttonText;

  _HiddenState(this.context, this.habits, this.buttonText);

  List<bool> showArchived = [false];

  @override
  Widget build(BuildContext context) {
    return _buildUI(context, habits);
  }

  Widget _buildUI(BuildContext context, List<HabitModel> habits) {
    return Column(children:[
      //showArchived[0] ? Text("button is switched on") : Text("Button is switched off") , //placeholder for actual builder todo: remove this
      _bottomButtons(context, showArchived, buttonText),
      _hiddenBuilder(context, habits)
    ]);
  }

  Widget _hiddenBuilder(BuildContext context, List<HabitModel> habits) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: habits.length,
      itemBuilder: (context, index) {
        if (habits.length > 0 && showArchived[0]) {
          return HabitFrame(context: context, habit: habits[index]);
        } else {
          return SizedBox.shrink();
        }
      }   
    );
  }

  Widget _bottomButtons(BuildContext context, List<bool> showHidden, String buttonText){
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
                Text(buttonText), 
                Switch(
                  value: showHidden[0], 
                  onChanged: (value)=> setState((){
                    showHidden[0] = value;
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