import 'package:Fireball/pages/home_page.dart';
import 'package:Fireball/pages/login/login_page.dart';
import 'package:flutter/material.dart';

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/': (BuildContext context) => new LoginPage(),
};