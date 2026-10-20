import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/product_model.dart';
import 'category_badge.dart';
import 'rating_row.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  final bool isDark;
  final double contentPadding;

  const ProductDetails({
    super.key,
    required this.product,
    required this.isDark,
    required this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: CategoryBadge(category: product.category)),

            const SizedBox(width: 12),

            RatingRow(
              rate: product.rating.rate,
              count: product.rating.count,
              isDark: isDark,
            ),
          ],
        ),
        const SizedBox(height: 20),

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
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
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
    );
  }
}
