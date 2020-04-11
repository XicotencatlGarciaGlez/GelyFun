import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_flutter_2/src/ui/calendario/calendario.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
class DropDown extends StatefulWidget {
  DropDown() : super();
 
  final String title = "DropDown Demo";
 
  @override
  DropDownState createState() => DropDownState();
}

class Tomar{
  int id;
  String veces;
  Tomar(this.id, this.veces);
  static List<Tomar> getTomar(){
    return <Tomar>[
        Tomar(1,'Medeio litro agua'),
        Tomar(2,'De medio litro a un litro de agua '),
        Tomar(3,'De un litro a litro y medio'),
        Tomar(4, 'De litro y')
    ];
  }

}
 
class Bristol
 {
  int id;
  String name;
 
  Bristol(this.id, this.name);
 
  static List<Bristol> getBristiol() {
    return <Bristol>[
      Bristol(1, 'Tipo 1: Terrones duros separados,como tuercas (difíciles de evacuar)'),
      Bristol(2, 'Tipo 2: Parecido a una salchicha, pero aterronado'),
      Bristol(3, 'Tipo 3: Como una salchicha pero con grietas en su superficie'),
      Bristol(4, 'Tipo 4: Como una salchicha o una serpiente, lisa y suave'),
      Bristol(5, 'Tipo 5: Bolas blandas con los bordes definidos (fáciles de evacuar)'),
      Bristol(6,'Tipo 6: Pedazos blandos con los bordes desiguales'),
      Bristol(7,'Tipo 7: Acuosas, ningún sólido une las piezas (enteramente líquidas) ')
    ];
  }
}
 
class DropDownState extends State<DropDown> {
  //
  List<Bristol> _bristol = Bristol.getBristiol();
  List<DropdownMenuItem<Bristol>> _dropdownMenuItems;
  Bristol _selectedbirstol;
 
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
 
  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_bristol);
    _selectedbirstol = _dropdownMenuItems[0].value;
    super.initState();

  
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }
 
  List<DropdownMenuItem<Bristol>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Bristol>> items = List();
    for (Bristol company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(Bristol selectedCompany) {
    setState(() {
      _selectedbirstol = selectedCompany;
    });
  }

  

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }
 
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
       
        body: new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Registro diario sobre evacuaciones", textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),),
                ),
                SizedBox(
                  height: 30.0,
                  
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Escala de Bristol", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButton(
                    value: _selectedbirstol,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 10.0
                  ),
                ),
                Text('Selected: ${_selectedbirstol.name}', textAlign: TextAlign.center, ),
                SizedBox(
                  height: 20.0,
                ),
                
                Padding(padding: const EdgeInsets.all(8.0),

                child: SizedBox(
                  height: 10
                ),
                ),
                

                FlatButton(
                  child: Text("Guardar"),
                  onPressed: () {
                    
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Calendario();}));
                  },
                ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
