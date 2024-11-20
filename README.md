# Weather App

## Overview
The **Weather App** is a Flutter-based application that allows users to:
- Get weather updates based on their current location.
- Search for weather information in any city worldwide.
- Storing data locally to use when a network connection is unavailable.

This app provides an intuitive interface and uses a clean architecture approach for better maintainability and scalability.

---

## Features
- 🌍 **Current Location Weather**: Automatically fetch weather updates based on your GPS location.
- 🔍 **City Search**: Search and retrieve weather data for any city.
- 📊 **Efficient Data Caching**: Leveraging Hive for local data storage.
- 🎨 **Dynamic Animations**: Beautiful Lottie animations to enhance the user experience.

---

## Getting Started

### Prerequisites
Ensure you have the following installed on your system:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.x or higher)
- [Dart SDK](https://dart.dev/get-dart)

## Installation
### 1. Clone the repo
### 2.
```bash
cd weather_app
```
### 3. Installing Dependencies
To install all dependencies, run the following command via the included Makefile:
```bash
make pub_get_all
```
### 4. Run the app
```bash 
flutter run
```
## State Management & Architecture
The **Weather App** leverages:
- **Bloc**: A predictable state management solution that simplifies handling application state.
- **Clean Architecture**: The project is organized into `Data`, `Domain`, and `Presentation` layers for scalability and maintainability.
- Modularization
- Dependency Injection
- Unit Tests
- Makefile

## Technologies & Libraries

The **Weather App** utilizes the following libraries and packages:

- `flutter_modular`: Dependency injection and module management.
- `dio`: HTTP client for API requests.
- `internet_connection_checker_plus`: Check internet connectivity.
- `flutter_bloc`: State management solution.
- `equatable`: Simplifies equality comparisons.
- `rxdart`: Reactive programming.
- `cached_network_image`: Efficient image caching.
- `lottie`: Display animations.
- `dartz`: Functional programming utilities.
- `geolocator`: Access GPS location.
- `geocoding`: Convert coordinates to addresses.
- `hive`, `hive_flutter`: Lightweight local storage.
- `mockito`: Mocking for unit tests.


### Project Structure
- **Data Layer**: Handles API calls, local storage, and data models.
- **Domain Layer**: Contains business logic and use cases.
- **Presentation Layer**: Manages UI and state using Flutter widgets and Bloc.

Folder structure:
```bash
lib/
├── app_module/
├── app_widget/
└── main.dart
modules/
├── splash/
├── art_core/
├── core/
├── dependencies/
└── features/
    ├── data/
        ├── data_source/
        ├── mapper/
        ├── models/
        └── repository/
    ├── domain/
        ├── entity/
        ├── repository/
        └── use_cases/
    ├── presentation/
        ├── bloc/
        └── pages/
    ├── features.dart
    └── features_module.dart
```

## Modules
- **Core Module**: A module that provides essential functionalities such as the network handler, cache manager, and routing logic.
- **Art Core Module**:  A module that contains shared widgets, themes, and extensions used across the application.
- **Dependencies Module**: Responsible for managing and organizing third-party packages.
- **Splash Module**: A module responsible for managing the app’s initial loading screen.
- **Features Module**: A module dedicated to fetching weather data from the network, caching it locally for offline access, and providing the necessary logic and UI for displaying weather information to users.
