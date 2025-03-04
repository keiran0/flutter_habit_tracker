import 'package:flutter/material.dart';
import '../src/app_drawer.dart';
import '../services/http_service.dart';
import '../models/habit_model.dart';
import 'package:intl/intl.dart';

class LogHabitPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogHabitState();
  }
}

class _LogHabitState extends State<LogHabitPage> {
  GlobalKey<FormState> _LogKey = GlobalKey();
  final _httpService = HTTPService();

  @override
  Widget build(BuildContext context) {
    //var user = ModalRoute.of(context)!.settings.arguments.toString(); todo: remove
    var user = "123";

    return Scaffold(
        appBar: AppBar(title: Text("Log habit")),
        body: SafeArea(child: _buildUI(context)),
        drawer: appDrawer(user: user));
  }

  Widget _buildUI(BuildContext context) {
    return _logActiveHabitView(context);
  }

  bool canAddNewDate(List<dynamic> dateTimes) {
    DateTime today = DateTime.now();
    String todayStr = DateFormat('yyyy-MM-dd').format(today);

    for (String dateStr in dateTimes) {
      DateTime date = DateTime.parse(dateStr);
      String dateOnly = DateFormat('yyyy-MM-dd').format(date);

      if (dateOnly == todayStr) {
        print("this habit will not show up on the log page");
        return false;
      }
    }
    return true;
  }

  Widget _logActiveHabitView(BuildContext context) {
  var user = "123";

  return FutureBuilder(
    future: _httpService.getHabits(user),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return const Center(child: Text("Unable to load data"));
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No habits found."));
      }

      List<HabitModel> activeHabits = snapshot.data!.where((habit) =>
          habit.state == 'active' &&
          habit.currCount < habit.count &&
          canAddNewDate(habit.tracking)).toList();

      if (activeHabits.isEmpty) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("No habits to track for today!"),
              Image.network("https://img.icons8.com/clouds/100/smiling-sun.png")
            ],
          ),
        );
        
      }

      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: activeHabits.length,
        itemBuilder: (context, index) {
          HabitModel habit = activeHabits[index];

          if (habit.state == 'active' && habit.currCount < habit.count && canAddNewDate(habit.tracking)) {
            if (habit.duration > 0) {
              return _duration(context, habit);
            } else {
              return _countOnly(context, habit);
            }
          } else {
            return SizedBox.shrink();
          }
        }
      );
    },
  );
}


  Widget _duration(BuildContext context, HabitModel habit) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              child: Text(habit.title),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              child: Row(
                children: [
                  Text(habit.count.toString() + " times, "),
                  Text(habit.duration.toString() + " minutes")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              child: Row(
                children: [_counter(context, habit), Text("timer here")],
              ),
            )
          ],
        ));
  }

  Widget _countOnly(BuildContext context, HabitModel habit) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              child: Text(habit.title),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              child: Text(habit.count.toString() + " times"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
              child: _counter(context, habit),
            )
          ],
        ));
  }

  Widget _counter(BuildContext context, HabitModel habit) {

    var user = ModalRoute.of(context)!.settings.arguments.toString();
    //counter only appears for habits that are not done yet.
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            if (habit.currCount > 0) {
              habit.currCount -= 1;
              _httpService.changeHabitCount(
                  {"habit": habit, "newCount": habit.currCount});
            }
            (context as Element).markNeedsBuild();
          },
          child: Text("-"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child:
              Text(habit.currCount.toString() + "/" + habit.count.toString()),
        ),
        ElevatedButton(
          onPressed: () {
            if (habit.currCount < habit.count) {
              habit.currCount += 1;
              _httpService.changeHabitCount({"habit": habit});
              (context as Element).markNeedsBuild();
            }
            if (habit.currCount >= habit.count) {
              //print("Calling markAsCompleted");
              _httpService.markAsCompleted(
                  {"habit": habit, "date": DateTime.now().toIso8601String()});
                  Navigator.pushReplacementNamed(context, 'log', arguments: user);
            }
          },
          child: Text("+"),
        ),
      ],
    );
  }
}
