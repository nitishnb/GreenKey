import 'package:GreenKey/screens/admin/deleteProduct.dart';
import 'package:GreenKey/screens/admin/editProduct.dart';
import 'package:GreenKey/screens/admin/viewProducts.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/screens/admin/addProduct.dart';
import 'package:GreenKey/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:GreenKey/models/user.dart';
import 'package:GreenKey/services/database.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.green[800],
          title: Text(
            "GreenKey ADMIN",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25,
                color: Colors.white
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 30.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            /*decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX31129765.jpg'),
              fit: BoxFit.cover
            ),
          ),*/
            child: Column(
              children: [
                SizedBox(height: 150.0,),
                Card(
                  color: Colors.green[100],
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 25.0),
                  child: InkWell(
                    onTap: () {
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProducts()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProduct()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteProduct()));
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
          ),
        )
    );
  }
}