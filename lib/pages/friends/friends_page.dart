import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  final FirebaseUser user ;
  //final String title;

  FriendsPage(this.user);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(user.displayName),
      ), //AppBar
      body: new Center(
        child: new Text(user.email),
      ), //Center
    ); //Scaffold
  }
}