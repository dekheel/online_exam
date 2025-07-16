# Features Implementation Guide

This guide provides step-by-step implementation of core features for Flutter project initialization. Each feature includes setup instructions, code examples, and explanations based on the current project structure.

## Table of Contents
1. [Routing](#1-routing)
2. [Colors](#2-colors)
3. [Theme](#3-theme)
4. [Localization](#4-localization)
5. [Injectable (Dependency Injection)](#5-injectable-dependency-injection)
6. [Retrofit & Dio for API](#6-retrofit--dio-for-api)
7. [Shared Preferences](#7-shared-preferences)
8. [Provider](#8-provider)
9. [Splash Screen](#9-splash-screen)

---

## 1. Routing

### Dependencies Required
```yaml
dependencies:
  flutter:
    sdk: flutter
```

### Implementation Steps

#### Step 1: Create Routes Constants
```dart
// lib/core/routing/routes.dart
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  
  static Route onGenerateRoute(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? '/');
    switch (url.path) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => HomePage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        );
    }
  }
}
```

#### Step 2: Configure in MaterialApp
```dart
// lib/main.dart
MaterialApp(
  onGenerateRoute: AppRoutes.onGenerateRoute,
  initialRoute: AppRoutes.home,
)
```

### Benefits
- **Type Safety**: Prevents typos in route names
- **Centralized Management**: Single location for all routes
- **Easy Navigation**: `Navigator.pushNamed(context, AppRoutes.home)`

---

## 2. Colors

### Implementation Steps

#### Step 1: Create Color Palette
```dart
// lib/core/colors/colors.dart
import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary Colors
  static MaterialColor blue = MaterialColor(0XFF02369C, {
    10: Color(0xffccd7eb),
    20: Color(0xffabbcde),
    // ... more shades
  });
  
  // Secondary Colors
  static MaterialColor black = MaterialColor(0XFF0f0f0f, {
    10: Color(0xffcfcfcf),
    // ... more shades
  });
  
  // Accent Colors
  static Color green = const Color(0XFF11CE19);
  static Color red = const Color(0XFFCC1010);
  static Color white = const Color(0XFFFFFFFF);
}
```

### Benefits
- **Consistency**: Unified color scheme across the app
- **Easy Maintenance**: Change colors in one place
- **Material Design**: Supports Material Design 3 color system
- **Accessibility**: Proper contrast ratios with shade variations

---

## 3. Theme

### Implementation Steps

#### Step 1: Create Theme Configuration
```dart
// lib/core/theme/theme.dart
import 'package:flutter/material.dart';
import 'package:online_exam/core/colors/colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme = getTheme(
    ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.blue,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.blue,
    ),
  );
  
  static ThemeData darkTheme = getTheme(
    ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColors.blue,
      onPrimary: AppColors.white,
      // ... configure dark colors
    ),
  );

  static ThemeData getTheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
```

#### Step 2: Apply Theme in App
```dart
// lib/main.dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // Follows system preference
)
```

### Benefits
- **Consistent UI**: Unified look and feel
- **Dark Mode Support**: Automatic theme switching
- **Easy Customization**: Modify themes without touching individual widgets

---

## 4. Localization

### Dependencies Required
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: any

flutter:
  generate: true
```

### Implementation Steps

#### Step 1: Create l10n.yaml Configuration
```yaml
# l10n.yaml
arb-dir: lib/core/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
synthetic-package: false
output-dir: lib/core/l10n
```

#### Step 2: Create ARB Files
```json
// lib/core/l10n/app_en.arb
{
  "welcome": "Welcome",
  "login": "Login",
  "signup": "Sign Up",
  "email": "Email",
  "password": "Password"
}
```

```json
// lib/core/l10n/app_ar.arb
{
  "welcome": "مرحبا",
  "login": "تسجيل الدخول",
  "signup": "إنشاء حساب",
  "email": "البريد الإلكتروني",
  "password": "كلمة المرور"
}
```

#### Step 3: Configure in MaterialApp
```dart
// lib/main.dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:online_exam/core/l10n/app_localizations.dart';

MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
)
```

#### Step 4: Usage in Widgets
```dart
Text(AppLocalizations.of(context)!.welcome)
```

### Benefits
- **Multi-language Support**: Easy internationalization
- **Type Safety**: Generated code prevents typos
- **Dynamic Switching**: Change language at runtime

---

## 5. Injectable (Dependency Injection)

### Dependencies Required
```yaml
dependencies:
  injectable: ^2.4.4
  get_it: ^8.0.0

dev_dependencies:
  injectable_generator: ^2.6.2
  build_runner: ^2.4.12
```

### Implementation Steps

#### Step 1: Setup GetIt Configuration
```dart
// lib/core/di/di.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/core/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
```

#### Step 2: Create Service Modules
```dart
// lib/core/di/modules/dio_module.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @LazySingleton()
  Dio provideDio() {
    Dio dio = Dio();
    dio.options.headers = {'Content-Type': 'application/json'};
    dio.options.baseUrl = 'https://api.example.com/';
    return dio;
  }
}
```


#### Step 3: Initialize in Main
```dart
// lib/main.dart
void main() {
  configureDependencies();
  runApp(MyApp());
}
```

#### Step 4: Generate Code
```bash
dart run build_runner build / watch
```

### Benefits
- **Decoupled Architecture**: Loose coupling between components
- **Easy Testing**: Mock dependencies for unit testing
- **Singleton Management**: Automatic lifecycle management

---

## 6. Retrofit & Dio for API

### Dependencies Required
```yaml
dependencies:
  dio: ^5.7.0
  retrofit: ^4.6.0
  json_annotation: ^4.9.0

dev_dependencies:
  retrofit_generator: ^9.1.2
  json_serializable: ^6.9.5
  build_runner: ^2.4.12
```

### Implementation Steps

#### Step 1: Create API Constants
```dart
// lib/core/constants/api_constants.dart
abstract class ApiConstants {
  static const String baseUrl = 'https://exam.elevateegy.com/api/v1/';
  static const String login = 'auth/signin';
  static const String register = 'auth/signup';
}
```

## 7. Shared Preferences

### Dependencies Required
```yaml
dependencies:
  shared_preferences: ^2.3.3
```

### Implementation Steps

#### Step 1: Create Preferences Module
```dart
// lib/core/di/modules/shared_preferences_module.dart
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferencesModule {
  @preResolve
  @LazySingleton()
  Future<SharedPreferences> provideSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }
}
```

#### Step 2: Create Preferences Service
```dart
// lib/core/services/preferences_service.dart
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class PreferencesService {
  final SharedPreferences _prefs;
  
  PreferencesService(this._prefs);
    
  // App Settings
  Future<void> setLanguage(String language) async {
    await _prefs.setString('language', language);
  }
  
  String getLanguage() {
    return _prefs.getString('language') ?? 'en';
  }
  
}
```

### Benefits
- **Persistent Storage**: Data survives app restarts
- **Simple API**: Easy key-value storage
- **Cross-Platform**: Works on all Flutter platforms

---

## 8. Provider

### Dependencies Required
```yaml
dependencies:
  provider: ^6.1.2
```

### Implementation Steps

#### Step 1: Create Provider Classes
```dart
// lib/core/providers/app_config_provider.dart
import 'package:flutter/material.dart';
import 'package:online_exam/core/services/preferences_service.dart';

class AppConfigProvider extends ChangeNotifier {
  final PreferencesService _preferencesService;
  
  AppConfigProvider(this._preferencesService);
  
  Locale _locale = const Locale('en');
  Locale get locale => _locale;
  
  
  void changeLanguage(String languageCode) {
    _locale = Locale(languageCode);
    _preferencesService.setLanguage(languageCode);
    notifyListeners();
  }
  }
```

#### Step 3: Setup MultiProvider
```dart
// lib/main.dart
import 'package:provider/provider.dart';

Widget build(BuildContext context) {
  return 
      ChangeNotifierProvider(create: (_) => getIt<AppConfigProvider>()),
    
    child:  MaterialApp(
          locale: appConfig.locale,
          themeMode: appConfig.themeMode,
          // ... other configurations
        );
}
```

### Benefits
- **State Management**: Efficient state sharing across widgets
- **Reactive UI**: Automatic rebuilds when state changes
- **Separation of Concerns**: Business logic separated from UI

---

## 9. Splash Screen

### Two Approaches: Native + Flutter Native Splash Package

### Approach 1: Flutter Native Splash Package

#### Dependencies Required
```yaml
dev_dependencies:
  flutter_native_splash: ^2.4.1
```

#### Step 1: Configure in pubspec.yaml
```yaml
flutter_native_splash:
  color: "#02369C"
  image: assets/images/logo.png
  android_12:
    image: assets/images/logo.png
    color: "#02369C"
  ios: true
  android: true
  web: false
```

#### Step 2: Generate Splash Screen
```bash
dart run flutter_native_splash:create
```

#### Step 3: Create Flutter Splash Screen
```dart
// lib/features/splash/presentation/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Initialize dependencies
    await configureDependencies();
    
    // Check authentication status
    final prefsService = getIt<PreferencesService>();
    final token = prefsService.getUserToken();
    
    // Remove native splash
    FlutterNativeSplash.remove();
    
    // Navigate to appropriate screen
    if (token != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 200),
            SizedBox(height: 20),
            CircularProgressIndicator(color: AppColors.white),
          ],
        ),
      ),
    );
  }
}
```

### Approach 2: Native Implementation

#### Android (android/app/src/main/res/drawable/launch_background.xml)
```xml
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@color/splash_color" />
    <item>
        <bitmap
            android:gravity="center"
            android:src="@drawable/splash_logo" />
    </item>
</layer-list>
```

#### iOS (ios/Runner/Assets.xcassets/LaunchImage.imageset/)
- Add launch images in different resolutions
- Configure in Info.plist

### Benefits
- **Professional Look**: Native splash screen shows immediately
- **Initialization Time**: Allows app setup while showing branding
- **Platform Consistency**: Follows platform guidelines

---

## Project Structure Summary

```
lib/
├── core/
│   ├── colors/           # Color definitions
│   ├── theme/           # Theme configurations
│   ├── l10n/            # Localization files
│   ├── di/              # Dependency injection
│   │   └── modules/     # DI modules
│   ├── routing/         # App routing
│   ├── services/        # Core services
│   └── providers/       # Global providers
├── features/
│   └── [feature_name]/
│       ├── data/        # Data layer (API, models)
│       ├── domain/      # Business logic
│       └── presentation/ # UI layer (screens, providers)
└── main.dart           # App entry point
```

## Getting Started Checklist

1. **✅ Add dependencies** to `pubspec.yaml`
2. **✅ Run** `flutter pub get`
3. **✅ Create folder structure**
4. **✅ Implement colors and theme**
5. **✅ Setup localization files**
6. **✅ Configure dependency injection**
7. **✅ Setup API client with Retrofit**
8. **✅ Create shared preferences service**
9. **✅ Implement provider state management**
10. **✅ Configure splash screen**
11. **✅ Run** `dart run build_runner build` for code generation
12. **✅ Test the implementation**


## Additional Commands

```bash
# Generate code for DI, Retrofit, JSON serialization
dart run build_runner build

# Clean and rebuild
dart run build_runner build --delete-conflicting-outputs

# Generate splash screen
dart run flutter_native_splash:create

# Generate localization
flutter gen-l10n
```

This implementation provides a solid foundation for any Flutter project with proper architecture, state management, and essential features.
