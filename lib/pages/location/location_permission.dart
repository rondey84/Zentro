import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/widgets/gradient_border_button.dart';
import './location_permission_controller.dart';

class LocationPermissionScreen extends GetView<LocationPermissionController> {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: 1.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: FittedBox(
                    child: Text(
                      controller.header,
                      style: controller.fontStyle!.display,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 34,
                  ),
                  child: Text(
                    controller.description,
                    style: controller.fontStyle!.body2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  child: SvgHelper.currentLocation(
                    primaryColor: Get.theme.primaryColor,
                  ),
                ),
                const Spacer(),
                GradientBorderButton(
                  onTap: controller.locationAccessHandler,
                  text: 'Allow location access',
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
