import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/authentication_bloc/bloc.dart';
import 'package:flutter_firebase_flutter_2/src/ui/calendario/calendario.dart';
import 'package:flutter_firebase_flutter_2/src/ui/chart/chat.dart';
import 'package:flutter_firebase_flutter_2/src/ui/chat/chat.dart';
import 'package:flutter_firebase_flutter_2/src/ui/home/home.dart';
import 'package:flutter_firebase_flutter_2/src/ui/perfil/profile.dart';
import 'package:flutter_firebase_flutter_2/src/ui/splash_screen.dart';

import 'foro/homePage.dart';


class HomeScreen extends StatefulWidget {

HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  
  int _selectDraI = 0;
  _getDrawerItemWidget(int pos){
    switch (pos) {
      case 0: return Home();
      case 1: return Calendario();
      case 2: return Chart();
      case 3: return ChatScreen();
      case 4: return Profile();
      case 5: return Blogs();
      case 6: return SplashScreen();
    }
  }
  _onSElect(int pos){
    setState(() {
      Navigator.of(context).pop();
      _selectDraI = pos;
    });

  }
@override
  Widget build(BuildContext context) {
void _showSnackBar(String text, String ans) {
      final snackBar = SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor:
          ans.compareTo("Yes") == 0 ? Colors.green : Colors.red,
          content: Row(
            children: <Widget>[
              Icon(
                ans.compareTo(" Gracias Por seguir con tu tratamiento") == 0 ? Icons.favorite : Icons.watch_later,
                color: ans.compareTo("Yes") == 0 ? Colors.red : Colors.yellow,
                size: 24.0,
                semanticLabel: text,
              ),
              Text(text)
            ],
          ));
      
    }

    Future<void> _simpleDialog() async {
      switch (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Es hora de consumir tu proporcion de gelatina'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, "Yes");
                  },
                  child: const Text('Yes'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, "No");
                  },
                  child: const Text('No'),
                ),
              ],
            );
          })) {
        case "Yes":
          _showSnackBar('Perfecro sigue', "Yes");
          break;
        case "No":
          _showSnackBar("Debes de consumir tu proporcion  para continuar con el tratamiento ", "");
          break;
      }
    }
  
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff52BE48),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications_active),
                onPressed: () {
                  _simpleDialog();
                },
              )
            ],
          ),
          
          //Inicio del menu lateral 
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                //Cabecera del menu
                
               UserAccountsDrawerHeader(accountName: Text('Miguel R'), 
                decoration: BoxDecoration( color: Colors.green),
                accountEmail: Text('miguel@rozvo.com' ,style: TextStyle(color: Colors.white, 
            fontSize: 20, fontWeight: FontWeight.w600),),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(backgroundImage: AssetImage('assets/perfil.png'),
              backgroundColor: Colors.white, )
            ),
            ),// fin de la cabezera 
            //Inicio de la lista de item del menu 
            ListTile(
              leading: Icon(Icons.home),
              selected: (0 == _selectDraI ),
              title: Text('Inicio', style: TextStyle(fontSize:20, fontWeight: FontWeight.w800), ),
              onTap: (){
                _onSElect(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              selected: (1 == _selectDraI),
              title: Text('Calendario', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800)),
              onTap: (){
                _onSElect(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.trending_up),
              selected: (2 == _selectDraI),
              title: Text('Estadisticas', style: TextStyle(fontSize:20, fontWeight: FontWeight.w800)),
              onTap: (){
                _onSElect(2);
              },
            ),
            ListTile(
              leading: Icon(Icons.forum),
              selected: (3 == _selectDraI ),
              title: Text('Ayuda', style: TextStyle(fontSize:20, fontWeight: FontWeight.w800)),
              onTap: (){
                _onSElect(3);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              selected: (4 == _selectDraI ),
              title: Text('Perfil', style: TextStyle(fontSize:20, fontWeight: FontWeight.w800)),
              onTap: (){
                _onSElect(4);
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              selected: (5 == _selectDraI ),
              title: Text('Foro', style: TextStyle(fontSize:20, fontWeight: FontWeight.w800)),
              onTap: (){
                _onSElect(5);
              },
            ), Divider(),
          /*  ListTile(
              leading: Icon(Icons.info),
              selected: (6 == _selectDraI),
              title: Text('Informacion',style: TextStyle(fontSize:20, fontWeight: FontWeight.w800)),
              onTap: (){
                _onSElect(6);
              },
            ),*/
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Salir', style: TextStyle(fontSize:20, fontWeight: FontWeight.w800), ),
              onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            }
            )

          ],

        ) // fin de la lista del menu 
      ), // fin del menu ),
      body: _getDrawerItemWidget(_selectDraI),
    );
  }
  
}