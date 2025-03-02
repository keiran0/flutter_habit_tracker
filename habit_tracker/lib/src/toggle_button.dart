import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ToggleButtonState();
  }
}

class _ToggleButtonState extends State<ToggleButton>{

  final List<Widget> options = <Widget>[Text('On'), Text('Off')];
  final List<bool> _selectedOptions = <bool>[true, false];

  @override
  Widget build(BuildContext) {
    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _selectedOptions.length; i++) {
            _selectedOptions[i] = i == index;
          }
        });
      },
      constraints: const BoxConstraints(minHeight: 40.0, minWidth: 80.0),
      isSelected: _selectedOptions,
      children: options,
    );
  }
}