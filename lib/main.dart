import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:GreenKey/models/user.dart';
import 'package:GreenKey/screens/wrapper.dart';
import 'package:GreenKey/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

