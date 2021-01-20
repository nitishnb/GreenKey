
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/screens/home/details.dart';
import 'package:green_key/screens/home/home.dart';
import 'package:green_key/services/database.dart';
import 'package:green_key/services/proDatabase.dart';

class Category extends StatefulWidget {
  final category;
  Category({
    this.category,
  });

  @override
  _CategoryState createState() => _CategoryState(category: category);
}

class _CategoryState extends State<Category> {
  final category;
  _CategoryState({
    this.category,
  });
  List products = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseProducts();
  }
  fetchDatabaseProducts() async{
    dynamic resultant = await ProductDatabase().getProductsCategoryList(category);

    if (resultant == null) {
      print('Loading Product , please wait.....');
    } else {
      setState(() {
        products = resultant;
      });
    }
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 36,
        elevation: 60,
        title: Text(
          '${this.category}',
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w400),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back,size: 22,color: Colors.white,),
        highlightColor: Colors.white,
        onPressed: () {
         Navigator.pop(context);
        },
       ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          height: size.height,
          child:
          GridView.builder(
              itemCount: products.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int i){
                return Single_prod(
                  name: products[i].name,
                  productPic: products[i].productPic,
                  actualPrice: products[i].actualPrice,
                  discountPrice: products[i].discountPrice,
                  description: products[i].description,
                  brand: products[i].brand,
                  rating: products[i].rating,
                );
              }
          ),
        ),
      ),
    );
  }
}

class Single_prod extends StatelessWidget {
  final name;
  final productPic;
  final actualPrice;
  final discountPrice;
  final description;
  final brand;
  final rating;
  Single_prod({
    this.name,
    this.productPic,
    this.actualPrice,
    this.discountPrice,
    this.description,
    this.brand,
    this.rating,
  });
  @override


  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Hero(
          tag: name,
          child: Material(
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductDetails(
                      detail_name: name,detail_productPic: productPic,detail_actualPrice: actualPrice,detail_discountPrice: discountPrice,detail_description: description,detail_brand: brand,detail_rating: rating,
                  )),
                );
              },
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: Column(
                    children: <Widget>[
                      //Text('$name\n', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Align(alignment: Alignment.centerLeft,child: Text('$name',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),)),
                      Align(alignment: Alignment.centerLeft,child: Text('₹ $discountPrice',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.grey[900]),)),
                      Align(alignment: Alignment.centerLeft,child: Text('₹ $actualPrice',textAlign: TextAlign.left,style: TextStyle(fontSize: 14,color: Colors.red,decoration: TextDecoration.lineThrough),)),
                    ],
                  ),
                ),
                child: Image.network(productPic,fit: BoxFit.cover,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
