import'package:flutter/material.dart';
import 'package:green_key/services/proDatabase.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final number = TextEditingController();
  var _category;
  final List<String> _categories = ["Organic Farming", "Remedies", "Seeds", "Equipments", "Fertilisers", "Irrigation", "Others"];
  String brand = '';
  String name = '';
  String actualPrice = '';
  String discountPrice = '';
  String rating = '';
  String quantity = '';
  String description = '';

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

  @override

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _category = _categories[0];
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "GreenKey ADMIN",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green[400],
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
                                items: _categories.map((String PRO) {
                                  return DropdownMenuItem<String> (
                                    value: PRO,
                                   child: Text(PRO),
                                  );
                                }).toList(),
                                //value: _category == ' ' ? _categories[0] : _category,
                              ),
                            ),
                          ),
                        );
                      },
  //                    validator: (_category) => _category.isEmpty ? "Please select a category" : null,
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
                          actualPrice = val;
                        });
                      },
                    ),
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
                          discountPrice = val;
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
                          rating = val;
                        });
                      },
                    ),
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
                      validator: (val) => val.isEmpty ? "Please provide a Quantity" : RegExp(r"^[0-9.]*$").hasMatch(val) ? null : "Please provide a proper Quantity",
                      onChanged: (val) {
                        setState(() {
                          quantity = val;
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
                          if(_formKey.currentState.validate()) {
                            try {
                              await ProductDatabase().updateProductData(
                                  _category,
                                  brand,
                                  name,
                                  discountPrice,
                                  quantity,
                                  description,
                                  rating,
                                  actualPrice);
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
}
