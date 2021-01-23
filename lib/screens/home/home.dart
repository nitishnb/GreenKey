import 'package:green_key/screens/home/cart.dart';
import 'package:green_key/screens/home/details.dart';
import 'package:green_key/screens/home/product/productsHome.dart';
import 'package:green_key/screens/home/productHome.dart';
import 'package:green_key/services/prodDatabase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:green_key/screens/admin/homeAdmin.dart';
import 'package:green_key/services/auth.dart';
import 'package:green_key/screens/home/constants.dart';
import 'package:provider/provider.dart';
import 'package:green_key/shared/loading.dart';
import 'package:green_key/services/database.dart';
import 'package:green_key/models/user.dart';
import 'package:green_key/screens/home/sidebar/sidebarLayout.dart';
import 'package:green_key/screens/home/profile.dart';
import 'package:green_key/screens/home/settings.dart';

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
    return  Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Homelayout(),
      ),
      endDrawer:SidebarLayout(),
    );
  }
}



class Homelayout extends StatefulWidget   {

  @override
  _HomelayoutState createState() => _HomelayoutState();
}

class _HomelayoutState  extends State<Homelayout> {
  final Authservice _auth = Authservice();

  GlobalKey<ScaffoldState> _stackKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0, _selectedindex = -1;
  bool _toggle = true;
  dynamic _bottomSelect = null;

  String email = '';

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
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
      child: Text("Logout",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed:  () async {
        await _auth.signOut();
        _auth.signOutGoogle();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
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
    final user = Provider.of<User>(context);
    return Scaffold(
      key: _stackKey,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            bottom: 2,
            child: _bottomSelect ?? MyApp2(ctxt: context),
          ),
          Positioned(
            width: 70,
            top: 0,
            bottom: 0,
            right: -40,
            child: ClipPath(
              clipper: SidebarClipper(180, 290),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green,
                        Colors.green,
                        Colors.green
                      ],
                      stops: [
                        0.0, 1.0, 1.0
                      ],
                    )
                ),
              ),
            ),
          ),

          Positioned(
            right: -10,
            top: 211,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.grey[500]),
              onPressed: () {},),
            //Text('<<',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.grey[500]),),
          ),
          Positioned(
            left: 3,
            top: 25,
            child: Column(
              children: [
                SizedBox(height: 22,),
                IconButton(
                    icon: Icon(Icons.menu,
                      size: 30,
                      color: Colors.grey[800],
                    ),
                    onPressed: () {
                      _stackKey.currentState.openDrawer();
                    }
                ),

              ],
            ),
          ),
          Positioned(
            left: 50,
            top: 40,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Green", style: TextStyle(fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],),),
              ],
            ),
          ),
          Positioned(
            left: 148,
            top: 40,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Key", style: TextStyle(fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900]),),
              ],
            ),
          ),
          Positioned(
            top: 90,
            left: 46,
            child: (_toggle) ? AnimatedSearchBar() : Container() ,
          ),

        ],


      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.grey[800],
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    StreamBuilder<Info>(
                        stream: DatabaseService(uid: user.uid).userData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Info userData = snapshot.data;
                            email = userData.email;
                            //String url = userData.profilePic;
                            return Column(
                              children: <Widget>[
                                SizedBox(height: 20.0,),
                                userData.profilePic == null ?
                                Container(
                                  child: Icon(Icons.account_circle, size: 90,
                                    color: Colors.green,
                                  ),
                                ) :
                                CircleAvatar(
                                  maxRadius: 40.0,
                                  backgroundImage: NetworkImage(userData.profilePic),
                                ),
                                SizedBox(height: 20.0,),
                                Text(userData.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(email,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 18.0,),
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        selected: _selectedindex == 0,
                                        //         selectedTileColor: Colors.green[100],
                                        leading: Icon(Icons.account_box,
                                          color: Colors.green[600],
                                        ),
                                        title: Text('My Account', style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
                                        ),
                                        ),
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
                                        selected: _selectedindex == 1,
                                        //     selectedTileColor: Colors.green[100],
                                        leading: Icon(Icons.build,
                                          color: Colors.green,
                                        ),
                                        title: Text('Settings', style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
                                        ),),
                                        onTap: () {
                                          setState(() {
                                            _bottomSelect = SettingsScreen();
                                            _selectedindex = 1;
                                            _toggle = false;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        selected: _selectedindex == 2,
                                        //   selectedTileColor: Colors.green[100],
                                        leading: Icon(Icons.lock_outline,
                                            color: Colors.green
                                        ),
                                        title: Text('Logout',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
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
                                        // selectedTileColor: Colors.green[100],
                                        leading: Icon(Icons.favorite,
                                          color: Colors.green,),
                                        title: Text('Fav Lists', style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
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
                                        //           selectedTileColor: Colors.green[100],
                                        leading: Icon(Icons.local_offer,
                                          color: Colors.green,),
                                        title: Text('Offer/Reward Area',
                                          style: TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
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
                                        //         selectedTileColor: Colors.green[100],
                                        leading: Icon(Icons.business_center,
                                          color: Colors.green,),
                                        title: Text('Sell on GreenKey',
                                          style: TextStyle(fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          ),),
                                        onTap: () {
                                          setState(() {
                                            _selectedindex = 5;
                                            _toggle = false;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: Container(
                                          height: 2.0,
                                          width: 290.0,
                                          color: Colors.grey,),),
                                      ListTile(
                                        selected: _selectedindex == 6,
                                        //       selectedTileColor: Colors.green[100],
                                        title: Text('Privacy Policies',
                                          style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
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
                                        //       selectedTileColor: Colors.green[100],
                                        title: Text('Help Center', style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
                                        ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _selectedindex = 7;
                                            _bottomSelect = Help();
                                            _toggle = false;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        selected: _selectedindex == 8,
                                        //     selectedTileColor: Colors.green[100],
                                        title: Text('Green Plus Zone',
                                          style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _selectedindex = 8;
                                            _toggle = false;
                                          });
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Home()),
                                          );
                                        },
                                      ),
                                      email == "admin@greenkey.co.in" ?
                                      ListTile(
                                        selected: _selectedindex == 9,
                                        //          selectedTileColor: Colors.green[100],
                                        title: Text('Admin Login',
                                          style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAdmin()));
                                        },
                                      ) :
                                      Text("$email"),
                                    ],
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Loading();
                          }
                        }
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        iconSize: 24.0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 19,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedFontSize: 12,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.home, color: Colors.green,),
            title: Text(
              'Home', style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.grey[900],
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.view_list, color: Colors.green,),
            title: Text('Category', style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.grey[900],
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone,
              color: Colors.green,),
            title: Text(
              'Contact', style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.grey[900],
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
              color: Colors.green,),
            title: Text(
              'Cart', style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.grey[900],
          ),
        ],
        onTap: (index) {
          setState(() {
            _toggle = true;
            _selectedindex = -1;
            _currentIndex = index;
            switch (_currentIndex) {
              case 0 :
                _bottomSelect = MyApp2(ctxt: context);
                break;
              case 1 :
                _bottomSelect = PHome();
                break;
              case 2 :
                _bottomSelect = Help();
                break;
              case 3 :
                _bottomSelect = CartScreen(uid: user.uid);
                break;
            }
          }
          );
        },
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

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 180),
      duration: Duration(milliseconds: 400),
      width: _folded ? 280 : 320,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: !_folded
                  ? TextField(
                decoration: InputDecoration(
                    hintText: 'Key Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              )
                  : null,
            ),
          ),
          Container(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(_folded ? 32 : 0),
                  topLeft: Radius.circular(32),
                  bottomRight: Radius.circular(_folded ? 32 : 0),
                  bottomLeft: Radius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2,right: 8),
                  child: Icon(
                    _folded ? Icons.search : Icons.close,
                    color: Colors.grey[900],
                    size: 28,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}








class MyApp2 extends StatelessWidget {
  BuildContext ctxt;
  MyApp2({this.ctxt});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(ctxt: ctxt),
    );
  }
}

class MyHomePage extends StatefulWidget {
  BuildContext ctxt;
  MyHomePage({this.ctxt});
  @override
  _MyHomePageState createState() => _MyHomePageState(ctxt: ctxt);
}

class _MyHomePageState extends State<MyHomePage> {
  BuildContext ctxt;
  _MyHomePageState({this.ctxt});
  CategoriesScroller categoriesScroller;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = FARM_DATA;
    List<Widget> listItems = [];
    /*responseList.forEach((post) {
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post["name"],
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post["brand"],
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$ ${post["price"]}",
                      style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Image.asset(
                  "assets/images/${post["image"]}",
                  height: double.infinity,
                )
              ],
            ),
          )));
    });*/

    setState(() {
      itemsData = listItems;
    });
  }

  List products = [];
  List ids = [];

  @override
  void initState() {
    super.initState();


    getPostsData();
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
    } else {
      setState(() {
        products = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchDatabaseProducts();
    categoriesScroller = CategoriesScroller(ctxt: ctxt);
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.34;
    return SafeArea(
      child: Scaffold(


        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Container(
            height: size.height + 500,
            child: Column(
              children: <Widget>[

                const SizedBox(
                  height: 20,
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
                    Align(alignment: Alignment.centerLeft,child: Text('  Recommended:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),textAlign: TextAlign.left,)),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (ctx, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                ctxt,
                                MaterialPageRoute(builder: (ctxt) => DetailsScreen(pid: products[i].pid,)),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.0),
                                  color: Colors.white,
                                ),

                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 3.0,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.transparent,
                                  ),
                                  //child: Text("Test[$i]",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  child: Image.network('${products[i].productPic}',fit:BoxFit.cover ,),
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
                    SizedBox(height: 14,),
                    Align(alignment: Alignment.centerLeft,child: Text('  Popular:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),textAlign: TextAlign.left,)),
                    Container(
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (ctx, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                ctxt,
                                MaterialPageRoute(builder: (ctxt) => DetailsScreen(pid: products[i].pid,)),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.0),
                                  color: Colors.white,
                                ),


                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 3.0,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.transparent,
                                  ),
                                  //child: Text("Test[$i]",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  child: Image.network('${products[i].productPic}',fit:BoxFit.cover ,),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24,),
                Align(alignment: Alignment.centerLeft,child: Text('  Explore:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),textAlign: TextAlign.left,)),
                SizedBox(height: 8,),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: 500,
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
                            img_url: products[i].productPic,
                            actual_price: products[i].actualPrice,
                            discount_price: products[i].discountPrice,
                            ctxt: ctxt,
                          );
                        }
                    ),
                  ),
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
  BuildContext ctxt;
  CategoriesScroller({this.ctxt});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final double categoryHeight = MediaQuery.of(context).size.height * 0.22 - 24;
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            children: [
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.green[800],
                  ),
                  child: Text("Scientific Farming",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                onTap: (){
                  Navigator.push(
                    ctxt,
                    MaterialPageRoute(builder: (ctxt) => Productlist(category:"Technology", title: "Scientific Farming")),
                  );
                },
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.green[800],
                  ),
                  child: Text("Solar Tech",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                onTap: (){
                  Navigator.push(
                    ctxt,
                    MaterialPageRoute(builder: (ctxt) => Productlist(category:"Technology", title: "Solar Tech")),
                  );
                },
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.green[800],
                  ),
                  child: Text("Organic Farm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                onTap: (){
                  Navigator.push(
                    ctxt,
                    MaterialPageRoute(builder: (ctxt) => Productlist(category:"Technology", title: "Organic Farm")),
                  );
                },
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.green[800],
                  ),
                  child: Text("Machinery",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                onTap: (){
                  Navigator.push(
                    ctxt,
                    MaterialPageRoute(builder: (ctxt) => Productlist(category:"Technology", title: "Machinery")),
                  );
                },
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width /2.6,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.green[800],
                  ),
                  child: Text("Chemical Fertilisers",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                onTap: (){
                  Navigator.push(
                    ctxt,
                    MaterialPageRoute(builder: (ctxt) => Productlist(category:"Technology", title: "Chemical Fertilisers")),
                  );
                },
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
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/equip1.jpg'), fit: BoxFit.cover,), borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Most Rated\nEquipments",
                            style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
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
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/new.jpg'), fit: BoxFit.cover,), borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Newest",
                              style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
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
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/agri.jpg'), fit: BoxFit.cover,), borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Farmese\nZone",
                            style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
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
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/deepa.jpg'), fit: BoxFit.cover,), borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Deepavali\nOffers",
                            style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
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


class GreenPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Welcome to GREENPAY",style: TextStyle(fontSize: 40,color: Colors.grey[800]))),
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
    return Container(
      child: Center(child: Text("Please Select the items to update Cart",style: TextStyle(fontSize: 40,color: Colors.grey[800]))),
    );
  }
}

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 60.0,),
                Text(
                  'Help Center',
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 45,
                  ),
                ),
                SizedBox(height: 60.0,),
                Card(
                  color: Colors.lightGreenAccent.shade100,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.mail,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      'customercare@greenkey.com',
                      style:
                      TextStyle(fontFamily: 'BalooBhai', fontSize: 18.0),
                    ),
                    onTap: () => launch("mailto:customercare@greenkey.com"),
                  ),
                ),
                Card(
                  color: Colors.lightGreenAccent.shade100,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      '+91 99723 94504',
                      style:
                      TextStyle(fontFamily: 'BalooBhai', fontSize: 18.0),
                    ),
                    onTap: () => launch("tel:+91 99723 94504"),
                  ),
                ),
              ]
          )
      ),
    );
  }
}


class Single_prod extends StatelessWidget {
  final name;
  final img_url;
  final actual_price;
  final discount_price;
  final pid;
  BuildContext ctxt;
  Single_prod({
    this.pid,
    this.name,
    this.img_url,
    this.actual_price,
    this.discount_price,
    this.ctxt,
  });
  @override


  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: name,
        child: Material(
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                ctxt,
                MaterialPageRoute(builder: (ctxt) => DetailsScreen(pid: pid,)),
              );
            },
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: /*ListTile(
                    leading: Text('$name', style: TextStyle(fontWeight: FontWeight.bold),),
                    title: Text('₹ $actual_price', style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text('₹ $actual_price', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),*/Column(
                  children: <Widget>[
                    //Text('$name\n', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    Align(alignment: Alignment.centerLeft,child: Text('$name',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                    Align(alignment: Alignment.centerLeft,child: Text('₹ $discount_price',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey[900]),)),
                    Align(alignment: Alignment.centerLeft,child: Text('₹ $actual_price',textAlign: TextAlign.left,style: TextStyle(fontSize: 14,color: Colors.red,decoration: TextDecoration.lineThrough),)),
                  ],
                ),
              ),
              child: Image.network(img_url,fit: BoxFit.cover,),
            ),
          ),
        ),
      ),
    );
  }
}