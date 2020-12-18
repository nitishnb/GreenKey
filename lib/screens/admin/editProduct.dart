import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/services/proDatabase.dart';
import 'package:green_key/models/prod.dart';
import 'package:green_key/screens/admin/ProductList.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  var _category;
  var _subcategory;

  String pid = '';
  String brand = '';
  String name = '';
  String actualPrice = '';
  String discountPrice = '';
  String rating = '';
  String quantity = '';
  String description = '';
  String productPic = '';

  showAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("OK", style: TextStyle(color: Colors.green),),
      onPressed:  () {

      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Product is added!"),
      actions: [
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogBox(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("OK", style: TextStyle(color: Colors.green),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Failure"),
      content: Text("Product cannot be added! Check the fields again"),
      actions: [
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future get() async {
    var firestore = Firestore.instance;
    QuerySnapshot q = await firestore.collection('product').getDocuments();
    print(q.documents);
  }

  @override


  void initState() {
    super.initState();
    _category = categories.keys.elementAt(0);
  }

  final _formKey = GlobalKey<FormState>();

  

  Widget build(BuildContext context) {


     get();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GreenKey ADMIN",
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
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(children: [
                SizedBox(
                  height: 15.0,
                ),
                Image(
                  image: NetworkImage(
                      'https://cdn3.iconfinder.com/data/icons/ecommerce-flat-style-2/512/e_-_Commerce_-_Flat_Style_2-05-512.png'),
                  width: 100.0,
                  height: 100.0,
                  color: Colors.green[400],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "EDIT PRODUCT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.green[400],
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text("$pid"),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Select a category",
                        labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Please select expense',
                        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                      ),
                      isEmpty: _category == '',
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _category = newValue;
                                state.didChange(newValue);
                              });
                            },
                            value: _category,
                            items: categories.keys.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Select a subcategory",
                        labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Please select expense',
                        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                      ),
                      isEmpty: _category == '',
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isDense: true,
                            isExpanded: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _subcategory = newValue;
                                state.didChange(newValue);
                              });
                            },
                            value: categories.values
                                    .elementAt(index[_category])
                                    .contains(_subcategory)
                                ? _subcategory
                                : categories.values
                                    .elementAt(index[_category])
                                    .elementAt(0),
                            items: categories.values
                                .elementAt(index[_category])
                                .map((String subcategory) {
                              return DropdownMenuItem<String>(
                                value: subcategory,
                                child: Text(subcategory),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: 15.0,
                ),
                /*FutureBuilder(
                  future: get(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Text("K");
                     else
                       return ListView.builder(
                         itemCount: snapshot.data.length,
                           itemBuilder: (_, name) {
                             return ListTile(
                               title: Text(snapshot.data[name]),
                             );
                           }
                       );
                  },
                )*/
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
