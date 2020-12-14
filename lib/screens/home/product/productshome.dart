import 'package:GreenKey/models/products.dart';
import 'package:GreenKey/screens/home/details.dart';
import 'package:GreenKey/screens/home/product/productlist.dart';
import 'package:GreenKey/services/proddatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/global.dart';
import 'package:provider/provider.dart';


class Productlist extends StatelessWidget {

  final String title, category;
  Productlist({this.category, this.title});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Prod>>.value(
      value: ProdDatabase().products,
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.lightGreen[700],
          elevation: 0.0,
        ),
        body:  ProdList(),
      ),
    );
  }
}
