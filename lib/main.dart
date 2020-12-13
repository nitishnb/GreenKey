import 'package:flutter/material.dart';
import 'package:green_key/models/user.dart';
import 'package:green_key/screens/wrapper.dart';
import 'package:green_key/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Authservice().user,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      )
    );
  }
}
