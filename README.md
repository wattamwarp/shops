# Shopsy Product Menu

A scalable, modular Flutter application for a product menu and cart, using BLoC, repository pattern, dependency injection, and local SQLite persistence.

## APK Download

**The latest APK build is included in this repository for your convenience.**
- You can find the APK file in the root of the project.
- Download and install it directly on your Android device to try the app without building from source.
- https://drive.google.com/file/d/1crQ2zhgH8hZVlJRfdPm3Fzh0AX2VsqGx/view?usp=sharing

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
apk/                   # Prebuilt APK for direct install
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

## Project Q&A

### How did you approach the task?
- I started by designing a scalable, modular architecture using Clean Architecture principles, ensuring clear separation between data, domain, and presentation layers.
- I enforced the use of custom widgets and extensions for all UI elements to guarantee consistency and easy theming.
- I implemented BLoC for robust state management and used dependency injection (get_it) for loose coupling and testability.
- Features like pagination, pull-to-refresh, and persistent cart were prioritized for a modern, user-friendly experience.

### What packages did you choose and why?
- **flutter_bloc**: For predictable, testable state management using the BLoC pattern.
- **get_it**: For dependency injection, making the codebase modular and easy to test.
- **sqflite**: For local SQLite database support, enabling persistent cart storage.
- **path**: For safe file path handling with SQLite.
- **cached_network_image**: For efficient, cached image loading from the network.
- **mockito, bloc_test**: For unit testing BLoC and repository logic.

### What architectural decisions did you make?
- **Clean Architecture**: Strict separation of concerns between data, domain, and presentation.
- **Repository Pattern**: All data access is abstracted, making it easy to swap data sources or mock them in tests.
- **BLoC Everywhere**: All business logic and UI state is managed via BLoC, ensuring a single source of truth and easy debugging.
- **Custom Widgets/Extensions**: All UI uses custom components for maintainability and a unified look.
- **Centralized Constants**: Colors, paths, and routes are managed in dedicated files for consistency.
- **Dependency Injection**: All services and repositories are injected, not hardcoded, for flexibility and testability.

### What tradeoffs did you face?
- **Complexity vs. Simplicity**: Clean Architecture and BLoC add boilerplate and learning curve, but greatly improve maintainability and scalability for larger projects.
- **Performance vs. Flexibility**: Using BLoC and dependency injection can add minor overhead, but the benefits in testability and modularity outweigh the cost for most apps.
- **Custom Widgets vs. Stock Widgets**: Enforcing custom widgets everywhere increases initial development time, but ensures a consistent and easily updatable UI.
- **Local JSON for Products**: Using a local JSON file for products is simple and fast for demo/testing, but would need to be replaced with a remote API for production scalability.

## Getting Started
1. Install Flutter and dependencies:
   ```sh
   flutter pub get
   ```
2. Run the app:
   ```sh
   flutter run
   ```
   
## Customization
- Add products to `lib/features/data/datasources/products.json`.
- Update colors in `lib/utils/constants/app_colors.dart`.
- Add new features by following the modular BLoC and repository structure.

## License
MIT
