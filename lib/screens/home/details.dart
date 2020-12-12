import 'package:GreenKey/models/products.dart';
import 'package:GreenKey/services/database.dart';
import 'package:GreenKey/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/global.dart';
import 'package:GreenKey/ui/widgets/carouselproductslist.dart';
import 'package:GreenKey/ui/widgets/sizeselector.dart';
import 'package:share/share.dart';

class DetailsScreen extends StatefulWidget {

  final int id;

  const DetailsScreen({Key key, this.id}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState(id: id);
}

class _DetailsScreenState extends State<DetailsScreen> {

  String text = 'https://www.linkedin.com/in/nitish-n-banakar-7772a5199/';
  String subject = 'follow me';
  final int id;
  _DetailsScreenState({this.id});

  @override
  Widget build(BuildContext context) {
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
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      CarouselProductsList(
                        productsList: products[id].images,
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
                                      backgroundColor: Colors.black,
                                      padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      label: Text(
                                        'Seeds',
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
                            Text(
                              products[id].title,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text("MRP ₹ 500"),
                            Spacer(),
                            Text(
                              "Price ${products[id].price}",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(
                                color: Colors.black,
                              ),
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
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                """We are ranked amongst the renowned organizations that are engaged in providing the best quality range of Hariyali Annual Ryegrass.
Features:
*) Hariyali is high nutritional multi cut annual Rye grass
*) Hariyali is highly succulent and more palatable grass
*) Rye grass feeding improves animal health and increases milk production
*) Best part in Rye grass feeding is increases SNF (solids not FAT) is advantage for farmer
*) Hariyali is excellent for hill region as well as plains""",
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
                                  color: Colors.black,
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
                                color: Colors.black,
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
                                color: Colors.black,
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
  }
}
