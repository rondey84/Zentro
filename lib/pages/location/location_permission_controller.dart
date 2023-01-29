import 'package:get/get.dart';
import 'package:zentro/services/location_service.dart';
import 'package:zentro/theme/extensions/authentication_style.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';

class LocationPermissionController extends GetxController {
  var authStyle = Get.theme.extension<AuthenticationStyle>();
  var fontStyle = Get.theme.extension<CustomFontStyles>();
  LocationService locationService = Get.find();

  String get header => "What's your location?";
  String get description =>
      'We need your location to show available restaurants';
}
