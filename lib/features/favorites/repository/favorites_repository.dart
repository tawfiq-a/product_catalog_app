import '../../../core/storage/hive_service.dart';
import '../../../models/product_model.dart';

class FavoritesRepository {
  final HiveService _hiveService = HiveService();

  List<ProductModel> getFavoriteProducts() {
    return _hiveService.getFavoriteProducts();
  }

  Future<void> saveFavoriteProduct(ProductModel product) async {
    await _hiveService.saveFavoriteProduct(product);
  }

  Future<void> removeFavoriteProduct(int id) async {
    await _hiveService.removeFavoriteProduct(id);
  }

  Future<void> clearFavorites() async {
    await _hiveService.clearFavorites();
  }
}
