import 'package:flutter/material.dart';

class dropButton extends StatefulWidget {

  List<String> list;

  @override
  _dropButtonState createState() => _dropButtonState(list);

  dropButton(
    {required this.list}
  );

}

class _dropButtonState extends State<dropButton> {

  List<String> list;

  _dropButtonState(this.list);

  String? dropdownValue; 

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value; 
        });
      },
      value: dropdownValue,
      hint: Text("Select Type"), 
    );
  }
}
