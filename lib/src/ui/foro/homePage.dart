import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_flutter_2/src/ui/foro/photoUpload.dart';
import 'package:flutter_firebase_flutter_2/src/ui/foro/posts.dart';


class Blogs extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<Blogs> {
  List<Posts> postList = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;

      postList.clear();

      for (var individualKey in keys) {
        Posts posts = Posts(
            data[individualKey]['image'],
            data[individualKey]['description'],
            data[individualKey]['date'],
            data[individualKey]['time']);

        postList.add(posts);
      }

      setState(() {
        print('Length: $postList.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: Container(
          child: postList.length == 0
              ? Text("")
              : ListView.builder(
                itemCount: postList.length,
                itemBuilder: (_, index){
                  return postsUI(
                    postList[index].image,
                    postList[index].description,
                    postList[index].date,
                    postList[index].time
                  );
                },
              ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.green,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context, 
                        MaterialPageRoute(builder: (context) {
                      return PhotoUpload();
                    }));
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget postsUI(String image, String description, String date, String time){
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(14.0),
      child: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Image.network(
              image,
              fit: BoxFit.cover
            ),
            SizedBox(height: 10.0,),
            Text(
              description,
              style: Theme.of(context).textTheme.subhead,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
