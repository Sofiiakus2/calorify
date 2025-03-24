import 'package:calorify/features/food_page/food_tab/calories_settings.dart';
import 'package:calorify/models/product_model.dart';
import 'package:calorify/theme.dart';
import 'package:flutter/material.dart';

class ListElementView extends StatelessWidget {
  final ProductModel product;
  final bool isSelected;

  const ListElementView({super.key, required this.product, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(30)
        ),
        color: isSelected ? lightGreen : Colors.grey.shade200,
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5,),
                Text('100 грам, ${product.energyKcal_100g.toInt()} ккал',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if(isSelected)
                CaloriesSettings(product: product,),
              ],
            ),
          ),
          Icon(Icons.add, size: 22, color: Colors.black,)
        ],
      ),
    );
  }
}
