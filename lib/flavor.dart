import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

/// FlavorLayer
class FL {
  FL._();

  static FL i = FL._();

  factory FL() => i;

  FlavorConfig get flavorConfig => FlavorConfig(
        name: kReleaseMode ? 'TEST' : 'DEV',
        location: BannerLocation.bottomEnd,
      );
}
