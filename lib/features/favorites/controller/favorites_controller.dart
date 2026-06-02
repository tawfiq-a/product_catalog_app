import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/product_model.dart';
import '../repository/favorites_repository.dart';

class FavoritesNotifier extends Notifier<List<ProductModel>> {
  final _repository = FavoritesRepository();

  @override
  List<ProductModel> build() {
    return _repository.getFavoriteProducts();
  }

  void toggleFavorite(ProductModel product) {
    final list = [...state];
    final index = list.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      list.removeAt(index);
      _repository.removeFavoriteProduct(product.id);
    } else {
      list.add(product);
      _repository.saveFavoriteProduct(product);
    }
    state = list;
  }

  bool isFavorite(int id) {
    return state.any((p) => p.id == id);
  }
}

final favoritesProvider =
    NotifierProvider<FavoritesNotifier, List<ProductModel>>(
      FavoritesNotifier.new,
    );
