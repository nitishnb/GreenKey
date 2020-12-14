import 'package:flutter/material.dart';
import 'package:green_key/models/green.dart';

class GreenTile extends StatelessWidget {

  final Green green;
  GreenTile({ this.green });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[200],
          ),
          title: Text(green.uname),
          subtitle: Text( green.mobile ),
        ),
      ),
    );
  }
}
