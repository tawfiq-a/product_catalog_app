import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../products/widgets/product_card.dart';
import '../controller/favorites_controller.dart';

class FavoriteScreen extends HookConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final favoriteProducts = ref.watch(favoritesProvider);

    final crossAxisCount = Responsive.gridCrossAxisCount(context);
    final childAspectRatio = Responsive.gridChildAspectRatio(context);
    final hPadding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_outline_rounded,
                      size: Responsive.value(
                        context,
                        mobile: 64.0,
                        tablet: 80.0,
                      ),
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No favorites yet',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the heart icon on any product to save it here.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ProductCard(
                  heroTag: 'favorite_product_image_${product.id}',
                  product: product,
                );
              },
            ),
    );
  }
}
