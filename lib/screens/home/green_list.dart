
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:green_key/models/green.dart';
import 'package:green_key/screens/home/green_tile.dart';

class GreenList extends StatefulWidget {
  @override
  _GreenListState createState() => _GreenListState();
}

class _GreenListState extends State<GreenList> {
  @override
  Widget build(BuildContext context) {

    final green = Provider.of<List<Green>>(context) ?? [];

    return ListView.builder(
      itemCount: green.length,
      itemBuilder: (context, index) {
        return GreenTile(green: green[index]);
      },
    );
  }
}
