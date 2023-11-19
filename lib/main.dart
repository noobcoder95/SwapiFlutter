import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:swapi_flutter/data/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

/// Using GetIt as Dependency Injection
final GetIt di = GetIt.instance;

Future<void> _initialize() async {
  /// Initialize flutter widget binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Registering shared preference to DI (for local storage)
  di.registerSingletonAsync(() => SharedPreferences.getInstance());
  /// Registering navigator state to DI (for global context)
  di.registerSingleton(GlobalKey<NavigatorState>());
  /// Registering scaffold messenger state to DI (for global snack bar)
  di.registerSingleton(GlobalKey<ScaffoldMessengerState>());
  /// Registering repository class to DI
  di.registerSingleton<Repository>(RepositoryImplementation());
  /// Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();
}

void main() async {
  await _initialize();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swapi Flutter',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      navigatorKey: di.get<GlobalKey<NavigatorState>>(),
      scaffoldMessengerKey: di.get<GlobalKey<ScaffoldMessengerState>>(),
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            surfaceTint: Colors.white,
            secondary: const Color(0xD7BEBEC0),
            seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
