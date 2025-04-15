///Product Entity
class MyProduct{
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

  ///Constructor
  MyProduct({
    required this.name,
    required this.barcode,
    this.brand,
    required this.energyKcal_100g,
    this.energyKj_100g,
    this.sugar_100g,
    required this.protein_100g,
    required this.fat_100g,
    required this.carbohydrates_100g,
    this.energyKcal_saved,
    this.energyKj_saved,
    this.sugar_saved,
    this.protein_saved,
    this.fat_saved,
    this.carbohydrates_saved,
  });

  ///Copy with method
  MyProduct copyWith({
    String? name,
    String? barcode,
    String? brand,
    double? energyKcal_100g,
    double? energyKj_100g,
    double? sugar_100g,
    double? protein_100g,
    double? fat_100g,
    double? carbohydrates_100g,
  }) {
    return MyProduct(
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      brand: brand ?? this.brand,
      energyKcal_100g: energyKcal_100g ?? this.energyKcal_100g,
      energyKj_100g: energyKj_100g ?? this.energyKj_100g,
      sugar_100g: sugar_100g ?? this.sugar_100g,
      protein_100g: protein_100g ?? this.protein_100g,
      fat_100g: fat_100g ?? this.fat_100g,
      carbohydrates_100g: carbohydrates_100g ?? this.carbohydrates_100g,
    );
  }
}
