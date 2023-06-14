import 'package:logger/logger.dart';

class MyLogger {
  MyLogger._();

  var logger = Logger();
  static MyLogger instance = MyLogger._();

  factory MyLogger() => instance;

  void mes(String info) {
    logger.d(info);
  }

  void err(String info) {
    logger.e(info);
  }
}
