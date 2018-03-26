import 'package:Fireball/utils/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fireball',
      theme: new ThemeData(
          primarySwatch: Colors.amber
      ),
      routes: routes,
    );
  }
}
