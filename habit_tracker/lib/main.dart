import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/add_habit_page.dart';
import 'package:habit_tracker/pages/log_habit_page.dart';
import 'package:habit_tracker/pages/settings_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(225, 238, 209, 112)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 55, 199, 42),
          titleTextStyle: TextStyle(
            color: Colors.black, 
            fontSize: 25, 
            fontWeight: FontWeight.bold
          )
        )
      ),
      initialRoute: "/home", //todo: change to login after testing
      routes: {
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignUpPage(),
        "/home": (context) => HomePage(),
        "/log": (context) => LogHabitPage(),
        "/settings": (context) => SettingsPage(),
        '/add': (context) => AddHabitPage()
        
      }
    );
  }
}