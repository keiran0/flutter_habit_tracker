import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/pages/habit_detail_page.dart';
import 'package:habit_tracker/src/app_drawer.dart';
import 'package:habit_tracker/src/toggle_button.dart';
import 'package:simple_heatmap_calendar/simple_heatmap_calendar.dart';
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
  List<bool> showArchived = [false];
  
  @override
  Widget build(BuildContext context) {

    //var user = ModalRoute.of(context)!.settings.arguments.toString(); //todo: remove bottom line after debugging.
    String user = "123";
    
    return Scaffold(
      appBar: AppBar(title: Text("Habit View")),
      body: SafeArea(child: _buildUI(context)),
      drawer: appDrawer(user: user)
    );
  }

  Widget _buildUI(BuildContext context) {
    
    return SingleChildScrollView(
      child: Column(children: [
        _habitView(context, showArchived),
        _bottomButtons(context, showArchived)
      ]),
    );
    
  }

  Widget _habitView(BuildContext context, List<bool> showArchived) {
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
                return _habitFrame(context, habit);
              } else if (habit.state == 'suspended') {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text("Suspended habits"),
                  ),
                  _habitFrame(context, habit)
                ],);
              } else if (showArchived[0] & (habit.state == 'archived')) {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text("Archived habits"),
                  ),
                  _habitFrame(context, habit)
                ],);
              } else {
                return SizedBox.shrink();
              }
            },
          );
        }
      }
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
              //child: ElevatedButton(onPressed: (){ print("viewing archived habits");}, child: const Text("View Archived Habits")),
              child: Row(children:[
                Text("View archived"), 
                Switch(
                  value: showArchived[0], 
                  onChanged: (value)=> setState((){
                    showArchived[0] = value;
                  })
                )]
                ))
                ]
              ),
        )
        );
  }

  Widget _habitFrame(context, habit) {
 
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
}