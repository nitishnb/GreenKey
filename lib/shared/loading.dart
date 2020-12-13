import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[200],
      child: SpinKitRing(
        color: Colors.brown[800],
        size: 50.0,
      ),
    );
  }
}
