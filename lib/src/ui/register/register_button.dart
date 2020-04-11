import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, background: Colors.lime,VoidCallback onPressed})
  
    : _onPressed = onPressed,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      
      color: Colors.lime,
      shape: RoundedRectangleBorder(
        
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text('Registrar'),
      
    );
  }
}