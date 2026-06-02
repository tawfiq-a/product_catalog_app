import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/storage/hive_service.dart';
import '../../../models/product_model.dart';

class FavoritesNotifier extends Notifier<List<ProductModel>> {
  final _hiveService = HiveService();

  @override
  List<ProductModel> build() {
    return _hiveService.getFavoriteProducts();
  }

  void toggleFavorite(ProductModel product) {
    final list = [...state];
    final index = list.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      list.removeAt(index);
      _hiveService.removeFavoriteProduct(product.id);
    } else {
      list.add(product);
      _hiveService.saveFavoriteProduct(product);
    }
    state = list;
  }

  bool isFavorite(int id) {
    return state.any((p) => p.id == id);
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<ProductModel>>(
  FavoritesNotifier.new,
);
