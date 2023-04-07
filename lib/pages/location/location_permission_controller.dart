import 'package:get/get.dart';
import 'package:zentro/services/location_service.dart';
import 'package:zentro/theme/extensions/authentication_style.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';

class LocationPermissionController extends FullLifeCycleController
    with FullLifeCycleMixin {
  var authStyle = Get.theme.extension<AuthenticationStyle>();
  var fontStyle = Get.theme.extension<CustomFontStyles>();
  final _locationService = LocationService.instance;

  String get header => "What's your location?";
  String get description =>
      'We need your location to show available restaurants';

  bool _firstInternalState = true;

  Future<void> locationAccessHandler() async {
    await _locationService.requestPermission();

    if (_locationService.isLocationPermissionGranted) {
      Get.until((route) => route.isFirst);
    }
  }

  Future<bool> onWillPop() async {
    return Future.value(_locationService.isLocationPermissionGranted);
  }

  @override
  void onDetached() {
    // implement onDetached
  }

  @override
  void onInactive() {
    // implement onInactive
  }

  @override
  void onPaused() {
    // implement onPaused
  }

  @override
  void onResumed() {
    if (!_firstInternalState && (Get.isDialogOpen ?? false)) {
      Get.back();
    }
    _firstInternalState = false;
  }
}
