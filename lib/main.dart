import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:yando/database/local_data.dart';
import 'package:yando/firebase_config.dart';
import 'package:yando/firebase_options.dart';
import 'package:yando/flavor.dart';
import 'package:yando/l10n/l10n.dart';
import 'package:yando/model/tasks_notifier.dart';
import 'package:yando/navigation/nav_service.dart';
import 'package:yando/theme/app_theme.dart';

Future<void> main() async {
  await LD.i.initAsync();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  FL.i.flavorConfig;
  await FRC.i.initFRC(fetchTimeout: 1, minimumFetchInterval: 5);
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
        child: FlavorBanner(
          location: BannerLocation.topEnd,
          child: MaterialApp(
            supportedLocales: Ln10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: AppTheme.themeLight,
            debugShowCheckedModeBanner: false,
            darkTheme: AppTheme.themeDark,
            navigatorKey: _navigatorKey,
            initialRoute: navigationService.initialRoute,
            routes: navigationService.routes,
            onGenerateRoute: navigationService.onGenerateRoute,
          ),
        ),
      );
}
