import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
void main() => runApp(MaterialApp(

));
 class Home extends StatefulWidget {
   @override
   _HomeState createState() => _HomeState();
 }
 
 class _HomeState extends State<Home> {
   @override
   Widget build(BuildContext context) {
      Widget image_slider_carousel = Container(
        height: 300,
        child: Carousel(
          boxFit: BoxFit.fill,
          images: [
            AssetImage('assets/bea.jpg'),
            AssetImage('assets/inf.jpg'),
            AssetImage('assets/inf2.jpg'),
            AssetImage('assets/inicio.png'),
          ],
          autoplay: false,
          indicatorBgPadding: 1.0,
          dotSize: 4.0,
          dotBgColor: Colors.white,
          
        ),
      );
     return Scaffold(
       body: ListView(
         children: <Widget>[
           image_slider_carousel,

            Center(
            
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: BounceInUp(
                child: 
              Text('GelyFun es una gelatina de agave.'
              +'Elaborada con fíbra Prebiótica, este producto regulariza y acelera el transito digestivo, el consumo diario de Gelyfun junto con una dieta saludable (equilibrada) puede disminuir el estreñimiento y los efectos secundarios por el uso de fármacos, mejorando así, la calidad de vida de las personas con este padecimiento.',
              textAlign: TextAlign.justify ,style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w600 ,),
        
              ),
              duration: Duration(seconds: 2),
              ),
            )
              
          )
         ],
       ),
     );
   }
 }



