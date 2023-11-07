part of '../firebase_service.dart';

class FirebaseAppCheckHelper {
  late final FirebaseAppCheck _appCheck;

  FirebaseAppCheckHelper() {
    _appCheck = FirebaseAppCheck.instance;
  }

  Future<void> activate() async {
    await _appCheck.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.playIntegrity,
    );
  }
}
