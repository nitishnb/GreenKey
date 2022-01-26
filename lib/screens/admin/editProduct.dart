import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:GreenKey/screens/admin/editProductForm.dart';
import 'package:GreenKey/services/proddatabase.dart';
import 'package:GreenKey/screens/admin/productsList.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  var _category;
  var _subcategory;

  String pid = '';
  String prod = '';

  void _editProductPanel(String subcategory, String name) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: EditProductForm(subcategory, name),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _category = categories.keys.elementAt(0);
  }

  final _formKey = GlobalKey<FormState>();

  var produ;


  Future fetchDatabaseProducts(String subcategory) async {

    List products = [];
    List<String> product = [];
    String p = '';
    List resultant = await ProdDatabase().getProductsCategoryList(subcategory);
    if (resultant == null) {
      print('Loading Product , please wait.....');
    } else {
      setState(() {
        products = resultant;
        for(int i = 0; i < products.length; i++) {
          p = products[i].name;
          product.add(p);
        }
      });
    }
    return product;
  }



  Future fetch(String subcategory, String name) async {

    List products1 = [];
    List<String> product1 = [];
    String p1 = '';
    List resultant = await ProdDatabase().getProductsDetails(subcategory, name);
    if (resultant == null) {
      print('Loading Product , please wait.....');
    } else {
      setState(() {
        products1 = resultant;
        for(int i = 0; i < products1.length; i++) {
          p1 = products1[i].pid;
          product1.add(p1);
        }
      });
    }
    return products1;
  }

  dynamic pro = [];

  void get(String subcategory) async {
    produ = [];
    produ = await fetchDatabaseProducts(subcategory);
    pro = [];
    pro = await produ;
  }

  var produ1 = [];
  var pro1 = [];
  void getc(String subcategory, String name) async {
    produ1 = [];
    produ1 = await fetch(subcategory, name);
    pro1 = [];
    pro1 = await produ1;
  }

  Widget build(BuildContext context) {

    if (_subcategory != null)
      get(_subcategory);

    //print(prod);
    //print(_subcategory);

    getc(_subcategory, prod);
    //print(pro1[0].pid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit product",
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
                      'https://cdn2.iconfinder.com/data/icons/e-commerce-14/57/basket_delete-512.png'),
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
                                prod = '';
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
                pro.length == 0 ?
                Text(
                  "No products available under this subcategory",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold
                  ),
                )
                    :
                Column(
                  children: [
                    FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Select a product",
                            labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                            errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                            hintText: 'Please select expense',
                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                          ),
                          //                         isEmpty: prod == pro[0],
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isDense: true,
                                isExpanded: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    prod = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                value: prod.isEmpty ? pro[0] : prod,
                                items: pro.map<DropdownMenuItem<String>>((String p) {
                                  return DropdownMenuItem(
                                    value: p,
                                    child: Text(p),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15.0,),
                    prod.isEmpty ?
                    Text('')
                        :
                    RaisedButton(
                      textColor: Colors.green[50],
                      color: Colors.green[800],
                      child: Text(
                        "EDIT PRODUCT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0
                        ),
                      ),
                      onPressed: () {
                        _editProductPanel(_subcategory, prod);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}