import 'dart:async';
import 'dart:ui';

import 'package:Fireball/data/database_helper.dart';
import 'package:Fireball/models/user.dart';
import 'package:Fireball/pages/login/login_presenter.dart';
import 'package:Fireball/utils/auth.dart';
import 'package:Fireball/utils/instagram.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class LoginPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginPageState(_scaffoldKey);
  }
}

Future<String> _testSignInWithGoogle() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  assert(user.email != null);
  assert(user.displayName != null);
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  print("This user is signed in $user");
  return 'signInWithGoogle succeeded: $user';
}

class LoginPageState extends State<LoginPage>
    implements LoginScreenContract, AuthStateListener {
  BuildContext _ctx;

  bool _isLoading = false;
  Token token;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password, _username;

  LoginScreenPresenter _presenter;

  LoginPageState(GlobalKey<ScaffoldState> skey) {
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
   _scaffoldKey = skey;
  }

  void _incrementCounter() {
    setState(() {});
    _testSignInWithGoogle();
  }

  void _login() {
    setState(() {
      _isLoading = true;
    });
    _presenter.perform_login();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed("/home");
  }

  GlobalKey<ScaffoldState> _scaffoldKey;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _LoginScreenState(GlobalKey<ScaffoldState> skey) {
    _presenter = new LoginScreenPresenter(this);
    _scaffoldKey = skey;
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  void onLoginError(String msg) {
    setState(() {
      _isLoading = false;
    });
    showInSnackBar(msg);
  }

  @override
  void onLoginScuccess(Token t) {
    setState(() {
      _isLoading = false;
      token = t;
    });
    showInSnackBar('Login successful');
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    bool _isFavorited = true;

    var loginBtn = new RaisedButton(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //new Image.network('https://flutter.io/images/favicon.png'),
          const Text("LOGIN"),
        ],
      ),
      onPressed: _submit,
      color: Theme.of(context).accentColor,
      elevation: 4.0,
      splashColor: Colors.deepOrange,
    ); //loginBtn

    var loginBtnGoogle = new RaisedButton(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //new Image.network('https://flutter.io/images/favicon.png'),
          const Text("Connect with Google"),
        ],
      ),
      onPressed: _incrementCounter,
      color: Theme.of(context).accentColor,
      elevation: 4.0,
      splashColor: Colors.deepOrange,
    ); //loginBtnGoogle

    var loginBtnInstagram = new RaisedButton(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //new Image.network('https://flutter.io/images/favicon.png'),
          const Text("Connect with Instagram"),
        ],
      ),
      onPressed: _login,
      color: Theme.of(context).accentColor,
      elevation: 4.0,
      splashColor: Colors.deepOrange,
    ); //loginBtnInstagram

    var loginForm = new Column(
      children: <Widget>[
        new Text(
          "Fireball",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  validator: (val) {
                    return val.length < 10
                        ? "Username must have atleast 10 chars"
                        : null;
                  },
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              ),
            ],
          ),
        ),
        _isLoading ? new CircularProgressIndicator() : loginBtn,
        _isLoading ? new CircularProgressIndicator() : loginBtnGoogle,
        _isLoading ? new CircularProgressIndicator() : loginBtnInstagram
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/img/fondo.jpg"), fit: BoxFit.cover),
        ),
        child: new Center(
          child: new ClipRect(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                child: loginForm,
                height: 300.0,
                width: 300.0,
                decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)),
              ),
            ),
          ),
        ),
      ),
    );
  }

/*
  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  } */

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }
}
