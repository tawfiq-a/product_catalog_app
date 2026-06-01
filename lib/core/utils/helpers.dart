import 'package:flutter/material.dart';

class Helpers {
  static String formatRating(double rating) {
    return rating.toStringAsFixed(1);
  }

  static bool containsIgnoreCase(String source, String query) {
    return source.toLowerCase().contains(query.toLowerCase());
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
