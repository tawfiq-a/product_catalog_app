// Put common extensions here
import 'package:flutter/material.dart';

extension StringExtensions on String {
  bool get isNullOrEmpty => isEmpty;
}
extension PriceExtension on double {
  String get toPrice => '\$${toStringAsFixed(2)}';
}
extension StringExtension on String {
  String get capitalize {
    if (isEmpty) return this;

    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}
