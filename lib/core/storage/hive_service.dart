import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/product_model.dart';
import 'hive_boxes.dart';

class HiveService {
  static const String themeKey = 'is_dark_mode';

  Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(HiveBoxes.favoritesBox);
    await Hive.openBox(HiveBoxes.settingsBox);
  }

  Box get _favoriteBox => Hive.box(HiveBoxes.favoritesBox);
  Box get _settingsBox => Hive.box(HiveBoxes.settingsBox);

  Future<void> saveFavoriteProduct(ProductModel product) async {
    await _favoriteBox.put(product.id, jsonEncode(product.toJson()));
  }

  Future<void> removeFavoriteProduct(int productId) async {
    await _favoriteBox.delete(productId);
  }

  List<ProductModel> getFavoriteProducts() {
    final List<ProductModel> favoriteProducts = [];
    for (final key in _favoriteBox.keys) {
      final value = _favoriteBox.get(key);
      if (value is String) {
        try {
          final decoded = jsonDecode(value) as Map<String, dynamic>;
          favoriteProducts.add(ProductModel.fromJson(decoded));
        } catch (_) {}
      }
    }
    return favoriteProducts;
  }

  Future<void> clearFavorites() async {
    await _favoriteBox.clear();
  }

  Future<void> saveThemeMode(bool isDarkMode) async {
    await _settingsBox.put(themeKey, isDarkMode);
  }

  bool isDarkMode() {
    return _settingsBox.get(themeKey, defaultValue: false);
  }
}
