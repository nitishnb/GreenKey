import 'package:flutter/material.dart';
import 'package:GreenKey/screens/admin/addProduct.dart';
import 'package:GreenKey/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:GreenKey/models/user.dart';
import 'package:GreenKey/services/database.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    dynamic _bottomselect = AddProduct();
    return Scaffold(
      body: Stack(
          children: [
            Positioned(
              left: 50,
              top: 40,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Green", style: TextStyle(fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[600],),),
                ],
              ),
            ),

            Positioned(
              left: 158,
              top: 40,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Key", style: TextStyle(fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900]),),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(height: 150.0,),
                Card(
                  color: Colors.green[100],
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: InkWell(
                    onTap: () {
                      _bottomselect = AddProduct();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.add,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        "Add a Product",
                        style: TextStyle(
                            fontSize: 16.0, fontFamily: 'Neucha'),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.green[100],
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: InkWell(
                    onTap: () {
                      print("Hi");
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.view_list,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        "View Products",
                        style: TextStyle(
                            fontSize: 16.0, fontFamily: 'Neucha'),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.green[100],
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: InkWell(
                    onTap: () {
                      print("Hi");
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.edit,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        "Edit a Product",
                        style: TextStyle(
                            fontSize: 16.0, fontFamily: 'Neucha'),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.green[100],
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: InkWell(
                    onTap: () {
                      print("Hi");
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        "Delete a Product",
                        style: TextStyle(
                            fontSize: 16.0, fontFamily: 'Neucha'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
              ],
            ),
          ]
      ),
    );
  }
}