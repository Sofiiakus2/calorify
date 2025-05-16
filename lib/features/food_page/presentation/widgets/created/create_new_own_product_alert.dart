import 'package:calorify/core/injection_container.dart';
import 'package:calorify/core/theme.dart';
import 'package:calorify/features/food_page/domain/entity/own_product.dart';
import 'package:calorify/features/food_page/domain/usecases/created_products/save_product_to_food_fact.dart';
import 'package:calorify/features/home/presentation/widgets/analitik_tab/sport/creating_new_sport/tooltip_icon.dart';
import 'package:calorify/shared/presentation/widgets/shared_text_field.dart';
import 'package:flutter/material.dart';

class CreateNewOwnProductAlert extends StatefulWidget {
  const CreateNewOwnProductAlert({super.key});

  @override
  State<CreateNewOwnProductAlert> createState() => _CreateNewOwnProductAlertState();
}

class _CreateNewOwnProductAlertState extends State<CreateNewOwnProductAlert> {
  final Map<String, TextEditingController> _controllers = {
    'Штрих код': TextEditingController(),
    'Назва': TextEditingController(),
    'Бренд': TextEditingController(),
    'Кількість': TextEditingController(),
    'Індігрієнти': TextEditingController(),
    'Калорії': TextEditingController(),
    'Білки': TextEditingController(),
    'Жири': TextEditingController(),
    'Вуглеводи': TextEditingController(),
  };

  final Map<String, String?> _tooltips = {
    'Кількість': 'Загальна вага',
    'Індігрієнти': 'Опишіть склад',
    'Калорії': 'На 100 грам',
    'Білки': 'На 100 грам',
    'Жири': 'На 100 грам',
    'Вуглеводи': 'На 100 грам',
  };

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onSave() async {
    final OwnProduct productInput = OwnProduct(
      code: _controllers['Штрих код']!.text,
      productName: _controllers['Назва']!.text,
      brands: _controllers['Бренд']!.text,
      quantity: _controllers['Кількість']!.text,
      ingredientsText: _controllers['Індігрієнти']!.text,
      nutritionDataPer: '100g',
      energyKcal: _controllers['Калорії']!.text,
      fat: _controllers['Жири']!.text,
      proteins: _controllers['Білки']!.text,
      carbohydrates: _controllers['Вуглеводи']!.text,
    );

    try {
      final useCase = sl<SaveProductToFoodFact>();
      await useCase.call(productInput);
      Navigator.of(context).pop();
    } catch (e) {
      print('❌ Помилка при збереженні продукту: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не вдалося зберегти продукт: $e')),
      );
    }
  }


  // ignore: member_ordering
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          backgroundColor: alertBackgroundColor,
          title: Text('Введіть дані про продукти', style: Theme.of(context).textTheme.bodyMedium),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Обов\'язкові поля', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 10),
                ..._controllers.entries.map((entry) {
                  final tooltip = _tooltips[entry.key];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: SharedTextField(
                            hintText: entry.key,
                            controller: entry.value,
                            icon: null,
                            isError: false,
                          ),
                        ),
                        if (tooltip != null) ...[
                          const SizedBox(width: 5),
                          TooltipIcon(text: tooltip),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: appMainGrey,
                side: const BorderSide(color: Colors.black, width: 1),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: _onSave,
              child: Text('Зберегти', style: Theme.of(context).textTheme.titleSmall),
            ),
          ],
        ),
        Positioned(
          right: 30,
          top: 70,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const CircleAvatar(
              backgroundColor: green,
              child: Icon(Icons.close, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
