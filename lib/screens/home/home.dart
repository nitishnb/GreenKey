import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GreenKey/screens/home/sidebar/sidebarlayout.dart';
import 'package:GreenKey/services/auth.dart';
import 'package:GreenKey/screens/home/constants.dart';
import 'package:GreenKey/screens/home/profile.dart';

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
  final AuthService _auth = AuthService();

  GlobalKey<ScaffoldState> _stackKey = GlobalKey<ScaffoldState>();
  int _currentIndex =0;
  dynamic _bottomSelect = MyApp2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _stackKey,
      body: Stack(
        children:<Widget>[
          Positioned(
            top: 110,
            left: 18,
            right: 10,
            bottom: 2,
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
                        Colors.lightGreenAccent.shade400,
                        Colors.lightGreenAccent.shade400,
                        Colors.lightGreenAccent.shade400
                      ],
                      stops: [
                        0.0,1.0,1.0
                      ],
                    )
                ),
              ),
            ),
          ),

          Positioned(
            right: -10,
            top: 211,
            child: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.grey[500]),onPressed: (){},),
            //Text('<<',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.grey[500]),),
          ),
          Positioned(
            left: 3,
            top: 15,
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
            left: 50,
            top: 30,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Green",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.lightGreenAccent.shade400,),),
              ],
            ),
          ),
          Positioned(
            left: 148,
            top: 30,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Key",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.grey[900]),),
              ],
            ),
          ),
          Positioned(
            top: 90,
            left: 46,
            child: AnimatedSearchBar(),
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
                    Container(
                      margin: EdgeInsets.only(top: 20,bottom: 16),
                      child: Icon(Icons.account_circle,size: 90,color: Colors.lightGreenAccent.shade400,),
                    ),
                    Text('Nikhil Gowda',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.lightGreenAccent.shade400,
                      ),),
                    Text('nikhianad@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.lightGreenAccent.shade400,
                      ),
                    ),
                    SizedBox(height: 18,),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.account_box,color: Colors.lightGreenAccent.shade400,),
                            title: Text('My Account',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800],
                            ),),
                            onTap: (){
                              setState(() {
                                _bottomSelect = Profile();
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.build,color: Colors.lightGreenAccent.shade400,),
                            title: Text('Settings',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800],
                            ),),
                            onTap: (){},
                          ),
                          ListTile(
                            leading: Icon(Icons.lock_outline,color: Colors.lightGreenAccent.shade400,),
                            title: Text('Logout',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800],
                            ),),
                            onTap: () async {
                              await _auth.signOut();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.favorite,color: Colors.lightGreenAccent.shade400,),
                            title: Text('Fav Lists',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800],
                            ),),
                            onTap: (){},
                          ),
                          ListTile(
                            leading: Icon(Icons.local_offer,color: Colors.lightGreenAccent.shade400,),
                            title: Text('Offer/Reward Area',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800],
                            ),),
                            onTap: (){},
                          ),
                          ListTile(
                            leading: Icon(Icons.business_center, color: Colors.lightGreenAccent.shade400,),
                            title: Text('Sell on GreenKey',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey[800],
                            ),),
                            onTap: (){},
                          ),
                          Padding(
                            padding:EdgeInsets.symmetric(horizontal:2.0),
                            child:Container(
                              height:2.0,
                              width:290.0,
                              color:Colors.grey,),),
                          ListTile(
                            title: Text('Privacy Policies',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[800],
                            ),),
                            onTap: (){},
                          ),
                          ListTile(
                            title: Text('Help Center',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[800],
                            ),),
                            onTap: (){},
                          ),
                          ListTile(
                            title: Text('Green Plus Zone',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey[800],
                            ),),
                            onTap: (){},
                          ),
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
        backgroundColor: Colors.grey[900],
        iconSize: 24.0,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 19,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedFontSize: 12,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.lightGreenAccent.shade400,),
            title: Text('Home',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.grey[900],
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail,color: Colors.lightGreenAccent.shade400,),
            title: Text('Msg',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.grey[900],
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mobile_screen_share,color: Colors.lightGreenAccent.shade400,),
            title: Text('GreenPay',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.grey[900],
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone,color: Colors.lightGreenAccent.shade400,),
            title: Text('Contact',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.grey[900],
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,color: Colors.lightGreenAccent.shade400,),
            title: Text('Cart',style: TextStyle(color: Colors.white,),),
            backgroundColor: Colors.grey[900],
          ),
        ],
        onTap: (index){setState(() {
              _currentIndex = index;
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = FARM_DATA;
    List<Widget> listItems = [];
    responseList.forEach((post) {
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
    });
    setState(() {
      itemsData = listItems;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Container(
          height: size.height,
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
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform:  Matrix4.identity()..scale(scale,scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      })),
            ],
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
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Container(
                width: 250,
                margin: EdgeInsets.only(right: 10),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.yellow.shade500, borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
    return Container(
      child: Center(child: Text("Please Select the items to update Cart",style: TextStyle(fontSize: 40,color: Colors.grey[800]))),
    );
  }
}