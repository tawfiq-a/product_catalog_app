import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/error_view.dart';
import '../../../models/product_model.dart';
import '../controller/product_controller.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends HookConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    final theme = Theme.of(context);

    final isSearching = ref.watch(searchActiveProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final searchController = useTextEditingController();

    final crossAxisCount = Responsive.gridCrossAxisCount(context);
    final childAspectRatio = Responsive.gridChildAspectRatio(context);
    final hPadding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search products by title...',
                  border: InputBorder.none,
                ),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).setQuery(value);
                },
              )
            : const Text(
                'Fake Store ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        foregroundColor: theme.colorScheme.onSurface,
        leading: isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  ref.read(searchActiveProvider.notifier).setActive(false);
                  ref.read(searchQueryProvider.notifier).clear();
                  searchController.clear();
                },
              )
            : null,
        actions: [
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () {
                ref.read(searchQueryProvider.notifier).clear();
                searchController.clear();
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {
                ref.read(searchActiveProvider.notifier).setActive(true);
              },
            ),
        ],
      ),
      body: productsAsync.when(
        loading: () => Skeletonizer(
          enabled: true,
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: crossAxisCount * 3,
            itemBuilder: (context, index) {
              return ProductCard(
                heroTag: 'list_skeleton_image_$index',
                product: ProductModel(
                  id: index,
                  title: 'Skeleton Product Title',
                  price: 99.99,
                  description:
                      'Skeleton Product Description that goes on and on.',
                  category: 'clothing',
                  image: '',
                  rating: RatingModel(rate: 4.5, count: 120),
                ),
              );
            },
          ),
        ),
        error: (error, stackTrace) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(productsProvider),
        ),
        data: (products) {
          final filteredProducts = products
              .where(
                (product) => product.title.toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
              )
              .toList();

          if (filteredProducts.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async => ref.refresh(productsProvider),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: Responsive.value(
                            context,
                            mobile: 64.0,
                            tablet: 80.0,
                          ),
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try searching for something else.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(productsProvider.future),
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(
                  heroTag: 'list_product_image_${product.id}',
                  product: product,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
