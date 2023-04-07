import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zentro/data/constants/debug.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/widgets/custom_dialogs.dart';

class LocationService extends GetxService {
  // Instance of this service
  static final instance = Get.find<LocationService>();

  StreamSubscription<ServiceStatus>? _serviceStatusStream;
  final RxBool _isServiceStatusEnabled = false.obs;
  bool get isStatusServiceEnabled => _isServiceStatusEnabled.value;
  set isStatusServiceEnabled(bool val) => _isServiceStatusEnabled.value = val;
  late LocationPermission locationPermission;
  Position? position;
  StreamSubscription<Position>? _positionStreamSub;
  Rx<Placemark>? placemark;

  final fontStyles = Get.theme.extension<CustomFontStyles>();

  final locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  bool get isLocationPermissionGranted {
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  Future<LocationService> init() async {
    logPrint('LOCATION INIT SERVICE: Init Method called');

    logPrint('LOCATION INIT SERVICE: Worker Method Initiating');

    ever(_isServiceStatusEnabled, (val) async {
      // Location services are not enabled, stop everything and request for location enable
      if (!val) {
        _getPosition();
      }
    });

    logPrint('LOCATION INIT SERVICE: Checking for Status Service');

    isStatusServiceEnabled = await Geolocator.isLocationServiceEnabled();

    logPrint('LOCATION INIT SERVICE: Subscribing to Service Status Stream');

    await _subscribeToServiceStream();

    logPrint('LOCATION INIT SERVICE: Checking for Permission');

    await _initLocationPermission();

    logPrint(
        'LOCATION INIT SERVICE: Subscribing to Location Permission Stream');

    await _subscribeToLocationPermissionStream();

    logPrint('LOCATION INIT SERVICE: Subscribing to Position Service');

    await _subscribeToPositionStream();

    logPrint('LOCATION INIT SERVICE: INIT FINISHED');
    return this;
  }

  Future<void> _subscribeToServiceStream() async {
    if (_serviceStatusStream != null) return;
    final serviceStatusStream = Geolocator.getServiceStatusStream();
    _serviceStatusStream = serviceStatusStream.handleError((error) {
      _serviceStatusStream?.cancel();
      _serviceStatusStream = null;
    }).listen((serviceStatus) {
      if (serviceStatus == ServiceStatus.disabled) {
        isStatusServiceEnabled = false;
      } else {
        isStatusServiceEnabled = true;
      }
    });
  }

  Future<void> _initLocationPermission() async {
    locationPermission = await Geolocator.checkPermission();

    if (!isLocationPermissionGranted) {
      locationPermission = await Geolocator.requestPermission();
    }
  }

  Future<void> _subscribeToLocationPermissionStream() async {
    Future<LocationPermission> futureTask() async {
      await Future.delayed(const Duration(seconds: 5));
      return await Geolocator.checkPermission();
    }

    Stream.fromFuture(futureTask()).listen(
      (val) {
        locationPermission = val;

        if (!isLocationPermissionGranted) {
          Get.toNamed(AppRoutes.LOCATION_PERMISSION);
        }
      },
    );
  }

  Future<bool> _subscribeToPositionStream() async {
    logPrint('LOCATION POSITION STREAM: Initiated');
    bool streamSubscribed = false;

    logPrint('LOCATION POSITION STREAM: Checking for Permission');

    if (isLocationPermissionGranted) {
      logPrint('LOCATION POSITION STREAM: Location Permission Granted');

      logPrint('LOCATION POSITION STREAM: Getting Current Position');
      position = await Geolocator.getCurrentPosition();
      _initPlacemark();

      if (_positionStreamSub == null) {
        logPrint(
            'LOCATION POSITION STREAM: Position Stream Subscription Initiated');

        final positionStream = Geolocator.getPositionStream(
          locationSettings: locationSettings,
        );
        _positionStreamSub = positionStream.handleError((error) {
          logPrint(
              'LOCATION POSITION STREAM: Position Stream Error! Stream Canceled and reset');

          _positionStreamSub?.cancel();
          _positionStreamSub = null;
        }).listen((position) {
          this.position = position;
          _updatePlacemark();
        });
      }
      streamSubscribed = true;
    }
    return streamSubscribed;
  }

  Future<void> requestPermission() async {
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location Permissions are denied');
        return;
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      await _showAppPermissionDialog();
    }
  }

  Future<void> _getPosition() async {
    try {
      await Geolocator.getCurrentPosition().then((position) {
        this.position = position;
      });
    } catch (e) {
      _showDevicePermissionDialog();
    }
  }

  Future<void> _initPlacemark() async {
    logPrint('PLACEMARK: Initializing');
    if (position != null) {
      placemark = (await fetchPlacemark(
        latitude: position!.latitude,
        longitude: position!.longitude,
      ))
          .first
          .obs;
    }
  }

  void _updatePlacemark() {
    if (position != null) {
      logPrint('PLACEMARK: updating');
      fetchPlacemark(
        latitude: position!.latitude,
        longitude: position!.longitude,
      ).then((value) => placemark?.value = value.first);
    }
  }

  Future<List<Placemark>> fetchPlacemark({
    required double latitude,
    required double longitude,
  }) async {
    return await placemarkFromCoordinates(
      latitude,
      longitude,
    );
  }

  // Dialog
  Future<void> _showAppPermissionDialog() async {
    await CustomDialogs.animatedDialog(
      barrierDismissible: false,
      showCloseButton: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Permission Denied',
              style: fontStyles?.header1,
            ),
            const SizedBox(height: 8),
            Text(
              'Please allow app to access your location',
              style: fontStyles?.body2.copyWith(
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _dialogButton(
                    buttonColor: Get.theme.primaryColor,
                    text: 'Ya Sure!',
                    textColor: Get.theme.customColor()?.text00,
                    onTap: () async {
                      await Geolocator.openAppSettings();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).then((_) async {
      locationPermission = await Geolocator.checkPermission();

      _subscribeToPositionStream();
    });
  }

  Future<void> _showDevicePermissionDialog() async {
    await CustomDialogs.animatedDialog(
      barrierDismissible: false,
      showCloseButton: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Device Location Disabled',
              style: fontStyles?.header1,
            ),
            const SizedBox(height: 8),
            Text(
              'Please enable the location service for the app to work',
              style: fontStyles?.body2.copyWith(
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _dialogButton(
                    buttonColor: Get.theme.primaryColor.withOpacity(0.2),
                    text: 'Exit Zentro',
                    textColor: Get.theme.customColor()?.text06,
                    onTap: () {
                      Get.back();
                      SystemNavigator.pop();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _dialogButton(
                    buttonColor: Get.theme.primaryColor,
                    text: 'Ok',
                    textColor: Get.theme.customColor()?.text00,
                    onTap: () async {
                      if (GetPlatform.isAndroid) {
                        await Geolocator.openLocationSettings();
                      }
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogButton({
    required Color buttonColor,
    required String text,
    required textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: buttonColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          text,
          style: fontStyles?.button.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
