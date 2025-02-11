import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/environment/environment.dart';
import 'core/localStorageManager/register_adapter.dart';
import 'core/servicesLocator/services_locator.dart';
import 'features/splash/presentation/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await dotenv.load(fileName: Environment.fileName);
  await Hive.initFlutter();
  HiveRegisterAdapter.registerAdapters();
  await Hive.openBox('localStorage');
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
