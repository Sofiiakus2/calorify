
import 'package:calorify/core/entities/my_product.dart';

///product for meal
class ProductForMealModel extends MyProduct{
  ///Constructor
  ProductForMealModel({
    required super.name,
    required super.barcode,
    required super.energyKcal_100g,
    required super.protein_100g,
    required super.fat_100g,
    required super.carbohydrates_100g,

    required super.brand,
    required super.carbohydrates_saved,
    required super.energyKcal_saved,
    required super.energyKj_100g,
    required super.energyKj_saved,
    required super.fat_saved,
    required super.protein_saved,
    required super.sugar_100g,
    required super.sugar_saved,
  });

  ///Converter from Entity to Model
  factory ProductForMealModel.fromEntity(MyProduct entity){
    return ProductForMealModel(
      name: entity.name,
      barcode: entity.barcode,
      energyKcal_100g: entity.energyKcal_100g,
      protein_100g: entity.protein_100g,
      fat_100g: entity.fat_100g,
      carbohydrates_100g: entity.carbohydrates_100g,

      brand: entity.brand,
      carbohydrates_saved: entity.carbohydrates_saved,
      energyKcal_saved: entity.energyKcal_saved,
      energyKj_100g: entity.energyKj_100g,
      energyKj_saved: entity.energyKj_saved,
      fat_saved: entity.fat_saved,
      protein_saved: entity.protein_saved,
      sugar_100g: entity.sugar_100g,
      sugar_saved: entity.sugar_saved,
    );
  }

  ///method for converting from map to product model for meal
  factory ProductForMealModel.fromMap(Map<String, dynamic> map) {
    return ProductForMealModel(
      name: map['name'] as String,
      barcode: map['barcode'] as String,
      energyKcal_100g: map['energy_100g'] as double,
      protein_100g: map['protein_100g'] as double,
      fat_100g: map['fat_100g'] as double,
      carbohydrates_100g: ['carbohydrates_100g'] as double,
      brand: map['brand'] as String,
      carbohydrates_saved: map['carbohydrates_saved'] as double,
      energyKcal_saved: map['energyKcal_saved'] as double,
      energyKj_100g: map['energyKj_100g'] as double,
      energyKj_saved: map['energyKj_saved'] as double,
      fat_saved: map['fat_saved'] as double,
      protein_saved: map['protein_saved'] as double,
      sugar_100g: map['sugar_100g'] as double,
      sugar_saved: map['sugar_saved'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'barcode': barcode,
      'energyKcal_100g': energyKcal_100g,
      'protein_100g': protein_100g,
      'fat_100g': fat_100g,
      'carbohydrates_100g': carbohydrates_100g,

      'brand':brand,
      'carbohydrates_saved':carbohydrates_saved,
      'energyKcal_saved':energyKcal_saved,
      'energyKj_100g': energyKj_100g,
      'energyKj_saved': energyKj_saved,
      'fat_saved':fat_saved,
      'protein_saved': protein_saved,
      'sugar_100g':sugar_100g,
      'sugar_saved': sugar_saved,

    };
  }

}
