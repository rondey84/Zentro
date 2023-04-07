import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';

class CustomSnackbars {
  static SnackbarController error({
    required String title,
    required String message,
    bool closeOtherSnackbars = true,
  }) {
    if (Get.isSnackbarOpen && closeOtherSnackbars) {
      Get.closeAllSnackbars();
    }

    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        30,
      ),
      borderWidth: 4,
      borderColor: Get.theme.colorScheme.error,
      backgroundColor: Get.theme.cardColor.withOpacity(0.7),
      colorText: Get.theme.customColor()?.text08,
      borderRadius: 24,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 5),
    );
  }
}
