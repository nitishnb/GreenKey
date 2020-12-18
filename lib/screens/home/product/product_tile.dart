import 'package:GreenKey/global.dart';
import 'package:GreenKey/models/products.dart';
import 'package:GreenKey/screens/home/details.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatefulWidget {

  final Prod product;
  ProductTile({this.product});

  @override
  _ProductTileState createState() => _ProductTileState(product: product);
}

class _ProductTileState extends State<ProductTile> {

  final Prod product;
  _ProductTileState({this.product});

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: Image.network(
                  "${product.image_url}",
                  height: 120.0,
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${product.name}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .title,
                  ),
                  SizedBox(height: 20.0,),
                  Text("MRP : ₹ ${product.mrp}", style: TextStyle(color: Colors.red[900], fontStyle: FontStyle.italic, decoration: TextDecoration.lineThrough),),
                  Text(
                    "Price : ₹ ${product.price}",
                    style: TextStyle(
                        color: Colors.red[800], fontStyle: FontStyle.italic, fontSize: 20.0
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsScreen(pid: product.pid,)),
          );
        },
      ),
    );
  }
}
