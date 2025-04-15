import 'package:calorify/core/entities/my_product.dart';
import 'package:calorify/features/food_page/data/datasources/local/product_local_data_source.dart';
import 'package:hive/hive.dart';

///local data source implementation
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static const String historyBoxName = 'historyBox';

  @override
  Future<void> saveProductToHistory(MyProduct product) async {
    final box = Hive.box<MyProduct>(historyBoxName);

    int? duplicateIndex;
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)?.barcode == product.barcode) {
        duplicateIndex = i;
        break;
      }
    }

    if (duplicateIndex != null) {
      final existing = box.getAt(duplicateIndex)!;
      await box.deleteAt(duplicateIndex);
      await box.add(existing);
    } else {
      await box.add(product);
      if (box.length > 20) {
        await box.deleteAt(0);
      }
    }
  }

  @override
  Future<List<MyProduct>> getProductsFromHistory() async {
    final box = Hive.box<MyProduct>(historyBoxName);
    return box.values.toList();
  }
}
