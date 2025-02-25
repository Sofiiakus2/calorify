import 'package:flutter/material.dart';

Widget buildActivityCard({
  required String name,
  required int calories,
  required String icon,
  required Color color,
  required BuildContext context
}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: color
    ),
    margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Center(
                  child: Image.asset('assets/icons/sport/$icon.png'),
                ),
              ),              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text('$calories ккал',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.mode_edit_outline_outlined, color: Colors.black,)

        ],
      ),
    ),
  );
}
