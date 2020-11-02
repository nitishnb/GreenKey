import 'package:flutter/material.dart';
import 'package:GreenKey/screens/authenticate/login.dart';
import 'package:GreenKey/screens/authenticate/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(()=> showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return LoginPage(toggleView: toggleView);
    }else{
      return SignupPage(toggleView: toggleView);
    }
  }
}