import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            titleSection,
            Image.asset(
                'assets/equip.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0,),
            Text("\$ 25.00",
              textDirection: TextDirection.ltr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text("MRP \$̶3̶0̶.̶0̶0̶\n",
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonColumn(Colors.blueGrey, Icons.shopping_bag_rounded, 'Buy Now'),
                _buildButtonColumn(Colors.blueGrey, Icons.shopping_cart, 'Add to Cart'),
                _buildButtonColumn(Colors.blueGrey, Icons.favorite, 'Add to fav'),
                _buildButtonColumn(Colors.blueGrey, Icons.share, 'Share'),
              ],
            ),
            textSection,
          ],
        ),
      ),
    );
  }

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Agri Equip',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Ben & Jerry/'s",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        /*3*/
        Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        Text('4.1'),
      ],
    ),
  );


  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color,),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );
}