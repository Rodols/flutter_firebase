import 'file:///C:/Users/vazqu/AndroidStudioProjects/firebase_app/lib/src/pages/photoUpload.dart';
import 'package:firebase_app/src/widgets/Register.dart';
import 'package:firebase_app/src/widgets/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           RaisedButton(
               onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginModal()));
           },
             child: Text('Login'),
           ),
           RaisedButton(
             onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterRestaurant()));
             },
             child: Text('Register'),
           )
         ],
       )
      ),
    );
  }
}


