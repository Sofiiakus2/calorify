import 'package:flutter/material.dart';

class ListElementView extends StatelessWidget {
  const ListElementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(30)
        ),
        color: Colors.grey.shade200,
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Avocado',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 5,),
              Text('100 грам, 180 ккал',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Icon(Icons.add, size: 22, color: Colors.black,)
        ],
      ),
    );
  }
}
