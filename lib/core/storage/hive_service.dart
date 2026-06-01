import 'package:hive_flutter/hive_flutter.dart';

import 'hive_boxes.dart';

class HiveService {
  static const String favoriteKey = 'favorite_ids';

  Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(HiveBoxes.favoritesBox);
  }

  Box get _favoriteBox => Hive.box(HiveBoxes.favoritesBox);

  Future<void> saveFavorites(List<int> favoriteIds) async {
    await _favoriteBox.put(favoriteKey, favoriteIds);
  }

  List<int> getFavorites() {
    final data = _favoriteBox.get(favoriteKey, defaultValue: <int>[]);

    return List<int>.from(data);
  }

  Future<void> clearFavorites() async {
    await _favoriteBox.delete(favoriteKey);
  }
}
