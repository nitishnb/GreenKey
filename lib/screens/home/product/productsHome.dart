import 'package:green_key/models/products.dart';
import 'package:green_key/services/prodDatabase.dart';
import 'package:green_key/screens/home/details.dart';
import 'package:green_key/screens/home/product/productTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:green_key/global.dart';

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
    dynamic resultant = await ProductDatabase().getProductsCategoryList(title);
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
    print('This is $products');
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