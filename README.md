# product_catalog_app

A Flutter product catalog application used to browse products and manage favorites.

## Project Setup

- Prerequisites: Flutter (stable), Git, Android SDK (or Xcode for iOS).
- Clone and install:

```bash
git clone <repo-url>
cd product_catalog_app
flutter pub get
```

- Run debug build:

```bash
flutter run
```

- Build release APK:

```bash
flutter build apk --release
```

## Key Files

- App entry: [lib/main.dart](lib/main.dart)
- Routing: [lib/routes/app_routes.dart](lib/routes/app_routes.dart)
- Favorites repository: [lib/features/favorites/repository/favorites_repository.dart](lib/features/favorites/repository/favorites_repository.dart)
- Favorites notifier: [lib/features/favorites/controller/favorites_controller.dart](lib/features/favorites/controller/favorites_controller.dart)
- Hive persistence: [lib/core/storage/hive_service.dart](lib/core/storage/hive_service.dart)
- Theme provider: [lib/core/theme/theme_provider.dart](lib/core/theme/theme_provider.dart)
- CI workflow: [.github/workflows/flutter_ci.yml](.github/workflows/flutter_ci.yml)

## Architecture

- Feature-based layout under `lib/features/` (each feature contains `views`, `widgets`, `controller`, `repository` where applicable).
- Core utilities in `lib/core/` (theme, storage, constants, network wrapper).
- Models under `lib/models/` (e.g., `ProductModel`).
- Follows a simple Repository pattern for persistence (`FavoritesRepository`) so UI/state code doesn't directly depend on Hive.

## State Management

- Uses Riverpod (`hooks_riverpod`) with `NotifierProvider` for mutable application state.
	- Example: `favoritesProvider` (`NotifierProvider`) in [lib/features/favorites/controller/favorites_controller.dart](lib/features/favorites/controller/favorites_controller.dart).
	- Theme is managed by `ThemeNotifier` in [lib/core/theme/theme_provider.dart](lib/core/theme/theme_provider.dart) and persisted via Hive.

## Persistence

- Uses `hive` / `hive_flutter` for local storage. Box names and helpers are in [lib/core/storage/hive_service.dart](lib/core/storage/hive_service.dart).

## Third-party Packages

- `hive`, `hive_flutter` — local persistence
- `hooks_riverpod`, `flutter_hooks` — state + hooks
- `cached_network_image` — remote image caching
- `go_router` — navigation
- `dio` — HTTP client
- `skeletonizer` — loading placeholders

(See full dependencies in `pubspec.yaml`.)

## CI / Release Flow

- GitHub Actions workflow at `.github/workflows/flutter_ci.yml` runs `flutter analyze`, builds an APK, uploads it as an artifact, and creates a GitHub Release when a tag is pushed or when `main`/`master` receives a push.
- To trigger a release manually:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Automatic releases are also created for pushes to `main`/`master` per the workflow configuration.

## Notes & Next Steps

- If you want the README in Bangla (Bengali) or additional sections (contributing, tests, architecture diagrams), tell me which to add.

