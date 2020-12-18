import 'package:GreenKey/models/products.dart';
import 'package:GreenKey/screens/home/details.dart';
import 'package:GreenKey/screens/home/product/product_tile.dart';
import 'package:GreenKey/services/proddatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/global.dart';
import 'package:provider/provider.dart';

class Productlist extends StatefulWidget {
  final String title, category;
  Productlist({this.category, this.title});
  @override
  _ProductlistState createState() => _ProductlistState(category: category, title: title);
}

class _ProductlistState extends State<Productlist> {

  final String title, category;
  _ProductlistState({this.category, this.title});
  List products = [];

  fetchDatabaseProducts() async{
    dynamic resultant = await ProdDatabase().getProductsCategoryList(title);
    if (resultant == null) {
      print('Loading Product , please wait.....');
    } else {
      setState(() {
        products = resultant;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    fetchDatabaseProducts();
    return Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.lightGreen[700],
          elevation: 0.0,
        ),
        body:  ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index){
            return ProductTile(product: products[index]);
          },
        ),
      );
  }
}
