import 'package:flutter/material.dart';
import '../services/http_service.dart';

class LoginPage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  final _httpService = HTTPService();

  GlobalKey<FormState> _LoginFormKey = GlobalKey();
  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SafeArea(child: _buildUI(context))
    );
  }

  Widget _buildUI(context){
    return Column(children:[
      _loginTitle(),
      _loginForm(),
      _loginButton(),
      _navigatorToSignUp()
    ]);
  }

  Widget _loginTitle(){
    return Text("Welcome back to Motive!");
  }

  Widget _loginForm() {

    return Form(
      key: _LoginFormKey,
      child: Column(
        children:[
          TextFormField(
            decoration: InputDecoration(hintText: "Username"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Username cannot be empty";
              }
            },
            onSaved: (value) {
              setState(() {
                username = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "Password"),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password cannot be empty";
              }
            },
            onSaved: (value) {
              setState(() {
                password = value;
              });
            },
          )
        ]
      )
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_LoginFormKey.currentState?.validate() ?? false) {
          _LoginFormKey.currentState?.save();
          final response = await _httpService.login({ "username": username, "password": password });
          if (response!.statusCode == 200) {
            Navigator.pushReplacementNamed(context, '/home', arguments: username);
          } else if (response.statusCode == 401) {
            print("Wrong password");
            _showMyDialog("Wrong password", "Please check your username and password again.");
          } else if (response.statusCode == 404) {
            print("Account does not exist.");
            _showMyDialog("Account does not exist!", "Please sign up for an account before logging in.");
          }
          
        }
      }, 
      child: Text("Login")
    );
  }

  Widget _navigatorToSignUp() {
    return Row(
      children: [
        Text("No account yet?"),
        ElevatedButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/signup');
          }, 
          child: Text("Sign up")
        ),
      ]
    ); 
  }

  Future<void> _showMyDialog(String dialogTitle, String dialogText) async { //grabbed from flutter api
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(dialogText)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
}

