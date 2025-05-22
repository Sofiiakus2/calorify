import 'dart:convert';
import 'dart:io';

import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/provider/selected_meal_provider.dart';
import 'package:calorify/core/theme.dart';
import 'package:calorify/features/ai_functional/domain/entities/analyzed_meal.dart';
import 'package:calorify/features/ai_functional/domain/usecases/get_ai_responce.dart';
import 'package:calorify/features/ai_functional/domain/usecases/pick_image.dart';
import 'package:calorify/features/food_page/domain/usecases/product/recount_left_calories.dart';
import 'package:calorify/features/food_page/domain/usecases/product/save_product_to_db.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/food/grid_food.dart';
import 'package:calorify/shared/presentation/widgets/custom_elevated_button.dart';
import 'package:calorify/shared/presentation/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AiResponcePage extends StatefulWidget {
  const AiResponcePage({super.key});

  @override
  State<AiResponcePage> createState() => _AiResponcePageState();
}

class _AiResponcePageState extends State<AiResponcePage> {
  List<MyProduct> products = [];
  Totals? totals;
  XFile? pickedImage;

  @override
  void initState() {
    super.initState();
    _pickAndAnalyze();
  }

  Future<void> _pickAndAnalyze() async {
    final pickImageUseCase = sl<PickImageUseCase>();
    final getAiResponce = sl<GetAiResponce>();

    final image = await pickImageUseCase();
    if (image == null) return;

    setState(() => pickedImage = image);

    final bytes = await image.readAsBytes();
    final base64 = base64Encode(bytes);
    final analyzedMeal = await getAiResponce.analyzeImageWithBase64(base64);

    setState(() {
      products = analyzedMeal.products;
      totals = analyzedMeal.totals;
    });
  }

  // ignore: avoid_returning_widgets
  Text _buildNutrientText(String label, num value) {
    return Text(
      '$label: ${value.toStringAsFixed(0)}',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
    );
  }

  @override
  // ignore: cyclomatic_complexity
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Калораж страви',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: products.isNotEmpty
          ? CustomElevatedButton(
        text: 'Додати',
          onPressed: () async {
            MealModel? selectedMeal = context.read<SelectedMealProvider>().selectedMeal;

            if (selectedMeal == null) {
              await showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: 'Meals',
                barrierColor: Colors.black54,
                pageBuilder: (context, anim, secAnim) {
                  return Container(
                    margin: const EdgeInsets.only(top: 150),
                    child: const GridFood(isDialog: true),
                  );
                },
              );
            }

            selectedMeal = context.read<SelectedMealProvider>().selectedMeal;

            final product = MyProduct.fromTotals(totals!);

            final saveProductToDb = sl<SaveProductToDb>();
            await saveProductToDb.call(product, selectedMeal!);

            final recountLeftCalories = sl<RecountLeftCalories>();
            await recountLeftCalories.call(product);
            context.read<SelectedMealProvider>().clear();

            Navigator.pop(context);
          }

      )
          : null,
      body: Column(
        children: [
          if (pickedImage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.file(
                  File(pickedImage!.path),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if(pickedImage != null && products.isEmpty)
            Center(
              child: LoadingWidget(),
            ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: products.length + 1,
              itemBuilder: (context, index) {
                if (index == products.length) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade200,
                    ),
                    margin: const EdgeInsets.only(top: 15, left: 10, right: 10 , bottom: 100),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNutrientText('К', totals?.totalCalories ?? 0),
                        _buildNutrientText('Б', totals?.totalProteins ?? 0),
                        _buildNutrientText('Ж', totals?.totalFats ?? 0),
                        _buildNutrientText('В', totals?.totalCarbohydrates ?? 0),
                      ],
                    ),
                  );
                }

                final item = products[index];

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.shade200,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name),
                            const SizedBox(height: 4),
                            Row(
                              spacing: 10,
                              children: [
                                _buildNutrientText('К', item.energyKcal_100g),
                                _buildNutrientText('Б', item.protein_100g),
                                _buildNutrientText('Ж', item.fat_100g),
                                _buildNutrientText('В', item.carbohydrates_100g),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        item.weight ?? '',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
