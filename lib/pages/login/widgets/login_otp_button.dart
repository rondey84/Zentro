part of '../login.dart';

class _LoginOTPButton extends GetView<LoginController> {
  const _LoginOTPButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GradientBorderButton(
        onTap: controller.onTapHandler,
        text: controller.buttonText,
        loading: controller.isLoading.value,
      );
    });
  }
}
