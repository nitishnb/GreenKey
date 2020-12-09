import 'package:green_key/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:green_key/screens/wrapper.dart';
import 'package:green_key/models/user.dart';


void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
    home: MyApp(),
  )
  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Start(),
      ),
    );
  }
}

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState(){
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
          (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=> Wrapper(),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Image.asset('assets/greenkey4.jpg',fit: BoxFit.fill,
      ),
    ),
    );
  }
}



