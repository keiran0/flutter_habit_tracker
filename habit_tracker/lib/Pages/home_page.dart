import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_model.dart';
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
      appBar: AppBar(title: Text("Home")),
      body: SafeArea(child: _buildUI(context))
    );
  }

  Widget _buildUI(BuildContext context) {
    return _habitView(context);
  }

  Widget _habitView(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments.toString();
    return FutureBuilder(
      future: _httpService.getHabits(user), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("unable to load data"));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            HabitModel habit = snapshot.data![index];
            return ListTile(title: Text(habit.title));
          },
        );
      }
    );
  }
}