import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
import 'package:habit_tracker/pages/habit_detail_page.dart';
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
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Habit View")),
      body: SafeArea(child: _buildUI(context))
    );
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        _habitView(context),
        _bottomButtons(context)
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
                return _habitFrame(habit);
              } else if (habit.state == 'suspended') {
                return Column(children: [
                  Text("Suspended habits"),
                  _habitFrame(habit)
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

  Widget _bottomButtons(context){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.05,
        child: ListView(
          scrollDirection: Axis.horizontal, 
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(onPressed: (){ print("viewing archived habits");}, child: const Text("View Archived Habits")),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(onPressed: (){ print("adding new habit");}, child: const Text("Add new habit")),
            ),
          ]
        )
      ),
    );
  }

  Widget _habitFrame(habit) {
    
    return ListTile(
      onTap: () { 
        Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return HabitDetailPage(habit: habit);
          })
        );
      },
      title: Text(habit.title),
      isThreeLine: true,
      subtitle: HeatmapCalendar<num>(startDate: DateTime(2025, 1,1), endedDate: DateTime(2025, 02,1)),
      trailing: (
        habit.duration == 0 ? 
        Text("${habit.count.toString()} times per ${habit.frequency}") : 
        Text("${habit.count.toString()} times per ${habit.frequency} for ${habit.duration} minutes")
      )
    );
  }
}