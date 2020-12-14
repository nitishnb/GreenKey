import 'package:GreenKey/models/products.dart';
import 'package:GreenKey/screens/home/product/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdList extends StatefulWidget {
  @override
  _ProdListState createState() => _ProdListState();
}

class _ProdListState extends State<ProdList> {
  @override
  Widget build(BuildContext context) {

    final products = Provider.of<List<Prod>>(context) ?? [];
    print("Products length is ${products.length}");
    print(products);
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){
          return ProductTile(product: products[index]);
        },
    );
  }
}

