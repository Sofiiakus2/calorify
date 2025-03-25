import 'package:calorify/data/models/product_model.dart';
import 'package:hive/hive.dart';

class HistoryService{
  static const String _historyBoxName = 'historyBox';

  Future<void> saveProductToHistory (ProductModel product) async{
    var historyBox = Hive.box<ProductModel>(_historyBoxName);
    historyBox.add(product);
    if(historyBox.length > 20){
      historyBox.deleteAt(0);
    }
  }

  List<ProductModel> getHistory(){
    var historyBox = Hive.box<ProductModel>(_historyBoxName);
    return historyBox.values.toList();
  }
}