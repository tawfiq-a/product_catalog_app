import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';

class NavigationScreen extends HookConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final useRail = Responsive.useNavigationRail(context);

    if (useRail) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              extended: Responsive.isDesktop(context),
              backgroundColor: theme.colorScheme.surface,
              indicatorColor: theme.colorScheme.primaryContainer,
              labelType: Responsive.isDesktop(context)
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.selected,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Icon(
                  Icons.store_rounded,
                  size: 32,
                  color: theme.colorScheme.primary,
                ),
              ),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  selectedIcon: Icon(
                    Icons.shopping_bag,
                    color: theme.colorScheme.inversePrimary,
                  ),
                  label: const Text('Products'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.favorite_border,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  selectedIcon: Icon(
                    Icons.favorite,
                    color: theme.colorScheme.inversePrimary,
                  ),
                  label: const Text('Favorites'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  selectedIcon: Icon(
                    Icons.settings,
                    color: theme.colorScheme.inversePrimary,
                  ),
                  label: const Text('Settings'),
                ),
              ],
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          backgroundColor: theme.colorScheme.surface,
          indicatorColor: theme.colorScheme.primaryContainer,
          elevation: 0,
          height: 68,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.shopping_bag_outlined,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              selectedIcon: Icon(
                Icons.shopping_bag,
                color: theme.colorScheme.inversePrimary,
              ),
              label: 'Products',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.favorite_border,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              selectedIcon: Icon(
                Icons.favorite,
                color: theme.colorScheme.inversePrimary,
              ),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              selectedIcon: Icon(
                Icons.settings,
                color: theme.colorScheme.inversePrimary,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
