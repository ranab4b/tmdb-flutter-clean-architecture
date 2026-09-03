# 🎬 TMDB Movie Explorer (Flutter Clean Architecture)

A modern, production-grade Flutter application built adhering strictly to **Clean Architecture**, **SOLID Principles**, and the **BLoC Pattern**.

---

## 🌟 Key Features
- **Clean Architecture & SOLID Design:** Strictly separated Data, Domain, and Presentation layers.
- **Infinite Scroll Pagination:** Automated page fetching when nearing list bottom.
- **Debounced Movie Search:** Real-time search against TMDB Search API.
- **Initial Custom Launcher State:** Displaying *"Preparing the experience for you hold on with us"* during initialization.
- **Dynamic Genre Mapping:** Real-time mapping of TMDB genre IDs to human-readable names.
- **Cached Image Loading:** Optimized network image fetching with placeholder fallbacks.
- **Unit Testing Suite:** BLoC and UseCase tests via `mocktail`.

---

## 🏗️ Clean Architecture Overview

```
                          +-----------------------------------+
                          |        Presentation Layer         |
                          |   (UI, BLoC, State, Widgets)      |
                          +-----------------+-----------------+
                                            |
                                            v
                          +-----------------+-----------------+
                          |           Domain Layer            |
                          | (Entities, Use Cases, Contracts)  |
                          +-----------------+-----------------+
                                            ^
                                            |
                          +-----------------+-----------------+
                          |            Data Layer             |
                          | (Models, DataSources, Repos)      |
                          +-----------------------------------+
```

---

## 🛠️ Tech Stack & Dependencies

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  http: ^1.2.0
  get_it: ^7.6.0
  cached_network_image: ^3.3.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.3
```

---

## 🚀 Getting Started

1. **Extract Zip Contents** into your project root.
2. Update dependencies using `flutter pub get`.
3. Add your TMDB API Key in `lib/core/constants/api_constants.dart`:
   ```dart
   static const String apiKey = 'YOUR_TMDB_API_KEY_HERE';
   ```
4. Run the app:
   ```bash
   flutter run
   ```
5. Run unit tests:
   ```bash
   flutter test
   ```
