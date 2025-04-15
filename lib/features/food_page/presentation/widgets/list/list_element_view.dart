import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/theme.dart';
import 'package:calorify/features/food_page/domain/usecases/product/save_product_to_history.dart';
import 'package:calorify/features/food_page/presentation/widgets/list/calories_editor.dart';
import 'package:flutter/material.dart';

///element of the list view
class ListElementView extends StatelessWidget {
  final MyProduct product;
  final bool isSelected;

  ///
  const ListElementView({
    super.key,
    required this.product,
    this.isSelected = false,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
            Radius.circular(30),
        ),
        color: isSelected ? lightGreen : Colors.grey.shade200,
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
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
                    const SizedBox(height: 5,),
                    Text('100 грам, ${product.energyKcal_100g.toInt()} ккал',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () async{
                    final saveProductToHistory = sl<SaveProductToHistory>();
                    await saveProductToHistory.call(product);
                  },
                  icon: const Icon(Icons.add, size: 22, color: Colors.black,)),
            ],
          ),
          if(isSelected)
            CaloriesEditor(product: product,),
        ],
      ),
    );
  }
}
