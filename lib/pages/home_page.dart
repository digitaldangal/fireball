import 'package:Fireball/pages/about_page.dart';
import 'package:Fireball/pages/friends/friends_page.dart';
import 'package:Fireball/pages/new_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePageState(user);
  }
//_HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseUser user;

  _HomePageState(this.user);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountEmail: new Text(
                user.email,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              accountName: new Text(
                user.displayName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(user.photoUrl),
                ),
                onTap: () => print("This is your current account."),
              ),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(
                          "https://i1.wp.com/cdn.akamai.steamstatic.com/steam/apps/586950/ss_6165fb0236ecbf575d0383facd55075cc96e308c.600x338.jpg?resize=600%2C337"),
                      fit: BoxFit.fill)),
            ),

            //ListTile menu
            new ListTile(
                title: new Text("Games now"),
                trailing: new Icon(Icons.games),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new NewPage(
                          "Games now"))); //MaterialpageRoute  Transfers
                }), //ListTitle 1

            new ListTile(
                title: new Text("Friends"),
                trailing: new Icon(Icons.people),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new FriendsPage(user))); //MaterialpageRoute Scrape
                }), //ListTitle 2

            new ListTile(
                title: new Text("Setting"),
                trailing: new Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new NewPage("Setting"))); //MaterialpageRoute Setting
                }), //ListTitle 3

            new ListTile(
                title: new Text("About app"),
                trailing: new Icon(Icons.more),
                onTap: () {
                  new AboutPage();
                } //LostTile
                ), //ListTitle 4

            new ListTile(
                title: new Text("Sing Out"),
                trailing: new Icon(Icons.close),
                onTap: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).pop();
                } //LostTile
                ), //ListTitle 5
          ], //Widget []
        ), //listview
      ), //drawer
      body: new Center(
        child: new Text("Home Page"),
      ),
    );
  }
}
