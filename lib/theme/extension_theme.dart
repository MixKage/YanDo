import 'package:flutter/material.dart';

@immutable
class MyExtension extends ThemeExtension<MyExtension> {
  const MyExtension({
    required this.error,
    required this.grey,
    required this.green,
  });

  final Color? error;
  final Color? grey;
  final Color? green;

  Color get transparent => Colors.transparent;

  BorderRadius get normalBorderRadius => BorderRadius.circular(8);

  EdgeInsets get normalEdgeInsets => const EdgeInsets.all(8);

  EdgeInsets get bigEdgeInsets => const EdgeInsets.all(16);

  @override
  MyExtension copyWith({Color? error, Color? grey, Color? green}) =>
      MyExtension(
        error: error ?? this.error,
        grey: grey ?? this.grey,
        green: green ?? this.green,
      );

  @override
  MyExtension lerp(MyExtension? other, double t) {
    if (other is! MyExtension) {
      return this;
    }
    return MyExtension(
      error: Color.lerp(error, other.error, t),
      grey: Color.lerp(grey, other.grey, t),
      green: Color.lerp(green, other.green, t),
    );
  }
}
