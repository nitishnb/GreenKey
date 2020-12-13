import 'package:flutter/material.dart';
import 'package:green_key/models/user.dart';
import 'package:green_key/screens/admin/home.dart';
import 'package:green_key/screens/authenticate/authenticate.dart';
import 'package:green_key/screens/authenticate/signIn.dart';
import 'package:green_key/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:green_key/services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user !=  null)
      return Home();
    else
      return Authenticate();
  }
}
