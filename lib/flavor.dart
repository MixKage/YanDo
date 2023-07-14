import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class FL {
  FL._();

  static FL instance = FL._();

  factory FL() => instance;

  FlavorConfig get flavorConfig => FlavorConfig(
        name: kReleaseMode ? 'TEST' : 'DEV',
        location: BannerLocation.bottomEnd,
      );
}
