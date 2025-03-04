import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/src/app_drawer.dart';
import 'package:habit_tracker/src/hidden_habits.dart';
import 'package:habit_tracker/src/habit_frame.dart';
import '../services/http_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {

  GlobalKey<FormState> _HomeKey = GlobalKey();
  final _httpService = HTTPService();
  List<HabitModel> archivedHabits = [];
  List<HabitModel> suspendedHabits = [];
  
  @override
  Widget build(BuildContext context) {

    var user = ModalRoute.of(context)!.settings.arguments.toString(); //todo: remove bottom line after debugging.
    //String user = "123";
    
    return Scaffold(
      appBar: AppBar(title: Text("Habit View")),
      body: SafeArea(child: _buildUI(context)),
      drawer: appDrawer(user: user)
    );
  }

  Widget _buildUI(BuildContext context) {
    
    return SingleChildScrollView(
      child: Column(children: [
        _habitView(context),
        HiddenHabits(context: context, habits: suspendedHabits, buttonText: "View suspended",),
        HiddenHabits(context: context, habits: archivedHabits, buttonText: "View archived",)
      ]),
    );
    
  } 

  Widget _habitView(BuildContext context) {
    //var user = ModalRoute.of(context)!.settings.arguments.toString(); //todo: remove bottom line after debugging.
    String user = "123";

    return FutureBuilder(
      future: _httpService.getHabits(user), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("unable to load data"));
        }
        if (snapshot.data == null) {
          return Text("No items found");
        } else {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              
              HabitModel habit = snapshot.data![index];
              if (habit.state == 'active') {
                return HabitFrame(context: context, habit: habit);
              } else if (habit.state == 'suspended') {
                suspendedHabits.add(habit);
                return SizedBox.shrink();
              } else {
                archivedHabits.add(habit);
                return SizedBox.shrink();
              }
            },
          );
        }
      }
    );
  }

}