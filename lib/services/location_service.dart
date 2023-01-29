import 'dart:async';

import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zentro/routes/app_pages.dart';

class LocationService extends GetxService {
  StreamSubscription<ServiceStatus>? _serviceStream;
  final RxBool _serviceEnabled = false.obs;
  bool get serviceEnabled => _serviceEnabled.value;
  set serviceEnabled(bool val) => _serviceEnabled.value = val;
  late LocationPermission permission;
  Position? position;
  StreamSubscription<Position>? _positionStreamSub;
  Placemark? placemark;

  final locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  bool get isLocationPermissionGranted {
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    return false;
  }

  Future<LocationService> init() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    await _subscribeToServiceStream();
    ever(_serviceEnabled, (val) {
      // Location services are not enabled, stop everything and request for location enable
      if (!val) {
        _locationServiceDisabledSnackbar();
      }
    });

    await _subscribeToPositionStream();

    return this;
  }

  Future<void> _subscribeToServiceStream() async {
    if (_serviceStream != null) return;
    final serviceStatusStream = Geolocator.getServiceStatusStream();
    _serviceStream = serviceStatusStream.handleError((error) {
      _serviceStream?.cancel();
      _serviceStream = null;
    }).listen((serviceStatus) {
      if (serviceStatus == ServiceStatus.disabled) {
        serviceEnabled = false;
      } else {
        serviceEnabled = true;
      }
    });
  }

  Future<bool> _subscribeToPositionStream() async {
    bool streamSubscribed = false;
    permission = await Geolocator.checkPermission();
    if (isLocationPermissionGranted) {
      position = await Geolocator.getCurrentPosition();
      _loadPlacemark();

      if (_positionStreamSub == null) {
        final positionStream = Geolocator.getPositionStream(
          locationSettings: locationSettings,
        );
        _positionStreamSub = positionStream.handleError((error) {
          _positionStreamSub?.cancel();
          _positionStreamSub = null;
        }).listen((position) {
          this.position = position;
        });
      }
      streamSubscribed = true;
    }
    return streamSubscribed;
  }

  void _locationServiceDisabledSnackbar() {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      'Location Service Disabled',
      'Please enable device location',
    );
  }

  Future<void> requestPosition() async {
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _locationServiceDisabledSnackbar();
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location Permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // TODO: Dialog Styling
      await Get.defaultDialog(
        title: 'Location Permission Denied',
        middleText: 'We need your location to show restaurants near you.',
        textConfirm: 'Open Settings',
        onConfirm: () async => await Geolocator.openLocationSettings(),
      );
    }

    if (Get.isDialogOpen!) Get.close(1);

    final isPositionStreamSubscribed = await _subscribeToPositionStream();
    if (isPositionStreamSubscribed) {
      Get.offAllNamed(AppRoutes.HOME);
    } else {
      Get.snackbar(
        'Error',
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
  }

  Future<void> _loadPlacemark() async {
    if (position == null) return;

    placemark = (await placemarkFromCoordinates(
            position!.latitude, position!.longitude))
        .first;
  }
}
