import 'package:logger/logger.dart';

class MyLogger {
  MyLogger._();

  var logger = Logger();
  static MyLogger instance = MyLogger._();

  factory MyLogger() => instance;

  void mes(Object info) {
    logger.d(info.toString());
  }

  void err(Object info) {
    logger.e(info.toString());
  }
}
