

import 'package:GreenKey/models/products.dart';
import 'package:GreenKey/screens/home/details.dart';
import 'package:GreenKey/services/proddatabase.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:GreenKey/services/database.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:GreenKey/shared/loading.dart';

class CartScreen extends StatefulWidget {
  String uid;
  CartScreen({this.uid});
  @override
  _CartScreenState createState() => _CartScreenState(uid: uid);
}

class _CartScreenState extends State<CartScreen> {

  String uid;
  _CartScreenState({this.uid});

  List<Prod> cartproducts = [];
  Prod eachprod;

  dynamic products;
  double total_amount = 0;

  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    fetchDatabaseProducts();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    print(products);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_ZRXnWNrO4XkuSY',
      'amount': 28200,
      'name': 'Nitish N Banakar',
      'description': 'Payment',
      'prefill': {'contact': '9380692117', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }



  fetchDatabaseProducts() async{
    dynamic resultant = await DatabaseService().getAccountList(uid);
    if (resultant == null) {
      print('Loading Product , please wait.....');
    } else {
      setState(() {
        products = resultant;
      });
      for(int i=0;i<products.length;i++){
        dynamic resultant = await ProdDatabase().getProductList(products[i]);
        if (resultant == null) {
          print('Loading Product , please wait.....');
        } else {
          setState(() {
            eachprod = resultant;
          });
          cartproducts.add(eachprod);
        }
      }
    }
  }


  fetchDatabaseProduct(String id) async{
    dynamic resultant = await ProdDatabase().getProductList(id);
    if (resultant == null) {
      print('Loading Product , please wait.....');
    } else {
      setState(() {
        eachprod = resultant;
      });
      cartproducts.add(eachprod);
    }
    }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: products == null ?
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25.0,),
          Text(
            "My Bag",
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 255.0,),
          Center(child: Text('No items in your Bag', style: TextStyle(fontSize: 30.0),)),
        ]
      ) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25.0,),
          Text(
            "My Bag",
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white,
                                  ),
                                  child: Image.network(
                                    "${cartproducts[i].image_url}",
                                    height: 120.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${cartproducts[i].name}",
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .title,
                                    ),
                                    Text(
                                      "${cartproducts[i].price}",
                                    ),
                                    SizedBox(height: 15),
                                    MyCounter(),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailsScreen(pid: cartproducts[i].pid,)),
                            );
                          },
                        ),
                );
              },
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("TOTAL", style: Theme.of(context).textTheme.subtitle),
                    Text("${total_amount}",
                        style: Theme.of(context).textTheme.headline),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    child: Text(
                      "CHECKOUT",
                      style: Theme.of(context).textTheme.button.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      openCheckout();
                    },
                    color: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MyCounter extends StatefulWidget {
  const MyCounter({
    Key key,
  }) : super(key: key);

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _currentAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          onTap: () {
            setState(() {
              if(_currentAmount > 0)
                _currentAmount -= 1;
            });
          },
        ),
        SizedBox(width: 15),
        Text(
          "$_currentAmount",
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(width: 15),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onTap: () {
            setState(() {
              _currentAmount += 1;
            });
          },
        ),
      ],
    );
  }
}