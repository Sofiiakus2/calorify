
import 'package:calorify/core/entities/my_product.dart';

/// A model class that represents a product, extending from the `Product` entity
class ProductModel extends MyProduct{

  ///Constructor
  ProductModel({
    required super.name,
    required super.barcode,
    required super.energyKcal_100g,
    required super.protein_100g,
    required super.fat_100g,
    required super.carbohydrates_100g,

    // super.brand,
    // super.carbohydrates_saved,
    // super.energyKcal_saved,
    // super.energyKj_100g,
    // super.energyKj_saved,
    // super.fat_saved,
    // super.protein_saved,
    // super.sugar_100g,
    // super.sugar_saved,
  });

  ///Converter from Entity to Model
  factory ProductModel.fromEntity(MyProduct entity){
    return ProductModel(
        name: entity.name,
        barcode: entity.barcode,
        energyKcal_100g: entity.energyKcal_100g,
        protein_100g: entity.protein_100g,
        fat_100g: entity.fat_100g,
        carbohydrates_100g: entity.carbohydrates_100g,

        // brand: entity.brand,
        // carbohydrates_saved: entity.carbohydrates_saved,
        // energyKcal_saved: entity.energyKcal_saved,
        // energyKj_100g: entity.energyKj_100g,
        // energyKj_saved: entity.energyKj_saved,
        // fat_saved: entity.fat_saved,
        // protein_saved: entity.protein_saved,
        // sugar_100g: entity.sugar_100g,
        // sugar_saved: entity.sugar_saved,
    );
  }
}
