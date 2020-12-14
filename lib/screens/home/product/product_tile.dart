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

    Color _favIconColor = Colors.red;

    return Padding(
        padding: EdgeInsets.only(top: 8.0),
          child: Card(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: ListTile(
                leading: Image(
                  image: NetworkImage('${product.image_url}'),
                  height: 400.0,
                ),
                title: Text("${product.name}\n"),
                subtitle: Text("MRP ₹ ${product.mrp}\nPrice ₹ ${product.price}"),
                trailing:  IconButton(
                  icon: Icon(Icons.favorite_rounded),
                  color: _favIconColor,
                  tooltip: 'Add to favorite',
                  onPressed: () {
                    setState(() {
                      _favIconColor = _favIconColor == Colors.grey ? Colors.red: Colors.grey;
                    });
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsScreen(pid: product.pid,)),
                  );
                },
              ),
        ),
      );
  }
}
