# Shopsy Product Menu

A scalable, modular Flutter application for a product menu and cart, using BLoC, repository pattern, dependency injection, and local SQLite persistence.

## Features
- Product listing with pagination and pull-to-refresh
- Product detail screen with add-to-cart and quantity controls
- Cart with persistent storage (SQLite)
- Clean architecture: separation of data, domain, and presentation layers
- Dependency injection using get_it
- Custom widgets and extensions for consistent UI
- Centralized color and path constants
- Robust navigation with named routes

## Project Structure
```
lib/
  core/
    db/                # AppDatabase and SQLite logic
  features/
    data/              # Data sources, repositories, models
    domain/            # Entities, repository interfaces
    presentation/      # UI, BLoC, widgets
  utils/
    constants/         # AppColors, path constants, logger
    extensions/        # Custom text, currency, etc.
    reusable_widgets/  # AppButton, AppImage, AppContainer, etc.
  di.dart              # Dependency injection setup
  main.dart            # App entry point
  app_router.dart      # Route management
```

## Approach
- **Clean Architecture**: The codebase is split into data, domain, and presentation layers for testability and maintainability.
- **BLoC Pattern**: All business logic and state management are handled using BLoC, with events and states for each feature.
- **Repository Pattern**: Data access is abstracted via repositories, allowing easy swapping of data sources (e.g., local JSON, SQLite).
- **Dependency Injection**: All dependencies are registered in `di.dart` using get_it, enabling loose coupling and easy testing.
- **Custom Widgets/Extensions**: All UI uses custom widgets (AppButton, AppImage, etc.) and extensions for text and currency, ensuring a consistent look and feel.
- **Centralized Constants**: Colors, asset paths, and route names are managed in dedicated files for easy updates and consistency.
- **Persistence**: Cart data is stored locally using SQLite for offline support and stable ordering.
- **Pagination & Refresh**: Product list supports infinite scroll and pull-to-refresh for a smooth user experience.

## Optimization & Code Quality
- **Efficient State Management**: BLoC ensures only relevant widgets rebuild, minimizing unnecessary UI updates and improving performance.
- **Lazy Dependency Loading**: Services and repositories are registered as lazy singletons, so they are only created when needed, reducing memory usage.
- **Pagination**: Products are loaded in pages, which keeps memory usage low and UI responsive even with large datasets.
- **Separation of Concerns**: Each layer (data, domain, presentation) has a single responsibility, making the codebase easy to test, debug, and extend.
- **Reusable Components**: Custom widgets and extensions reduce code duplication and enforce a consistent design system.
- **Centralized Error Handling**: All errors are surfaced through BLoC states, making it easy to display user-friendly messages and debug issues.
- **Scalable Navigation**: Named routes and a central router make it easy to add new screens and features without breaking existing flows.
- **Testability**: The architecture allows for easy unit and widget testing, as dependencies can be mocked and logic is decoupled from UI.


## Getting Started
1. Install Flutter and dependencies:
   ```sh
   flutter pub get
   ```
2. Run the app:
   ```sh
   flutter run
   ```



The project includes a sample BLoC test for the product list feature. You can add more tests for other BLoCs, repositories, and widgets following the same pattern.

## Customization
- Add products to `lib/features/data/datasources/products.json`.
- Update colors in `lib/utils/constants/app_colors.dart`.
- Add new features by following the modular BLoC and repository structure.

## License
MIT
