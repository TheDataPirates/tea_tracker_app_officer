import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _emailFieldController = TextEditingController();
  static final _passwordFieldController = TextEditingController();

  static TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final emailField = TextField(
    controller: _emailFieldController,
    obscureText: false,
    style: style,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "Email",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );
  final passwordField = TextField(
    controller: _passwordFieldController,
    obscureText: true,
    style: style,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0,),
        onPressed: () {
          Navigator.of(context).pushNamed('MainMenu');
          print(_emailFieldController.text);
          print(_passwordFieldController.text);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg1.jpg"),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
//            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Colors.black, width: 4.0)),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.asset(
                        "images/logo.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Container(
                      child: emailField,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Container(
                      child: passwordField,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    loginButon,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
