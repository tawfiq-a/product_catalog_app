import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  const FavoriteButton({super.key, this.isFavorite = false});

  @override
  Widget build(BuildContext context) =>
      Icon(isFavorite ? Icons.favorite : Icons.favorite_border);
}
