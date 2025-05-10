import 'package:calorify/core/entities/my_product.dart';
import 'package:hive/hive.dart';

class MyProductAdapter extends TypeAdapter<MyProduct> {
  @override
  final int typeId = 1;

  @override
  MyProduct read(BinaryReader reader) {
    return MyProduct(
      name: reader.readString(),
      barcode: reader.readString(),
      energyKcal_100g: reader.readDouble(),
      sugar_100g: reader.readDouble(),
      protein_100g: reader.readDouble(),
      fat_100g: reader.readDouble(),
      carbohydrates_100g: reader.readDouble(),
      brand: reader.readString(),
      energyKj_100g: reader.readDouble(),
      energyKcal_saved: reader.readDouble(),
      energyKj_saved: reader.readDouble(),
      sugar_saved: reader.readDouble(),
      protein_saved: reader.readDouble(),
      fat_saved: reader.readDouble(),
      carbohydrates_saved: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, MyProduct obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.barcode);
    writer.writeDouble(obj.energyKcal_100g);
    writer.writeDouble(obj.sugar_100g ?? 0.0);
    writer.writeDouble(obj.protein_100g);
    writer.writeDouble(obj.fat_100g);
    writer.writeDouble(obj.carbohydrates_100g);
    writer.writeString(obj.brand ?? "");
    writer.writeDouble(obj.energyKj_100g ?? 0.0);
    writer.writeDouble(obj.energyKcal_saved ?? 0.0);
    writer.writeDouble(obj.energyKj_saved ?? 0.0);
    writer.writeDouble(obj.sugar_saved ?? 0.0);
    writer.writeDouble(obj.protein_saved ?? 0.0);
    writer.writeDouble(obj.fat_saved ?? 0.0);
    writer.writeDouble(obj.carbohydrates_saved ?? 0.0);
  }
}
