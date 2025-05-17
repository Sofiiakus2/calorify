import 'package:calorify/core/provider/selected_meal_provider.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_block.dart';
import 'package:calorify/features/food_page/presentation/bloc/food/food_event.dart';
import 'package:calorify/features/food_page/presentation/pages/barcode_scanning_page.dart';
import 'package:calorify/features/food_page/presentation/widgets/created/created_list.dart';
import 'package:calorify/features/food_page/presentation/widgets/custom_text_field.dart';
import 'package:calorify/features/food_page/presentation/widgets/food_tab.dart';
import 'package:calorify/features/food_page/presentation/widgets/list/list_food_view.dart';
import 'package:calorify/features/home/data/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///page with selecting food
class FoodPage extends StatefulWidget {
  ///constructor
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final TextEditingController _controller = TextEditingController();
  String title = "Знайти продукт";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {});
  }

  void getTitle(){
    if(context.read<SelectedMealProvider>().selectedMeal != null){
      final meal = context.read<SelectedMealProvider>().selectedMeal!;
      title = MealModel.getMealNameUkrainian(meal.meal);
    }
  }

  @override
  Widget build(BuildContext context) {
    getTitle();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Продукт, страва або бренд',
                    controller: _controller,
                    icon: const Icon(Icons.search, color: Colors.grey),
                    isError: false,
                  ),
                ),
                const SizedBox(width: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: IconButton(
                    icon: const Icon(
                        Icons.settings_overscan,
                        color: Colors.white,
                    ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BarcodeScanningPage()),
                        );
                        final block = context.read<FoodBlock>();

                        if (result != null && result is String) {
                          try {
                            block.add(AddProductFromBarcode(result));

                          } catch (error) {
                            print('Error getting product: $error');
                          }
                        }
                      },
                  ),
                ),
              ],
            ),
          ),
          FoodTab(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ListFoodView(),
                CreatedList(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final selectedMeal = context.read<SelectedMealProvider>().selectedMeal;
    if (selectedMeal != null) {
      setState(() {
        title = selectedMeal.meal.name;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
