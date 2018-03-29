import 'package:Fireball/pages/about_page.dart';
import 'package:Fireball/pages/new_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentProfilePic =
      "https://i2.linio.com/p/97c2dc437a41110add60342bc922242d-product.jpg";
  String otherProfilePic =
      "https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";

  void switchAccounts() {
    String picBackup = currentProfilePic;
    this.setState(() {
      currentProfilePic = otherProfilePic;
      otherProfilePic = picBackup;
    });
  }

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
                "jsloravargas@gmail.com",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              //new Text("jsloravargas@gmail.com"),
              accountName: new Text(
                "JoseLora",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              // new Text("JoseLora"),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(currentProfilePic),
                ),
                onTap: () => print("This is your current account."),
              ),
              otherAccountsPictures: <Widget>[
                new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(otherProfilePic),
                  ),
                  onTap: () => switchAccounts(),
                ),
              ],
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
                          new NewPage("Friends"))); //MaterialpageRoute Scrape
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
