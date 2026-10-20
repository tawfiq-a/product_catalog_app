import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class RatingRow extends StatelessWidget {
  final double rate;
  final int count;
  final bool isDark;

  const RatingRow({
    super.key,
    required this.rate,
    required this.count,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: AppColors.starGold, size: 22),
        const SizedBox(width: 4),
        Text(
          rate.toString(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($count reviews)',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}
