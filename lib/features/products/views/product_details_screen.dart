import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_app/features/products/widgets/product_details_bottom_nav.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/product_model.dart';
import '../../favorites/controller/favorites_controller.dart';

class ProductDetailsScreen extends HookConsumerWidget {
  final ProductModel product;
  final String heroTag;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final favorites = ref.watch(favoritesProvider);
    final isFav = favorites.any((p) => p.id == product.id);

    final scrollController = useScrollController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: CircleAvatar(
            backgroundColor: isDark
                ? AppColors.cardDark.withValues(alpha: 0.9)
                : AppColors.cardLight.withValues(alpha: 0.9),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
                size: 18,
              ),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: scrollController,
        builder: (context, child) {
          final double offset = scrollController.hasClients
              ? scrollController.offset
              : 0.0;
          final double initialImageHeight =
              MediaQuery.of(context).size.height * 0.45;
          double imageHeight = initialImageHeight;
          double imageTranslation = 0.0;

          if (offset < 0) {
            imageHeight = initialImageHeight - offset;
          } else {
            imageTranslation = -offset * 0.35;
          }

          return Stack(
            children: [
              Positioned(
                top: imageTranslation,
                left: 0,
                right: 0,
                height: imageHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.imageBgDark
                        : AppColors.imageBgLight,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? AppColors.shadowDark.withValues(alpha: 0.2)
                            : AppColors.shadowLight.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        24.0,
                        56.0,
                        24.0,
                        24.0,
                      ),
                      // --------- Product Image ----------//
                      child: Hero(
                        tag: heroTag,
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.primary,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.broken_image_outlined,
                            color: theme.colorScheme.error,
                            size: 80,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned.fill(
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: initialImageHeight - 24),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark
                                  ? AppColors.shadowDark.withValues(alpha: 0.1)
                                  : AppColors.shadowLight.withValues(
                                      alpha: 0.05,
                                    ),
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // ---------- Category ----------//
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      product.category.toUpperCase(),
                                      style: theme.textTheme.labelMedium
                                          ?.copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.1,
                                          ),
                                    ),
                                  ),

                                  // ---------- Rating ----------//
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: AppColors.starGold,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        product.rating.rate.toString(),
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: isDark
                                                  ? AppColors.textPrimaryDark
                                                  : AppColors.textPrimaryLight,
                                            ),
                                      ),
                                      const SizedBox(width: 4),

                                      Text(
                                        '(${product.rating.count} reviews)',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: isDark
                                                  ? AppColors.textSecondaryDark
                                                  : AppColors
                                                        .textSecondaryLight,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // ---------- Title ----------//
                              Text(
                                product.title,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                                  height: 1.3,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Divider(
                                color: isDark
                                    ? AppColors.borderDark
                                    : AppColors.borderLight,
                                thickness: 1.2,
                              ),
                              const SizedBox(height: 20),

                              Text(
                                'About the Product',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimaryLight,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // ---------- Description ----------//
                              Text(
                                product.description,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                  height: 1.6,
                                ),
                              ),

                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      bottomNavigationBar: ProductDetailsBottomNav(
        isDark: isDark,
        theme: theme,
        product: product,
        isFav: isFav,
      ),
    );
  }
}
