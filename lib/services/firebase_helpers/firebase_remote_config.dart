part of '../firebase_service.dart';

class FirebaseRemoteConfigHelper {
  late final FirebaseRemoteConfig _remoteConfig;

  FirebaseRemoteConfigHelper() {
    _remoteConfig = FirebaseRemoteConfig.instance;
  }

  Future<void> init() async {
    // DEBUG VALUES
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 10),
    ));

    await _remoteConfig.fetchAndActivate();
  }

  String? getString(RemoteConfigKey remoteConfigKey) {
    return _remoteConfig.getString(remoteConfigKey.key);
  }

  int? getInt(RemoteConfigKey remoteConfigKey) {
    return _remoteConfig.getInt(remoteConfigKey.key);
  }

  double? getDouble(RemoteConfigKey remoteConfigKey) {
    return _remoteConfig.getDouble(remoteConfigKey.key);
  }

  bool? getBool(RemoteConfigKey remoteConfigKey) {
    return _remoteConfig.getBool(remoteConfigKey.key);
  }
}
