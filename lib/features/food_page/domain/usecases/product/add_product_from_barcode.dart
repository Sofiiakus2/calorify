import 'package:calorify/features/food_page/domain/repositories/product_repository.dart';

///use case
class AddProductFromBarcode {
  final ProductRepository productRepository;

  ///Constructor
  AddProductFromBarcode({required this.productRepository});

  Future<void> call(String barcode) async {
    try {
      final product = await productRepository.getProductByBarcode(barcode);
      await productRepository.saveProductToHistory(product);
    } catch (e) {
      throw Exception('Error adding product from barcode: $e');
    }
  }
}
