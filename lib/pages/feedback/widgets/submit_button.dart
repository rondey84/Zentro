part of '../feedback.dart';

class _SubmitButton extends GetView<FeedbackController> {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.hasDataLoaded.value) {
        return GestureDetector(
          onTap: controller.onSubmitHandler,
          child: Container(
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: Get.theme.primaryColorDark,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 12,
            ),
            child: Column(
              children: [
                Text(
                  'Submit Feedback',
                  style: controller.fontStyles?.header1.copyWith(
                    color: Get.theme.customColor()?.text00,
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return LoadingItem(
        borderRadius: 100,
        width: 220,
        height: controller.textHeight(
              'Sample',
              controller.fontStyles?.caption,
            ) +
            controller.textHeight(
              'Sample',
              controller.fontStyles?.restHeaderHead,
            ) +
            20,
      );
    });
  }
}
