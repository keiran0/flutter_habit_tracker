import 'package:flutter/material.dart';
import './Pages/login_page.dart';
import './Pages/signup_page.dart';
import './Pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 17, 138, 219)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 88, 130, 177),
          titleTextStyle: TextStyle(
            color: Colors.black, 
            fontSize: 25, 
            fontWeight: FontWeight.bold
          )
        )
      ),
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignUpPage(),
        "/home": (context) => HomePage(),
        
      }
    );
  }
}