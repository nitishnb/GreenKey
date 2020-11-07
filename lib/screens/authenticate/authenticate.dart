import 'package:green_key/screens/authenticate/login.dart';
import 'package:green_key/screens/authenticate/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
      //print(showSignIn.toString());
      setState(() => showSignIn = !showSignIn);
    }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
          return LoginPage(toggleView:  toggleView);
        } else {
          return SignupPage(toggleView:  toggleView);
        }
  }
}