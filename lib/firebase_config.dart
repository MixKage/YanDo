import 'package:firebase_remote_config/firebase_remote_config.dart';

///FireBaseConfig
class FRC {
  FRC._();

  static FRC i = FRC._();

  factory FRC() => i;

  Future<void> initFRC({
    required int fetchTimeout,
    required int minimumFetchInterval,
  }) async {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(minutes: fetchTimeout),
        minimumFetchInterval: Duration(hours: minimumFetchInterval),
      ),
    );
    await FirebaseRemoteConfig.instance.setDefaults(const {
      'error_color': 'none',
    });
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  }

  String? getErrorColor() =>
      FirebaseRemoteConfig.instance.getString('error_color');
}
