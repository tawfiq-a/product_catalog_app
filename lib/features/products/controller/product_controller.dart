import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/product_model.dart';
import '../repository/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return await repository.fetchProducts();
});

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

class SearchActiveNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setActive(bool active) {
    state = active;
  }
}

final searchActiveProvider = NotifierProvider<SearchActiveNotifier, bool>(
  SearchActiveNotifier.new,
);
