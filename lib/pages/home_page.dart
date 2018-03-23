import 'package:flutter/material.dart';
import 'package:Fireball/pages/new_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
        title: new Text("Home"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[

            //UserAccountsDrawerHeader
            new UserAccountsDrawerHeader(
              accountName: new Text("Usuario Name"),
              accountEmail: new Text("Scores: 5"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.grey : Colors.deepPurple,
                child: new Text("J"),
              ),//CircleAvatar
              otherAccountsPictures: <Widget>[
                new CircleAvatar(
                  backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ?  Colors.grey : Colors.deepPurple,
                  child: new Text("L"),
                ),
              ],//OtherCircleAvatar
            ),//UserAccountsDrawerHeader

            //ListTile menu
            new ListTile(
                title: new Text("Games now"),
                trailing: new Icon(Icons.games),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>
                  new NewPage("Games now"))); //MaterialpageRoute  Transfers
                }
            ), //ListTitle 1

            new ListTile(
                title: new Text("Friends"),
                trailing: new Icon(Icons.people),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>
                  new NewPage("Friends"))); //MaterialpageRoute Scrape
                }
            ),  //ListTitle 2

            new ListTile(
                title: new Text("Setting"),
                trailing: new Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>
                  new NewPage("Setting"))); //MaterialpageRoute Setting
                }
            ), //ListTitle 3

            new ListTile(
                title: new Text("Sing Out"),
                trailing: new Icon(Icons.close),
                onTap: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).pop();
                }//LostTile
            ), //ListTitle 4

          ],//Widget []
        ),//listview
      ),//drawer
      body: new Center(
        child: new Text("Home Page"),
      ),
    );
  }
}
