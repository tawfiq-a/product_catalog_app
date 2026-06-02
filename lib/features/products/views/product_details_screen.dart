import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:product_catalog_app/features/products/widgets/product_details.dart';
import 'package:product_catalog_app/features/products/widgets/product_details_bottom_nav.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
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

    final contentPadding = Responsive.contentPadding(context);
    final maxContentWidth = Responsive.maxContentWidth(context);
    final imageHeightFraction = Responsive.detailsImageHeightFraction(context);
    final isWide =
        Responsive.isTablet(context) || Responsive.isDesktop(context);

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
      body: isWide
          ? _buildWideLayout(
              context: context,
              theme: theme,
              isDark: isDark,
              contentPadding: contentPadding,
              maxContentWidth: maxContentWidth,
              scrollController: scrollController,
            )
          : _buildNarrowLayout(
              context: context,
              theme: theme,
              isDark: isDark,
              contentPadding: contentPadding,
              imageHeightFraction: imageHeightFraction,
              scrollController: scrollController,
            ),
      bottomNavigationBar: ProductDetailsBottomNav(
        isDark: isDark,
        theme: theme,
        product: product,
        isFav: isFav,
      ),
    );
  }

  Widget _buildWideLayout({
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required double contentPadding,
    required double maxContentWidth,
    required ScrollController scrollController,
  }) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(contentPadding),
              decoration: BoxDecoration(
                color: isDark ? AppColors.imageBgDark : AppColors.imageBgLight,
                borderRadius: BorderRadius.circular(32),
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
              child: Padding(
                padding: const EdgeInsets.all(32.0),
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

          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.all(contentPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: ProductDetails(
                    product: product,
                    isDark: isDark,
                    contentPadding: contentPadding,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout({
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required double contentPadding,
    required double imageHeightFraction,
    required ScrollController scrollController,
  }) {
    return ListenableBuilder(
      listenable: scrollController,
      builder: (context, child) {
        final double offset = scrollController.hasClients
            ? scrollController.offset
            : 0.0;
        final double initialImageHeight =
            MediaQuery.of(context).size.height * imageHeightFraction;
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
                    padding: const EdgeInsets.fromLTRB(24.0, 56.0, 24.0, 24.0),
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
                                : AppColors.shadowLight.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(contentPadding),
                        child: ProductDetails(
                          product: product,
                          isDark: isDark,
                          contentPadding: contentPadding,
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
    );
  }
}
