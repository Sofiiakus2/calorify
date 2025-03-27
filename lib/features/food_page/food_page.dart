import 'package:calorify/data/models/product_model.dart';
import 'package:calorify/features/shared_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api_service.dart';
import '../../state_management/meal/food/food_block.dart';
import '../../state_management/meal/food/food_event.dart';
import 'barcode/barcode_scanning_page.dart';
import 'food_tab/food_tab.dart';
import 'list/list_food_view.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Знайти продукт',
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

                  )
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.settings_overscan, color: Colors.white),
                    onPressed: () async{
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BarcodeScanningPage()),
                      );
                      if (result != null && result != '-1') {
                        try {
                          ProductModel product = await OpenFoodFactsApiClass().getProductByBarcode(result).first; // або .last
                          context.read<FoodSearchBloc>().add(AddProductFromBarcode(product));

                        } catch (error) {
                          print('Error getting product: $error');
                          // ... обробка помилок ...
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
              children: [
                ListFoodView(),
                Text('data'),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
