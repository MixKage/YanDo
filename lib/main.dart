import 'package:flutter/material.dart';
import 'package:yando/navigation/nav_service.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  final NavigationService navigationService = NavigationService();

  @override
  void initState() {
    navigationService.init(_navigatorKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: _navigatorKey,
        initialRoute: navigationService.initialRoute,
        debugShowCheckedModeBanner: false,
        routes: navigationService.routes,
        onGenerateRoute: navigationService.onGenerateRoute,
      );
}
