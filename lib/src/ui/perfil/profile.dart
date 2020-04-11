import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        
        child: Column(
          
          children: <Widget>[
            
            Container(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 100, horizontal: 52),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white54,
                        backgroundImage: AssetImage('assets/perfil.png'),
                        radius: 80.0,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Text(
                      "Nombre :                 Miguel ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Apellido PAterno  :     Romero",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Apellido Materno :     Ramires",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Correo:      miguel@rozvo.com",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600 ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                   
                      ],
                    ),))
                  ],
                ),
              ),);
            
  }
}