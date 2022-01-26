import 'package:flutter/material.dart';

class Remedy extends StatefulWidget {
  final List disease;

  Remedy({Key key, @required this.disease}) : super(key: key);

  @override
  State<Remedy> createState() => _RemedyState();
}

class _RemedyState extends State<Remedy> {
  List quanti=[0,0,0,0,0,0,0,0];
  var rem_dis = <String,List>{'Apple___Apple_scab': ['_Apple_scab', 232], 'Apple___Black_rot': ['_Black_rot', 123], 'Apple___Cedar_apple_rust': ['_Cedar_apple_rust', 140], 'Apple___healthy': ['_healthy', 267], 'Blueberry___healthy': ['_healthy', 138], 'Cherry___Powdery_mildew': ['_Powdery_mildew', 324], 'Cherry___healthy': ['_healthy', 230], 'Corn(maize)___leafspotGray_leaf_spot': ['_leafspotGray_leaf_spot', 331], 'Corn(maize)___Common_rust_': ['_Common_rust_', 101], 'Corn(maize)___Northern_Leaf_Blight': ['_Northern_Leaf_Blight', 171], 'Corn(maize)___healthy': ['_healthy', 314], 'Grape___Black_rot': ['_Black_rot', 195], 'Grape___Esca_(Black_Measles)': ['_Esca_(Black_Measles)', 112], 'Grape___blight_(Isariopsis_Leaf_Spot)': ['_blight_(Isariopsis_Leaf_Spot)', 129], 'Grape___healthy': ['_healthy', 154], 'Orange___Haunglongbing(Citrus_greening)': ['_Haunglongbing(Citrus_greening)', 212], 'Peach___Bacterial_spot': ['_Bacterial_spot', 104], 'Peach___healthy': ['_healthy', 268], 'Pepper,_bell___Bacterial_spot': ['_Bacterial_spot', 342], 'Pepper,_bell___healthy': ['_healthy', 179], 'Potato___Early_blight': ['_Early_blight', 199], 'Potato___Late_blight': ['_Late_blight', 168], 'Potato___healthy': ['_healthy', 329], 'Raspberry___healthy': ['_healthy', 350], 'Soybean___healthy': ['_healthy', 137], 'Squash___Powdery_mildew': ['_Powdery_mildew', 190], 'Strawberry___Leaf_scorch': ['_Leaf_scorch', 171], 'Strawberry___healthy': ['_healthy', 229], 'Tomato___Bacterial_spot': ['_Bacterial_spot', 298], 'Tomato___Early_blight': ['_Early_blight', 146], 'Tomato___Late_blight': ['_Late_blight', 317], 'Tomato___Leaf_Mold': ['_Leaf_Mold', 186], 'Tomato___Septoria_leaf_spot': ['_Septoria_leaf_spot', 225], 'Tomato___Two-spotted_spider_mite': ['_Two-spotted_spider_mite', 263], 'Tomato___Target_Spot': ['_Target_Spot', 308], 'Tomato___Yellow_Leaf_Curl_Virus': ['_Yellow_Leaf_Curl_Virus', 132], 'Tomato___Tomato_mosaic_virus': ['_Tomato_mosaic_virus', 255], 'Tomato___healthy': ['_healthy', 224]};

  @override
  void initState() {
    Clac();
    super.initState();
  }

  Clac(){
    double total = 0;
    for( var i in widget.disease){
      total += i['confidence'];
    }
    int x=0;
    for(var i in widget.disease){
      quanti[x++] = i['confidence']/total;
    }
    print(quanti);
  }

  int y =0;

  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Remedies',style: TextStyle(fontSize: 24),),backgroundColor: Colors.lightGreen,),
    body: Center(
      child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("The recommended medicines for diseases :\n",style: TextStyle(fontSize:18 )),
            for(var item in widget.disease ) quanti[0]!=0?Text("${y+1}. ${rem_dis[item['label']][0]}: ${(((rem_dis[item['label']][1])*quanti[y++])).toInt()}ml per can \n",
              style: TextStyle(fontSize:20,color: Colors.white,backgroundColor: Colors.green ),)
                                                           :Text(" "),
            SizedBox(
              height: MediaQuery.of(context).size.height*.06,
            ),
            Text("NOTE : Here 1 can = 20 lit......"),
          ]
      ),
    ),
  );
}
}

