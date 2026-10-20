import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../storage/hive_service.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  final _hiveService = HiveService();

  @override
  ThemeMode build() {
    final isDark = _hiveService.isDarkMode();
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      _hiveService.saveThemeMode(false);
    } else {
      state = ThemeMode.dark;
      _hiveService.saveThemeMode(true);
    }
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    _hiveService.saveThemeMode(mode == ThemeMode.dark);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
