import 'package:calorify/data/models/product_model.dart';
import 'package:hive/hive.dart';

///Cache
class HiveHistoryService{
  static const String _historyBoxName = 'historyBox';

  ///saving product to history
  Future<void> saveProductToHistory (ProductModel product) async{
    var historyBox = Hive.box<ProductModel>(_historyBoxName);

    int? duplicateIndex;
    for (int i = 0; i < historyBox.length; i++) {
      if (historyBox.getAt(i)!.barcode == product.barcode) {
        duplicateIndex = i;
        break;
      }
    }

    if (duplicateIndex != null) {
      var duplicateProduct = historyBox.getAt(duplicateIndex)!;
      historyBox.deleteAt(duplicateIndex);

      historyBox.add(duplicateProduct);
    } else {
      historyBox.add(product);

      if (historyBox.length > 20) {
        historyBox.deleteAt(0);
      }
    }
  }

  List<ProductModel> getHistory(){
    var historyBox = Hive.box<ProductModel>(_historyBoxName);
    return historyBox.values.toList();
  }
}