import 'package:flutter/material.dart';

List<Widget> buildWaterDrops() {
  List<Widget> drops = [];
  for (int i = 0; i < 8; i++) {
    drops.add(
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Icon(
            Icons.water_drop,
            size: 44.0,
            color: i < 3 ? Color(0xFFbdcbea) : Colors.grey[300],
          ),
          if (i >= 3)
            Icon(
              Icons.add,
              size: 20.0,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
  return drops;
}
