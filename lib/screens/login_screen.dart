import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/bought_leaf/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isLoading = false;
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

  var _editedUser = User(user_id: '', password: '');

  static TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  Future<void> submit() async {
    if (_fbkey.currentState.saveAndValidate()) {
      setState(() {
        _isLoading = true;
      });
      final provider = Provider.of<Auth>(context, listen: false);
      try {
        await provider.login(_editedUser.user_id, _editedUser.password);

        Navigator.of(context).pushReplacementNamed('MainMenu');
      } catch (e) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('AlertDialog'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('An error occurred'),
                    Text(e.toString()),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FormBuilder(
              key: _fbkey,
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: mediaQuery.height * 0.3,
                            child: Image.asset(
                              "images/logo.jpg",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: mediaQuery.height * 0.15),
                          Container(
                            child: FormBuilderTextField(
                              attribute: "User-name",
                              obscureText: false,
                              style: style,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "User-name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              validators: [FormBuilderValidators.required()],
                              onSaved: (value) {
                                _editedUser = User(
                                    user_id: value,
                                    password: _editedUser.password);
                              },
                            ),
                            height: mediaQuery.height * 0.1,
                          ),
                          SizedBox(height: mediaQuery.height * 0.01),
                          Container(
                            child: FormBuilderTextField(
                              attribute: "Password",
                              obscureText: true,
                              style: style,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              validators: [FormBuilderValidators.required()],
                              onSaved: (value) {
                                _editedUser = User(
                                    user_id: _editedUser.user_id,
                                    password: value);
                              },
                            ),
                            height: mediaQuery.height * 0.1,
                          ),
                          SizedBox(
                            height: mediaQuery.height * 0.05,
                          ),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Theme.of(context).primaryColor,
                            child: MaterialButton(
                              minWidth: mediaQuery.width,
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: submit,
                              child: Text("Login",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(
                            height: mediaQuery.height * 0.1,
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
