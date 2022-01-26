import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:GreenKey/screens/admin/productsList.dart';
import 'package:GreenKey/screens/admin/editProduct.dart';
import 'package:GreenKey/services/prodDatabase.dart';
import 'package:GreenKey/shared/loading.dart';
import 'package:GreenKey/services/database.dart';
import 'package:GreenKey/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProductForm extends StatefulWidget {
  String subcategory;
  String prodName;

  EditProductForm(this.subcategory, this.prodName);

  @override
  _EditProductFormState createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  final _formKey = GlobalKey<FormState>();

  PickedFile _imageFile;
  File newimg;
  var tempimg;
  dynamic x;
  bool upload = false;

  Future getImage(x) async {
    tempimg = await ImagePicker.pickImage(source: x);
    setState(() {
      newimg = tempimg;
      upload = tempimg == null ? false : true;
    });
  }

  var _category;
  var _subcategory;

  String pid = '';
  String brand = '';
  String name = '';
  num price = 0;
  num mrp = 0;
  num stars = 0;
  num quantity = 0;
  String description = '';
  String image_url = '';
  String prod = '';

  var produ;

  Future fetch(String subcategory, String name) async {
    List products1 = [];
    var product1 = [];
    String p1 = '';
    List resultant =
    await ProdDatabase().getProductsDetails(subcategory, name);
    if (resultant == null) {
      print('Loading Product , please wait.....');
    } else {
      setState(() {
        products1 = resultant;
        for (int i = 0; i < products1.length; i++) {
          p1 = products1[i].pid;
          product1.add(p1);
        }
      });
    }
    return products1;
  }

  dynamic pro = [];

  var produ1 = [];
  var pro1 = [];

  void get(String subcategory, String name) async {
    produ1 = [];
    produ1 = await fetch(subcategory, name);
    pro1 = [];
    pro1 = await produ1;
    print(pro1);
  }

  String id;

  Future uploadPic(BuildContext context) async {
    var randomno = Random(50);
    id = pro1[0].pid;
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Product Pics/$id.jpg');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(newimg);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl =
    await (await uploadTask.onComplete).ref.getDownloadURL();
    image_url = downloadUrl;
    //a = downloadUrl;
    upload = false;
    await ProdDatabase(pid: id).updateProductData(
        id,
        pro1[0].category,
        pro1[0].subcategory,
        pro1[0].brand,
        pro1[0].name,
        pro1[0].mrp,
        pro1[0].quantity,
        pro1[0].description,
        pro1[0].stars,
        pro1[0].price,
        image_url);
    setState(() {
      newimg = null;
      tempimg = null;
      //print(image_url);
    });
  }

  @override


  String pic;

  Widget build(BuildContext context) {
    get(widget.subcategory, widget.prodName);
    // print(pro1[0].category);
    //print(pro1[0].price,);
    if (_category == null)
      _category = pro1[0].category;
    if (pro1.isNotEmpty) {
      pic = pro1[0].image_url;
      id = pro1[0].pid;
      print(_subcategory);
      return Container(
        child: SingleChildScrollView(
          padding:
          EdgeInsets.only(bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom),
          reverse: true,
          child: Container(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  newimg == null
                      ? CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage('$pic'),
                  )
                      : CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.lightGreenAccent.shade200,
                    backgroundImage: FileImage(newimg),
                    //backgroundImage: AssetImage('$newimg'),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  upload == false
                      ? InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                      size: 28.0,
                    ),
                  )
                      : FlatButton(
                      onPressed: () {
                        uploadPic(context);
                      },
                      visualDensity: VisualDensity.compact,
                      splashColor: Colors.blueGrey,
                      child: Icon(
                        Icons.file_upload,
                        size: 28,
                        color: Colors.grey[900],
                      )),
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
                              value:
                              _category == null ? pro1[0].category : _category,
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
                                  prod = '';
                                  _subcategory = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              value: _category == null ? widget.subcategory : categories.values
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
                  TextFormField(
                    initialValue: pro1[0].brand,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[400],
                          )),
                      focusColor: Colors.green[400],
                      labelText: 'Brand',
                      labelStyle: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    validator: (val) =>
                    val.isEmpty
                        ? "Please provide a Brand"
                        : RegExp(r"[a-zA-Z ]").hasMatch(val)
                        ? null
                        : "Please provide a proper Brand",
                    onChanged: (val) {
                      setState(() {
                        brand = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    initialValue: pro1[0].name,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[400],
                          )),
                      focusColor: Colors.green[400],
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    validator: (val) =>
                    val.isEmpty
                        ? "Please provide a name"
                        : RegExp(r"[a-zA-Z0-9 ]").hasMatch(val)
                        ? null
                        : "Please provide a proper name",
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    //          controller: number,
                    initialValue: pro1[0].price.toString(),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[400],
                          )),
                      focusColor: Colors.green[400],
                      labelText: 'Actual Price',
                      labelStyle: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                    val.isEmpty
                        ? "Please provide a Price"
                        : RegExp(r'^[0-9.]*$').hasMatch(val)
                        ? null
                        : "Please provide a proper Price",
                    onChanged: (val) {
                      setState(() {
                        price = double.parse(val);
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    //        controller: number,
                    initialValue: pro1[0].mrp.toString(),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[400],
                          )),
                      focusColor: Colors.green[400],
                      labelText: 'Discount Price',
                      labelStyle: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                    val.isEmpty
                        ? "Please provide a Price"
                        : RegExp(r'^[0-9.]*$').hasMatch(val)
                        ? null
                        : "Please provide a proper Price",
                    onChanged: (val) {
                      setState(() {
                        mrp = double.parse(val);;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    //      controller: number,
                    initialValue: pro1[0].stars.toString(),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[400],
                          )),
                      focusColor: Colors.green[400],
                      labelText: 'Rating',
                      labelStyle: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                    val.isEmpty
                        ? "Please provide a Rating"
                        : RegExp(r'^[0-9.]*$').hasMatch(val)
                        ? double.parse(val) > 10.0
                        ? "Please provide a rating below or equal to 5.0"
                        : null
                        : "Please provide a proper Price",
                    onChanged: (val) {
                      setState(() {
                        stars = double.parse(val);
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    //    controller: number,
                    initialValue: pro1[0].quantity.toString(),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[400],
                          )),
                      focusColor: Colors.green[400],
                      labelText: 'Quantities available',
                      labelStyle: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                    val.isEmpty
                        ? "Please provide a Quantity"
                        : RegExp(r"^[0-9.]*$").hasMatch(val)
                        ? null
                        : "Please provide a proper Quantity",
                    onChanged: (val) {
                      setState(() {
                        quantity = double.parse(val);
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    initialValue: pro1[0].description,
                    maxLines: 10,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green[400]),
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
                    validator: (val) =>
                    val.isEmpty ? "Please provide a Description" : null,
                    onChanged: (val) {
                      setState(() {
                        description = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                      textColor: Colors.green[50],
                      color: Colors.green[800],
                      child: Text(
                        "UPDATE",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate())
                          await ProdDatabase(pid: id).updateProductData(
                              id,
                              _category == null ? pro1[0].category : _category,
                              _subcategory == null
                                  ? pro1[0].subcategory
                                  : _subcategory,
                              brand.isEmpty ? pro1[0].brand : brand,
                              name.isEmpty ? pro1[0].name : name,
                              mrp == 0
                                  ? pro1[0].mrp
                                  : mrp,
                              quantity == 0 ? pro1[0].quantity : quantity,
                              description.isEmpty
                                  ? pro1[0].description
                                  : description,
                              stars == 0 ? pro1[0].stars : stars,
                              price == 0
                                  ? pro1[0].price
                                  : price,
                              image_url.isEmpty
                                  ? pro1[0].image_url
                                  : image_url);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => EditProduct()));
                        Fluttertoast.showToast(
                            msg: "Product has been edited successfully!",
                            timeInSecForIos: 5);
                      }
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    }
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
            "Choose Product photo",
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
