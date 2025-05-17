import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/provider/selected_meal_provider.dart';
import 'package:calorify/core/theme.dart';
import 'package:calorify/features/food_page/domain/usecases/product/recount_left_calories.dart';
import 'package:calorify/features/food_page/domain/usecases/product/save_product_to_db.dart';
import 'package:calorify/features/food_page/domain/usecases/product/save_product_to_history.dart';
import 'package:calorify/features/food_page/presentation/bloc/calories/calories_bloc.dart';
import 'package:calorify/features/food_page/presentation/widgets/list/calories_editor.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/grid_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///element of the list view
class ListElementView extends StatelessWidget {
  final MyProduct product;
  final bool isSelected;
  final bool? isHistory;

  ///constructor
  const ListElementView({
    required this.product,
    super.key,
    this.isSelected = false,
    this.isHistory = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CaloriesBloc(product),
        child: Container(
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
                if(isSelected)
                IconButton(
                    onPressed: () async{
                     MealModel? selectedMeal = context.read<SelectedMealProvider>().selectedMeal;
                     if(selectedMeal == null){
                        await showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: 'CalendarOverlay',
                          barrierColor: Colors.black54,
                          pageBuilder: (context, anim, secAnim) {
                            return Container(
                              margin: const EdgeInsets.only(top: 150),
                              child: const GridFood(
                                isDialog: true,
                              ),
                            );
                          },
                        );
                      }
                      selectedMeal = context.read<SelectedMealProvider>().selectedMeal;

                      final saveProductToDb = sl<SaveProductToDb>();
                      await saveProductToDb.call(product, selectedMeal!);

                      final recountLeftCalories = sl<RecountLeftCalories>();
                      await recountLeftCalories.call(product);

                     if(isHistory == true){
                        final saveProductToHistory = sl<SaveProductToHistory>();
                        await saveProductToHistory.call(product);
                      }

                      context.read<SelectedMealProvider>().clear();
                    },
                    icon: const Icon(Icons.add, size: 22, color: Colors.black,),),
              ],
            ),
            if(isSelected)
              CaloriesEditor(product: product,),
          ],
        ),
      ),
    );
  }
}
