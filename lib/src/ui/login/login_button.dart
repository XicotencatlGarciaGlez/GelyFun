import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
    : _onPressed = onPressed,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      shape: RoundedRectangleBorder(
      
       borderRadius: BorderRadius.circular(30.0),
      ),
      
      onPressed: _onPressed,
      color: Color(0xff1B5E20),
      child: Text('Iniciar', style: TextStyle(fontSize:20, color: Colors.white)),
    );
  }
}