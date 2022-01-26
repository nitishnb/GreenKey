import 'package:flutter/material.dart';
import 'package:GreenKey/services/prodDatabase.dart';

class ViewProducts extends StatefulWidget {
  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  List products = [];
  List ids = [];

  fetchDatabaseProducts() async {
    dynamic resultant = await ProdDatabase().getProductsList();
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View products",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[800],
        centerTitle: true,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              //alignment: Alignment.topLeft,
              width: 1000,
              height: size.height,
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.0),
                          color: Colors.white,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            //color: Colors.transparent,
                          ),
                          //child: Text("Test[$i]",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              SizedBox(
                                width: 500.0,
                                child: Card(
                                  color: Colors.green[50],
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              '${products[i].image_url}',
                                              //fit: BoxFit.cover
                                            ),
                                            radius: 50,
                                          ),
                                        ),
                                        SizedBox(height: 20.0,),
                                        Column(
                                          children: [
                                            Row(
                                              //       crossAxisAlignment: CrossAxisAlignment.start,
                                              //       crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("CATEGORY: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text("${products[i].category}",
                                                  style: TextStyle(
                                                    //fontWeight: FontWeight.bold,
                                                      fontSize: 14.0
                                                  ),
                                                  //overflow: TextOverflow.ellipsis,
                                                  maxLines: 4,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.0,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("SUBCATEGORY: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text("${products[i].subcategory}",
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                  fontSize: 14.0
                                              ),
                                              //overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.0,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("BRAND: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text("${products[i].brand}",
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                  fontSize: 14.0
                                              ),
                                              //overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.0,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("PRODUCT NAME: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text("${products[i].name}",
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                  fontSize: 14.0
                                              ),
                                              //overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.0,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("ACTUAL PRICE: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text("₹${products[i].mrp}",
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                  fontSize: 14.0
                                              ),
                                              //overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.0,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("DISCOUNT PRICE: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text("₹${products[i].price}",
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                  fontSize: 14.0
                                              ),
                                              //overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.0,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("QUANTITY: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text("${products[i].quantity}",
                                              style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                  fontSize: 14.0
                                              ),
                                              //overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.0,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("DESCRIPTION: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text("${products[i].description}",
                                                style: TextStyle(
                                                  //fontWeight: FontWeight.bold,
                                                    fontSize: 14.0
                                                ),
                                                //overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}