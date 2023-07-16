import 'package:flutter/material.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';
import 'package:yando/pages/home/home_page.dart';
import 'package:yando/pages/task/task_page.dart';
import 'package:yando/pages/unknow/unknow_page.dart';

enum NavigationPaths {
  home('/'),
  task('/task'),
  unknown('/unknown');

  const NavigationPaths(this.path);

  final String path;
}

class NavigationService {
  NavigationService._();

  static NavigationService i = NavigationService._();

  factory NavigationService() => i;

  late final GlobalKey<NavigatorState> _globalKey;

  void init(GlobalKey<NavigatorState> key) {
    _globalKey = key;
  }

  final routes = <String, WidgetBuilder>{
    NavigationPaths.home.path: (BuildContext context) => const HomePage(),
    NavigationPaths.task.path: (BuildContext context) => TaskPage(
          task: ModalRoute.of(context)?.settings.arguments as TaskModel?,
        ),
  };

  String get initialRoute => '/';

  Future<void> pushNamed(
    NavigationPaths pathEnum, [
    TaskModel? anything,
  ]) async {
    MyLogger.i.mes('Set ${pathEnum.path} page with params: $anything');
    await _globalKey.currentState?.push(
      PageRouteBuilder(
        settings: RouteSettings(name: pathEnum.path, arguments: anything),
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            routes[pathEnum.path]?.call(context) ?? const UnknownPage(),
        transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            routes[settings.name]?.call(context) ?? const SizedBox.shrink(),
        transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
            FadeTransition(opacity: a, child: c),
      );

  void pop() {
    _globalKey.currentState?.pop();
  }
}
