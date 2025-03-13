class ProductModel{
  String name;
  String barcode;
  String? brand;
  double energyKcal_100g;
  double? energyKj_100g;
  double? sugar_100g;
  double protein_100g;
  double fat_100g;
  double carbohydrates_100g;

  double? energyKcal_saved;
  double? energyKj_saved;
  double? sugar_saved;
  double? protein_saved;
  double? fat_saved;
  double? carbohydrates_saved;

  ProductModel({
   required this.name,
   required this.barcode,
   this.brand,
   required this.energyKcal_100g,
   this.energyKj_100g,
   this.sugar_100g,
   required this.protein_100g,
   required this. fat_100g,
   required this.carbohydrates_100g ,
   this.energyKcal_saved,
   this.energyKj_saved,
   this.sugar_saved,
   this.protein_saved,
   this.fat_saved,
   this.carbohydrates_saved,
});
}