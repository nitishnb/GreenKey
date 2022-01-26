import 'dart:math';
import 'package:GreenKey/screens/home/product/productshome.dart';
import 'package:GreenKey/screens/home/profile.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/global.dart';

class PHome extends StatefulWidget {
  @override
  _PHomeState createState() => _PHomeState();
}

class _PHomeState extends State<PHome> {
  int _selectedCat = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 35.0,),
          Center(
            child: Text(
              "Categories",
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(color: Colors.black),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  margin: const EdgeInsets.only(right: 15),
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCat = i;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 25.0),
                          // padding: const EdgeInsets.symmetric(vertical: 45.0),
                          width: 50,
                          constraints: BoxConstraints(minHeight: 101),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: _selectedCat == i ? Border.all() : Border(),
                            color: _selectedCat == i
                                ? Colors.transparent
                                : Colors.green[900],
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          // child: Transform.rotate(
                          //   angle: -pi / 2,
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: Text(
                              "${categories[i].title}",
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(
                                  color: _selectedCat == i
                                      ? Colors.green[900]
                                      : Colors.white,
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: ListView.builder(
                    itemCount: categories[_selectedCat].subCat.length,
                    itemBuilder: (ctx, i) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: Colors.lightGreenAccent.shade100,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text(
                                    "${categories[_selectedCat].subCat[i].title}"
                                ),
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Productlist(category:"${categories[_selectedCat].title}", title: "${categories[_selectedCat].subCat[i].title}")),
                                  );
                                },
                              ),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}