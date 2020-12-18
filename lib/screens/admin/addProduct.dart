import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/services/proddatabase.dart';
import 'package:GreenKey/screens/admin/ProductList.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  var _category;
  var _subcategory;

  String pid = '';
  String brand = '';
  String name = '';
  double actualPrice = 0.0;
  double discountPrice = 0.0;
  double rating = 0.0;
  int quantity = 0;
  String description = '';
  String productPic = '';

  showAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("OK", style: TextStyle(color: Colors.green),),
      onPressed:  () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
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

  File newImg;
  var tempImg;
  dynamic x;
  bool upload = false;
  Future getImage(x) async {
    tempImg = await ImagePicker.pickImage(source: x);
    setState((){
      newImg = tempImg;
      upload = tempImg == null ? false : true;
    });
  }

  @override

  final _formKey = GlobalKey<FormState>();


  Future uploadPic(BuildContext context) async{
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('Product Pics/$pid.jpg');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(newImg);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    productPic = downloadUrl;
    upload = false;
    setState(() {
      newImg = null;
      tempImg = null;
      print(productPic);
    });
  }


  void initState() {
    super.initState();
    _category = categories.keys.elementAt(0);
    var id = Uuid();
    pid = id.v4();
  }

  @override
  Widget build(BuildContext context) {

    print(pid);

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
              child: Column(
                  children: [
                    SizedBox(height: 15.0,),
                    Image(
                      image: NetworkImage('https://cdn3.iconfinder.com/data/icons/ecommerce-flat-style-2/512/e_-_Commerce_-_Flat_Style_2-05-512.png'),
                      width: 100.0,
                      height: 100.0,
                      color: Colors.green[400],
                    ),
                    SizedBox(height: 5.0,),
                    Text(
                      "ADD PRODUCT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.green[400],
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Text(
                        "$pid"
                    ),
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Select a category",
                            labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
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
                                  return DropdownMenuItem<String> (
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                      //                    validator: (_category) => _category.isEmpty ? "Please select a category" : null,
                    ),
                    SizedBox(height: 15.0,),
                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Select a subcategory",
                            labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
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
                                value: categories.values.elementAt(index[_category]).contains(_subcategory) ? _subcategory : categories.values.elementAt(index[_category]).elementAt(0),
                                items: categories.values.elementAt(index[_category]).map((String subcategory) {
                                  return DropdownMenuItem<String> (
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
                    SizedBox(height: 15.0,),
                    TextFormField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green[400],
                            )
                        ),
                        focusColor: Colors.green[400],
                        labelText: 'Brand',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? "Please provide a Brand" : RegExp(r"[a-zA-Z ]").hasMatch(val) ? null : "Please provide a proper Brand",
                      onChanged: (val) {
                        setState(() {
                          brand = val;
                        });
                      },
                    ),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green[400],
                            )
                        ),
                        focusColor: Colors.green[400],
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      validator: (val) => val.isEmpty ? "Please provide a name" : RegExp(r"[a-zA-Z0-9 ]").hasMatch(val) ? null : "Please provide a proper name",
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                    ),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      //          controller: number,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green[400],
                            )
                        ),
                        focusColor: Colors.green[400],
                        labelText: 'Actual Price',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty ? "Please provide a Price" : RegExp(r'^[0-9.]*$').hasMatch(val) ? null : "Please provide a proper Price",
                      onChanged: (val) {
                        setState(() {
                          actualPrice = double.parse(val);
                        });
                      },
                    ),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      //        controller: number,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green[400],
                            )
                        ),
                        focusColor: Colors.green[400],
                        labelText: 'Discount Price',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty ? "Please provide a Price" : RegExp(r'^[0-9.]*$').hasMatch(val) ? null : "Please provide a proper Price",
                      onChanged: (val) {
                        setState(() {
                          discountPrice = double.parse(val);
                        });
                      },
                    ),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      //      controller: number,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green[400],
                            )
                        ),
                        focusColor: Colors.green[400],
                        labelText: 'Rating',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty ? "Please provide a Rating" : RegExp(r'^[0-9.]*$').hasMatch(val) ? double.parse(val) > 10.0 ? "Please provide a rating below or equal to 5.0" : null : "Please provide a proper Price",
                      onChanged: (val) {
                        setState(() {
                          rating = double.parse(val);
                        });
                      },
                    ),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      //    controller: number,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green[400],
                            )
                        ),
                        focusColor: Colors.green[400],
                        labelText: 'Quantities available',
                        labelStyle: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) => val.isEmpty ? "Please provide a Quantity" : RegExp(r"^[0-9]*$").hasMatch(val) ? null : "Please provide a proper Quantity",
                      onChanged: (val) {
                        setState(() {
                          quantity = int.parse(val);
                        });
                      },
                    ),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      maxLines: 10,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green[400]
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        focusColor: Colors.green[400],
                        labelText: 'Description',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (val) => val.isEmpty ? "Please provide a Description" : null,
                      onChanged: (val) {
                        setState(() {
                          description = val;
                        });
                      },
                    ),
                    SizedBox(height: 15.0,),
                    productPic == '' ?
                    upload == false ?
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.camera_enhance),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    "Select Product",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[600],
                                    )
                                ),
                              ],
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                          ),
                        ]
                    )
                        :
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.file_upload),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    "Upload",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[600],
                                    )
                                ),
                              ],
                            ),
                            onPressed: () {
                              uploadPic(context);
                            },
                          ),
                        ]
                    )
                        :
                    Text(
                      'Product Image was successfully uploaded!',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    RaisedButton(
                        textColor: Colors.green[50],
                        color: Colors.green[800],
                        child: Text(
                          "ADD PRODUCT",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0
                          ),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate() && productPic != '') {
                            try {
                              await ProdDatabase().updateProductData(
                                  pid,
                                  _category,
                                  _subcategory,
                                  brand,
                                  name,
                                  discountPrice,
                                  quantity,
                                  description,
                                  rating,
                                  actualPrice,
                                  productPic
                              );
                              showAlertDialog(context);
                            }
                            catch (e) {
                              showAlertDialogBox(context);
                            }
                          }
                        }
                    ),
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: 280,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose a Product photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                getImage(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 100, 100);
  }
  bool shouldReclip(oldClipper) {
    return false;
  }
}