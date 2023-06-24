import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:yando/database/locale_data.dart';
import 'package:yando/model/tasks_notifier.dart';
import 'package:yando/navigation/nav_service.dart';
import 'package:yando/theme/app_theme.dart';

Future<void> main() async {
  await LocaleData.instance.initAsync();
  await dotenv.load();
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
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TasksNotifier.fromHive(),
          )
        ],
        child: MaterialApp(
          theme: AppTheme.theme(false),
          darkTheme: AppTheme.theme(),
          navigatorKey: _navigatorKey,
          initialRoute: navigationService.initialRoute,
          debugShowCheckedModeBanner: false,
          routes: navigationService.routes,
          onGenerateRoute: navigationService.onGenerateRoute,
        ),
      );
}
