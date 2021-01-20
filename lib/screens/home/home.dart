
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_key/global.dart';

import 'package:green_key/screens/home/cart.dart';
import 'package:green_key/screens/home/sidebar/sidebarlayout.dart';
import 'package:green_key/screens/authenticate/login.dart';
import 'package:green_key/services/auth.dart';
import 'package:green_key/services/database.dart';
import 'package:green_key/services/proDatabase.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'package:green_key/screens/home/green_list.dart';
import 'package:green_key/models/green.dart';
import 'package:green_key/models/user.dart';
import 'package:green_key/screens/home/profileform.dart';
import 'package:green_key/screens/home/profile.dart';
import 'package:green_key/screens/home/green_tile.dart';
import 'package:green_key/screens/admin/home.dart';
import 'package:green_key/screens/home/details.dart';
import 'package:green_key/screens/home/categories.dart';

void main() {
  runApp(
      MaterialApp(
        home: Home(),
      )
  );
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  StreamProvider<List<Green>>.value(
      value: DatabaseService().green,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: Homelayout(),
        ),
        endDrawer:SidebarLayout(),
      ),
    );
  }
}

class Homelayout extends StatefulWidget   {

  @override
  _HomelayoutState createState() => _HomelayoutState();
}

class _HomelayoutState  extends State<Homelayout> {
  final AuthService _auth = AuthService();

  GlobalKey<ScaffoldState> _stackKey = GlobalKey<ScaffoldState>();
  int _currentIndex =0, _selectedindex = -1;
  String _currentProfilepic ="";
  dynamic _bottomSelect = MyApp2();
  bool _toggle = true;
  final green_clr = Colors.white70;
  var email;
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      color: Colors.green,
      child: Text("Cancel",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed:  () {
        setState(() {
          _selectedindex = -1;
        });
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      color: Colors.redAccent,
      child: Text("Logout",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onPressed:  () async {
        await _auth.signOut();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("LOGOUT"),
      elevation: 3.00,
      content: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },

    );
  }



  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      key: _stackKey,
      body: Stack(
        children:<Widget>[
          Positioned(
            top: 126,
            left: 14,
            right: 12,
            bottom: 20,
            child: _bottomSelect,
          ),
          Positioned(
            width: 70,
            top: 0,
            bottom: 0,
            right:  -40,
            child: ClipPath(
              clipper: SidebarClipper(180,290),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors:[
                        Colors.white,
                        Colors.white30,
                        Colors.white30,
                      ],
                      stops: [
                        1.0,1.0,1.0
                      ],
                    )
                ),
              ),
            ),
          ),

          Positioned(
            right: -10,
            top: 211,
            child: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.grey[800]),onPressed: (){},),
            //Text('<<',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.grey[500]),),
          ),
          Positioned(
            left: 3,
            child: Column(
              children: [
                SizedBox(height: 22,),
                IconButton(
                    icon:Icon(Icons.menu,
                      size: 30,
                      color: Colors.grey[800],
                    ),
                    onPressed: () {_stackKey.currentState.openDrawer();}
                ),

              ],
            ),
          ),

          Positioned(
            top: 90,
            left: 46,
            child: AnimatedSearchBar(),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width/8,
            top: 56,
            child: Row(
              children: [
                SizedBox(width: 2,),
                Text("Green",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.black,letterSpacing: 0),),
                Text("Key",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w300,color: Colors.grey[700],letterSpacing: -1),),
              ],
            ),
          ),
        ],


      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.grey[900],
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 34,),

                    StreamBuilder<UserData>(
                      stream: DatabaseService(uid: user.uid).userData,
                        builder: (context, snapshot) {
                          UserData userData = snapshot.data;
                          _currentProfilepic = userData.profile_pic;
                          return CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                              backgroundImage: _currentProfilepic != "" ? NetworkImage('$_currentProfilepic') : NetworkImage(''),
                          );
                        }
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    StreamBuilder<UserData>(
                        stream: DatabaseService(uid: user.uid).userData,
                        builder: (context, snapshot) {
                          UserData userData = snapshot.data;
                          return Text("  ${userData.uname}  ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          );
                        }
                    ),
                      
                    StreamBuilder<UserData>(
                      stream: DatabaseService(uid: user.uid).userData,
                      builder: (context, snapshot) {
                        UserData userData = snapshot.data;
                        email = userData.email;
                        return Text("  ${userData.email}  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        );
                      }
                    ),
                    SizedBox(height: 30,),
                    Container(
                      color: Colors.black,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            selected: _selectedindex == 0,
                            //         selectedTileColor: Colors.green[100],
                            leading: Icon(Icons.account_box,
                              color: Colors.grey,
                            ),
                            title: Text('My Account', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Profile()),
                              );
                            },
                          ),
                          ListTile(
                            selected: _selectedindex == 1,
                            //       selectedTileColor: Colors.green[100],
                            leading: Icon(Icons.build,
                                color:Colors.grey,
                            ),
                            title: Text('Settings', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),),
                            onTap: () {
                              setState(() {
                                _bottomSelect = Profile();
                                _selectedindex = 1;
                                _toggle = false;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            selected: _selectedindex == 2,
                            //     selectedTileColor: Colors.green[100],
                            leading: Icon(Icons.lock_outline,
                                color: Colors.grey,
                            ),
                            title: Text('Logout',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () async {
                              setState(() {
                                _selectedindex = 2;
                              });
                              showAlertDialog(context);
                            },
                          ),
                          ListTile(
                            selected: _selectedindex == 3,
                            //   selectedTileColor: Colors.green[100],
                            leading: Icon(Icons.favorite,
                              color: Colors.grey,),
                            title: Text('Favorite Lists', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),),
                            onTap: () {
                              setState(() {
                                _selectedindex = 3;
                                _toggle = false;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            selected: _selectedindex == 4,
                            // selectedTileColor: Colors.green[100],
                            leading: Icon(Icons.local_offer,
                              color: Colors.grey,),
                            title: Text('Offer/Reward Area',
                              style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),),
                            onTap: () {
                              setState(() {
                                _selectedindex = 4;
                                _toggle = false;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            selected: _selectedindex == 5,
                            //                 selectedTileColor: Colors.green[100],
                            leading: Icon(Icons.business_center,
                              color: Colors.grey,),
                            title: Text('Sell on GreenKey',
                              style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),),
                            onTap: () {
                              setState(() {
                                _selectedindex = 5;
                                _toggle = false;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(height: 16,),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0),
                            child: Container(
                              height: 2.0,
                              width: 290.0,
                              color: Colors.grey,),),
                          ListTile(
                            selected: _selectedindex == 6,
                            //               selectedTileColor: Colors.green[100],
                            title: Text('Privacy Policies',
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),),
                            onTap: () {
                              setState(() {
                                _selectedindex = 6;
                                _toggle = false;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            selected: _selectedindex == 7,
                            //            selectedTileColor: Colors.green[100],
                            title: Text('Help Center', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            ),
                            onTap: () {
                              setState(() {
                                _selectedindex = 7;
                                _toggle = false;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            selected: _selectedindex == 8,
                            //          selectedTileColor: Colors.green[100],
                            title: Text('Green Plus Zone',
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _bottomSelect = Profile();
                                _selectedindex = 8;
                                _toggle = false;
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            selected: _selectedindex == 9,
                            //          selectedTileColor: Colors.green[100],
                            title: Text('Admin Login',
                              style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              if (email == 'admin123@greenkey.co.in')
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAdmin()));
                              else{
                                showDialog(context: context,
                                    builder:(context){
                                      return new AlertDialog(
                                        title: Text("Not Allowed"),
                                        content: Text("Ooopss, You are not allowed to this section!!"),
                                        actions: <Widget>[
                                          new MaterialButton(onPressed: (){
                                            Navigator.pop(context);
                                          },
                                            child: Text("OK"),)
                                        ],
                                      );
                                    }
                                );
                              }
                                //showAlertDialogBox(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        iconSize: 24.0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 19,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedFontSize: 12,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home,color: green_clr,),
            title: Text('Home',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.black,
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail,color: green_clr,),
            title: Text('Mssg',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.black,
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mobile_screen_share,color: green_clr,),
            title: Text('GreenPay',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.black,
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone,color: green_clr,),
            title: Text('Contact',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.black,
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,color: green_clr,),
            title: Text('Cart',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.black,
          ),
        ],
        onTap: (index){setState(() {
          _currentIndex=index;
          switch(_currentIndex){
            case 0 : _bottomSelect = MyApp2();
                     break;
            case 1 : _bottomSelect = Message();
                     break;
            case 2 : _bottomSelect = GreenPay();
                     break;
            case 3 : _bottomSelect = Contact();
                     break;
            case 4 : _bottomSelect = Cart();
                     break;
          }
        });},
      ),
    );
  }
}


class AnimatedSearchBar extends StatefulWidget {
  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _folded = true;
  List products = [];

  @override
  void initState(){
    super.initState();
    fetchDatabaseProducts();
  }
  fetchDatabaseProducts() async{
    dynamic resultant = await ProductDatabase().getProductsList();

    if (resultant == null) {
      print('Loading Product , please wait.....');
    }else{
      setState(() {
        products = resultant;
      });
    }
  }

@override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 80),
      duration: Duration(milliseconds: 400),
      width:  290,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: kElevationToShadow[12],
      ),
      child: Column(
        children:<Widget>[
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 8,bottom: 0,),
                  child: Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: FlatButton(
                          color: Colors.grey[200],
                            child: Text(
                    'click to search',
                    style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
                  ),
                    onPressed: ()  {
                          showSearch(context: context, delegate: ProductsSearch(temSearchResults: products));
                          setState(() {
                          });
                    },
                          ),
                      ),
                ),
              ),

              Container(
                color: Colors.grey[200],
                height: 36,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0,bottom: 0,right: 6,),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey[600],
                        size: 24,

                      ),
                    ),
                    onTap: () {
                      showSearch(context: context, delegate: ProductsSearch(temSearchResults: products));
                      setState(() {
                        //_folded = !_folded;
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 36,
                child: Material(
                  type: MaterialType.transparency,
                  child:
                      InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16,top: 4,right: 10,),
                        child:
                        new Stack(
                            children: <Widget>[
                              new Icon( Icons.notifications_active,
                                color: Colors.grey[600],
                                size: 24,),
                              new Positioned(  // draw a red marble
                                top: 0.0,
                                right: 0.0,
                                left: 12,
                                child: new Icon(Icons.brightness_1, size: 13.0,
                                    color: Colors.redAccent),
                              ),
                              new Positioned(  // draw a red marble
                                top: 0.0,
                                right: 0.0,
                                left: 16,
                                child: new Text('4',style: TextStyle(fontWeight: FontWeight.bold,fontSize:10,color: Colors.white),),
                              ),

                            ]
                        ),
                      ),
                      onTap: () {

                        setState(() {

                        });
                      },
                    ),
                ),
              ),
            ],
          ),

        ]
      ),
    );
  }
}


class ProductsSearch extends SearchDelegate<String>{
  final List temSearchResults;
  ProductsSearch({
   this.temSearchResults,
});
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading

  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final dynamic products= query.isEmpty ? temSearchResults
        : temSearchResults.where((p) => p.name.toUpperCase().startsWith(query.toUpperCase())).toList();
    return ListView.builder(itemBuilder: (context,i)=>
    ListTile(
      leading: Icon(Icons.category),
      title: Text(products[i].name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetails(
            detail_pid: products[i].pid,detail_name: products[i].name,detail_productPic: products[i].productPic,detail_actualPrice: products[i].actualPrice,detail_discountPrice: products[i].discountPrice,detail_description: products[i].description,detail_brand: products[i].brand,detail_rating: products[i].rating,
          )),
        );
      },
    ),
        itemCount: products.length,
    );
  }
  
}


class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;



  List products = [];
  @override
  void initState() {
    super.initState();
    fetchDatabaseProducts();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }
  fetchDatabaseProducts() async{
     dynamic resultant = await ProductDatabase().getProductsList();

    if (resultant == null) {
      print('Loading Product , please wait.....');
    }else{
      setState(() {
        products = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final green = Provider.of<List<Green>>(context) ?? [];
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.34;
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Container(
            height: size.height + 286,
            child: Column(
              children: <Widget>[

                const SizedBox(
                  height: 4,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: closeTopContainer?0:1,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: size.width,
                      alignment: Alignment.topCenter,
                      height: closeTopContainer?0:categoryHeight,
                      child: categoriesScroller),
                ),
            Column(
              children:<Widget>[
                Align(alignment: Alignment.centerLeft,child: Text('Suggested :',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),textAlign: TextAlign.left,)),
                Container(
                height: 104,
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (ctx, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Hero(
                          tag: products[i].pid,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              child: Material(
                                child: InkWell(
                                  child: Image.network(products[i].productPic,fit: BoxFit.cover,),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProductDetails(
                                        detail_pid: products[i].pid,detail_name: products[i].name,detail_productPic: products[i].productPic,detail_actualPrice: products[i].actualPrice,detail_discountPrice: products[i].discountPrice,detail_description: products[i].description,detail_brand: products[i].brand,detail_rating: products[i].rating,
                                      )),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ],
            ),
                Column(
                  children:<Widget>[
                    SizedBox(height: 0,),
                    Align(alignment: Alignment.centerLeft,child: Text('Popular :',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),textAlign: TextAlign.left,)),
                 Container(
                  height: 104,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Hero(
                            tag: products[i].brand,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.black,
                                ),
                                child: Material(
                                  child: InkWell(
                                    child: Image.network(products[i].productPic,fit: BoxFit.cover,),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProductDetails(
                                          detail_pid: products[i].pid,detail_name: products[i].name,detail_productPic: products[i].productPic,detail_actualPrice: products[i].actualPrice,detail_discountPrice: products[i].discountPrice,detail_description: products[i].description,detail_brand: products[i].brand,detail_rating: products[i].rating,
                                        )),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ],
            ),
                SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft,child: Text(' Explore :',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.grey[900]),textAlign: TextAlign.left,)),
                SizedBox(height: 8,),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: size.height/1.82,
                  child:
                  GridView.builder(
                  itemCount: products.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int i){
                    return Single_prod(
                      pid: products[i].pid,
                      name: products[i].name,
                      productPic: products[i].productPic,
                      actualPrice: products[i].actualPrice,
                      discountPrice: products[i].discountPrice,
                      description: products[i].description,
                      brand: products[i].brand,
                      rating: products[i].rating,
                    );
                  }
                ),),
              ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final double categoryHeight = MediaQuery.of(context).size.height * 0.22 - 18;
    final clr1 = Colors.black;
    final clr2 = Colors.white;
    return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                InkWell(
                  onTap:() async {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Category(category: 'ORGANIC FARMING',)),
                  );},
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 3,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: clr1,
                    ),
                    child: Text("Organic Farm",style: TextStyle(color: clr2,fontWeight: FontWeight.normal),),
                  ),

                ),
                InkWell(
                  onTap:() async {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Category(category: 'REMEDIES',)),
                  );},
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 3,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: clr1,
                    ),
                    child: Text("Remedies",style: TextStyle(color: clr2,fontWeight: FontWeight.normal),),
                  ),
                ),
                InkWell(
                  onTap:() async {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Category(category: 'SEEDS',)),
                  );},
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 3,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: clr1,
                    ),
                    child: Text("Seeds",style: TextStyle(color: clr2,fontWeight: FontWeight.normal),),
                  ),
                ),
                InkWell(
                  onTap:() async {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Category(category: 'EQUIPMENTS',)),
                  );},
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 3,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: clr1,
                    ),
                    child: Text("Equipments",style: TextStyle(color: clr2,fontWeight: FontWeight.normal),),
                  ),
                ),
                InkWell(
                  onTap:() async {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Category(category: 'FERTILISERS',)),
                  );},
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width /2.6,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: clr1,
                    ),
                    child: Text("Fertilisers",style: TextStyle(color: clr2,fontWeight: FontWeight.normal),),
                  ),
                ),
                InkWell(
                  onTap:() async {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Category(category: 'IRRIGATION',)),
                  );},
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width /2.6,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: clr1,
                    ),
                    child: Text("Irrigation",style: TextStyle(color: clr2,fontWeight: FontWeight.normal),),
                  ),
                ),
                InkWell(
                  onTap:() async {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Category(category: 'OTHERS',)),
                  );},
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width /2.6,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: clr1,
                    ),
                    child: Text("Others",style: TextStyle(color: clr2,fontWeight: FontWeight.normal),),
                  ),
                ),
              ],
            ),
          ),

          SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            child: Row(
              children: <Widget>[
                Container(
                  width: 250,
                  margin: EdgeInsets.only(right: 10),
                  height: categoryHeight,
                  decoration: BoxDecoration(color: Colors.deepPurpleAccent, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Most Rated\nEquipments",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "20 Items",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.only(right: 10),
                  height: categoryHeight,
                  decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Newest",
                            style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "20 Items",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.only(right: 10),
                  height: categoryHeight,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Farmese\nZone",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "20 Items",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.only(right: 10),
                  height: categoryHeight,
                  decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Deepavali\nOffers",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "20 Items",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
          SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
                  (i) {
                return Container(
                  width: 9,
                  height: 9,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == index ? Colors.black : Colors.grey,
                  ),
                );
              },
            ),
          )
    ],
    );

  }
}

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("NO MESSAGES",style: TextStyle(fontSize: 40,color: Colors.grey[800]))),
    );
  }
}

class GreenPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Well come to GREENPAY",style: TextStyle(fontSize: 40,color: Colors.grey[800]))),
    );
  }
}

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("9632068562",style: TextStyle(fontSize: 40,color: Colors.grey[800]))),
    );
  }
}

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return CartScreen(uid: user.uid,);
    /*Container(
      child: Center(child: Text("Please Select the items to update Cart",style: TextStyle(fontSize: 40,color: Colors.grey[800]))),
    );*/
  }
}


//class to display products in explore section
class Single_prod extends StatelessWidget {
  final pid;
  final name;
  final productPic;
  final actualPrice;
  final discountPrice;
  final description;
  final brand;
  final rating;
  Single_prod({
    this.pid,
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
      padding: const EdgeInsets.all(12.0),
      child: Card(

        child: Hero(
          tag: name,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.black,
              ),
              child: Material(
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetails(
                      detail_pid: pid,detail_name: name,detail_productPic: productPic,detail_actualPrice: actualPrice,detail_discountPrice: discountPrice,detail_description: description,detail_brand: brand,detail_rating: rating,
                    )),
                   );
                  },
                  child: GridTile(
                      footer: Container(
                        color: Colors.white70,
                        child: Column(
                          children: <Widget>[
                            //Text('$name\n', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                            Align(alignment: Alignment.centerLeft,child: Text(' $name',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)),
                            Align(alignment: Alignment.centerLeft,child: Text(' ₹ $discountPrice',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.grey[900]),)),
                            Align(alignment: Alignment.centerLeft,child: Text(' ₹ $actualPrice',textAlign: TextAlign.left,style: TextStyle(fontSize: 12,color: Colors.red,decoration: TextDecoration.lineThrough),)),
                          ],
                        ),
                      ),
                    child: Image.network(productPic,fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
