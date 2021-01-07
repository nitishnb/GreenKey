import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_key/models/user.dart';
import 'package:green_key/services/database.dart';
import 'package:provider/provider.dart';
import 'package:green_key/screens/home/cart.dart';

class ProductDetails extends StatefulWidget {
  final detail_pid;
  final detail_name;
  final detail_productPic;
  final detail_actualPrice;
  final detail_discountPrice;
  final detail_description;
  final detail_brand;
  final detail_rating;
  ProductDetails({
  this.detail_pid,
  this.detail_name,
  this.detail_productPic,
  this.detail_actualPrice,
  this.detail_discountPrice,
    this.detail_description,
    this.detail_brand,
    this.detail_rating,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List old_cart = [];
  List new_cart = [];
  @override

  fetchDatabaseProducts(String uid) async{
    dynamic resultant = await DatabaseService().getAccountList(uid);

    if (resultant == null) {
      print('Loading Product , please wait.....');
    } else {
      setState(() {
        old_cart = resultant.toList();
      });
    }
  }

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    fetchDatabaseProducts(user.uid);

    var fav = Icons.favorite;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.grey[900],),onPressed: (){Navigator.pop(context);}),
        backgroundColor: Colors.lightGreenAccent.shade200,
        elevation: 14,
        title: Text('${widget.detail_brand}',style: TextStyle(color: Colors.grey[900],fontWeight: FontWeight.bold),),
        actions: <Widget>[
          new IconButton(icon: Icon(fav,color: Colors.red,),
              onPressed: (){setState(() {
                fav = fav==Icons.favorite_border? Icons.favorite : Icons.favorite_border;
              });},),
          new IconButton(icon: Icon(Icons.shopping_cart,color: Colors.grey[900],),
            onPressed: (){
                context;
                MaterialPageRoute(builder: (context) => CartScreen(uid: user.uid,));

            }),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          Container(
            height: size.height/2.6,
            child: GridTile(
              child:Container(
                color: Colors.white,
                child: Image.network(widget.detail_productPic),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(widget.detail_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0,color: Colors.grey[900]),),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Text(' ₹ ${widget.detail_discountPrice}',style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough,fontSize: 16.0,color: Colors.red),),
                      ),
                      Expanded(
                        child: new Text('   ₹.${widget.detail_actualPrice}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.grey[900]),),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              RatingBarIndicator(
                rating:  double.tryParse(widget.detail_rating),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
                itemCount: 5,
                itemSize: 25.0,
                unratedColor: Colors.grey,
                direction: Axis.horizontal,
              ),
              Expanded(
                  child: MaterialButton(
                      onPressed: (){
                        showDialog(context: context,
                          builder:(context){
                          return new AlertDialog(
                            title: Text("Colors"),
                            content: Text("No other colors available"),
                            actions: <Widget>[
                              new MaterialButton(onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("OK"),)
                            ],
                          );
                            }
                        );
                      },
                      color: Colors.white,
                    textColor: Colors.grey[900],
                    elevation: 2,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: new Text('color')),
                        Expanded(child: new Icon(Icons.arrow_drop_down),)
                      ],
                    ),
                  )),
              Expanded(
                  child: MaterialButton(
                    onPressed: (){
                      showDialog(context: context,
                          builder:(context){
                            return new AlertDialog(
                              title: Text("Quantity"),
                              content: Text("Only one available"),
                              actions: <Widget>[
                                new MaterialButton(onPressed: (){
                                  Navigator.pop(context);
                                },
                                  child: Text("OK"),)
                              ],
                            );
                          }
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.grey[900],
                    elevation: 2,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: new Text('Qty')),
                        Expanded(child: new Icon(Icons.arrow_drop_down),)
                      ],
                    ),
                  ))
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.only(top: 15,bottom: 17),
                    onPressed: (){},
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 2,
                      child: new Text('Place Order',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                  )),
             (old_cart.contains(widget.detail_pid)) ?
             new IconButton(icon: Icon(Icons.remove_shopping_cart,color: Colors.red,size: 28,), onPressed: ()async{
               setState(() {
                 old_cart.remove(widget.detail_pid);
                 new_cart = old_cart.toList();
               });
               await DatabaseService().addtoCart(user.uid, new_cart);
               print('Removed Successfully');
               Fluttertoast.showToast(msg: 'Removed Successfully From Cart', timeInSecForIos: 4);
             })
                   :
                               new IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.red,size: 28,), onPressed: ()async{
                                setState(() {
                                new_cart = old_cart.toList();
                                new_cart.add(widget.detail_pid);
                                });
                                await DatabaseService().addtoCart(user.uid, new_cart);
                                print('Added Successfully');
                                Fluttertoast.showToast(msg: 'Added Successfully to cart', timeInSecForIos: 4);

                                },
                   ),

            ],
          ),
          Divider(),
          Container(
            child: new ListTile(
              title: Text('Details :',style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text('${widget.detail_description}'),
            ),
          ),
        ],

      )
    );
  }
}
