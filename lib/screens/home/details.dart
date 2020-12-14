import 'dart:ui';

import 'package:GreenKey/models/products.dart';
import 'package:GreenKey/services/database.dart';
import 'package:GreenKey/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/global.dart';
import 'package:GreenKey/ui/widgets/carouselproductslist.dart';
import 'package:GreenKey/ui/widgets/sizeselector.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share/share.dart';
import 'package:GreenKey/services/proddatabase.dart';

class DetailsScreen extends StatefulWidget {

  final String pid;

  const DetailsScreen({Key key, this.pid}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState(pid: pid);
}

class _DetailsScreenState extends State<DetailsScreen> {

  String text = 'https://www.linkedin.com/in/nitish-n-banakar-7772a5199/';
  String subject = 'follow me';
  final String pid;
  _DetailsScreenState({this.pid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Prod>(
        stream: ProdDatabase(pid: pid).prodData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
          Prod product = snapshot.data;
          return Scaffold(
              backgroundColor: bgColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.green[800],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      CarouselProductsList(
                        productsList: [product.image_url],
                        type: CarouselTypes.details,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Spacer(),
                            Container(
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 1,
                                itemBuilder: (ctx, i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Chip(
                                      backgroundColor: Colors.green[800],
                                      padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      label: Text(
                                        product.category,
                                        style:
                                        Theme
                                            .of(context)
                                            .textTheme
                                            .button
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Spacer(),
                            Text(product.brand),
                            Text(
                              product.name,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            Text("MRP : ₹ ${product.mrp}", style: TextStyle(color: Colors.red[900], fontStyle: FontStyle.italic),),
                            Text(
                              "Price : ₹ ${product.price}",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(
                                color: Colors.red[800], fontStyle: FontStyle.italic
                              ),
                            ),
                            Spacer(),
                            Text("Rating : ${product.stars}", style: TextStyle(fontWeight: FontWeight.w900),),
                            RatingBarIndicator(
                              rating: product.stars,
                              itemBuilder: (context, index) => Icon(
                                Icons.agriculture_rounded,
                                color: Colors.red,
                              ),
                              itemCount: 5,
                              itemSize: 25.0,
                              unratedColor: Colors.red.withAlpha(50),
                              direction: Axis.horizontal,
                            ),
                            Spacer(),
                            Text(
                              "Description:",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                product.description,
                                softWrap: true,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                height: double.infinity,
                                child: RaisedButton(
                                  child: Text(
                                    "BUY NOW",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {},
                                  color: Colors.green[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.green[800],
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.green[800],
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final RenderBox box = context.findRenderObject();
                                  Share.share(text,
                                      subject: subject,
                                      sharePositionOrigin:
                                      box.localToGlobal(Offset.zero) &
                                      box.size);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
    }
    );
  }
}
