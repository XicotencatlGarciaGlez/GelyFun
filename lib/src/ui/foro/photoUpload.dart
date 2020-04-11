import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_flutter_2/src/ui/foro/homePage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';




class PhotoUpload extends StatefulWidget {
  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  File sampleImage; // imagen
  String _myValue; // descripcion
  String url; // url de la imagen
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subir Imagen"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: sampleImage == null ? Text("Seleciona una imagen") : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: getImage,
        tooltip: "Agregar Imagen",
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  Widget enableUpload() {
    return SingleChildScrollView(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Image.file(
                sampleImage,
                height: 300.0,
                width: 600.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Descripcion"),
                validator: (value) {
                  return value.isEmpty ? "Requiere una Descripcion" : null;
                },
                onSaved: (value) {
                  return _myValue = value;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                elevation: 10.0,
                child: Text("Agregar a nuevos post"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: uploadStatusImage,
              )
            ],
          ),
        ),
      ),
    ));
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      // Subir imagen a firebase storage
      final StorageReference postIamgeRef =
          FirebaseStorage.instance.ref().child("Post Images");
      var timeKey = DateTime.now();
      final StorageUploadTask uploadTask =
          postIamgeRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      print("Image url: " + url);

      // Guardar el post a firebase database: database realtime
      saveToDatabase(url);

      // Regresar a Home
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Blogs();
      }));
    }
  }

  void saveToDatabase(String url) {
    // Guardar un post (image, descripcion, date, time)
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "image": url,
      "description": _myValue,
      "date": date,
      "time": time
    };

    ref.child("Posts").push().set(data);
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
