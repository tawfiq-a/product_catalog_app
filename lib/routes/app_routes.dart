import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/favorites/views/favorite_screen.dart';
import '../features/navigation/views/navigation_screen.dart';
import '../features/products/views/product_details_screen.dart';
import '../features/products/views/product_list_screen.dart';
import '../features/settings/views/settings_screen.dart';
import '../models/product_model.dart';

class AppRoutes {
  AppRoutes._();

  // Route Paths
  static const String productsPath = '/products';
  static const String favoritesPath = '/favorites';
  static const String settingsPath = '/settings';
  static const String productDetailsPath = '/product-details';

  // Route Names
  static const String productsName = 'products';
  static const String favoritesName = 'favorites';
  static const String settingsName = 'settings';
  static const String productDetailsName = 'productDetails';

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: productsPath,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationScreen(navigationShell: navigationShell);
        },
        branches: [
          //--------- Products Tab ----------//
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: productsPath,
                name: productsName,
                builder: (context, state) => const ProductListScreen(),
              ),
            ],
          ),
          //--------- Favorites Tab ----------//
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: favoritesPath,
                name: favoritesName,
                builder: (context, state) => const FavoriteScreen(),
              ),
            ],
          ),

          //--------- Settings Tab ----------//
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: settingsPath,
                name: settingsName,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: productDetailsPath,
        name: productDetailsName,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final product = extra['product'] as ProductModel;
          final heroTag = extra['heroTag'] as String;
          return ProductDetailsScreen(product: product, heroTag: heroTag);
        },
      ),
    ],
  );
}
