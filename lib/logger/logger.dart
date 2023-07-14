import 'package:logger/logger.dart';

class MyLogger {
  MyLogger._();

  var logger = Logger();
  static MyLogger i = MyLogger._();

  factory MyLogger() => i;

  void mes(Object info) {
    logger.d(info.toString());
  }

  void err(Object info) {
    logger.e(info.toString());
  }
}
