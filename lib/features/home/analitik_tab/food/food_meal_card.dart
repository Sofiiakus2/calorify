import 'package:flutter/material.dart';

Widget buildMealCard({
  required String meal,
  required int calories,
  required String icon,
  required Color color,
  required BuildContext context
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: color,
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Center(
                  child: Image.asset('assets/icons/food/$icon.png'),
                ),
              ),
              SizedBox(width: 10,),
              Text('$calories ккал',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(meal,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.add, color: Colors.black,))
            ],
          )
        ],
      ),

    ),
  );
}
