import 'package:GreenKey/screens/home/details.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/global.dart';

class Productlist extends StatefulWidget {
  final String title, category;
  Productlist({this.category, this.title});

  @override
  _ProductlistState createState() => _ProductlistState(category: category,title: title);
}

class _ProductlistState extends State<Productlist> {
  int _selectedCat = 0;
  final String title, category;
  _ProductlistState({this.category, this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,size: 30,color: Colors.grey[700],),
          highlightColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },),
        title: Text(category),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5.0,),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(fontWeight: FontWeight.normal, fontSize: 25.0, color: Colors.black),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  return FlatButton(
                      child: Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            child: Image.network(
                              "${products[i].mainImage}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${products[i].title}",
                                style: Theme.of(context).textTheme.title,
                              ),
                              Text(
                                "${products[i].price}",
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailsScreen(id: 1)),
                      );
                    },
                  );
                },
              ),
            ),
    ]
    )
      )
    );
  }
}
