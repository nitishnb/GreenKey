import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {

  final isSelected;
  final String text;
  final Function onTabTap;

  const SidebarItem({
    Key key,
    this.isSelected,
    this.text,
    this.onTabTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -1.58,
      child: GestureDetector(
        onTap: onTabTap,
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 6,
              width: 6,
              decoration: BoxDecoration(shape: BoxShape.circle, color: isSelected ? Colors.grey[900] : Colors.transparent),
            ),
            AnimatedDefaultTextStyle(
              child: Text(
                text,
              ),
              duration: const Duration(milliseconds: 280),
              style: isSelected ? TextStyle(fontSize: 21.0,color: Colors.grey[900],fontWeight: FontWeight.bold) : TextStyle(fontSize: 20.0,color: Colors.blueGrey,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}