import 'package:flutter/material.dart';
import 'package:habit_tracker/services/http_service.dart';

class SignUpPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpPage> {

  final _httpService = HTTPService();

  GlobalKey<FormState> _SignUpFormKey = GlobalKey();

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: SafeArea(child: _buildUI(context))
    );
  }

  Widget _buildUI(context){
    return Column(children:[
      _signUpTitle(),
      _signUpForm(),
      _signUpButton(),
      _navigatorToLogin()
    ]);
  }

  Widget _signUpTitle(){
    return Text("Sign up to Motive!");
  }

  Widget _signUpForm() {

    return Form(
      key: _SignUpFormKey,
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

  Widget _signUpButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_SignUpFormKey.currentState?.validate() ?? false) {
          _SignUpFormKey.currentState?.save();
          final response = await _httpService.signup({ "username": username, "password": password });
          if (response!.statusCode == 201) {
            _showMyDialog("Success!", "Your account has been created! You may now login with the same credentials.");
          } else if (response.statusCode == 200) {
            _showMyDialog("This username has already been taken.", "Please enter another username.");
          } else if (response.statusCode == 404) {
            _showMyDialog("Something went wrong.", "Please try again later, or contact the developer.");
          } else {
            _showMyDialog("Something went very wrong.", "You're not supposed to see this screen. Contact the developer.");
          }
        }
      }, 
      child: Text("Sign Up")
    );
  }

  Widget _navigatorToLogin() {
    return Row(
      children: [
        Text("Have an account?"),
        ElevatedButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/login');
          }, 
          child: Text("Login")
        ),
      ]
    ); 
  }

  Future<void> _showMyDialog(String dialogTitle, String dialogText) async { 
    //bad practice duplicating this from login_page.dart.
    //but i'm kinda short on time now due to academic workload and looming midterms.
    //possibly will do more abstraction here in the future when i have the time.
    //todo: deduplicate
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
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