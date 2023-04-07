part of '../feedback.dart';

class _FeedbackHeader extends GetView<FeedbackController> {
  const _FeedbackHeader();

  @override
  Widget build(BuildContext context) {
    return ContainerCard(
      boxConstraints: BoxConstraints(
        minWidth: 1.sw,
      ),
      child: Column(
        children: [
          Obx(() {
            if (controller.isKeyboardOpen.value) {
              return const SizedBox.shrink();
            }
            if (controller.hasDataLoaded.value) {
              return Text(
                'Rate Your Experience with',
                style: controller.fontStyles?.cardHeader,
              );
            }
            return LoadingItem(
              height: controller.textHeight(
                'Sample',
                controller.fontStyles?.cardHeader,
              ),
              width: 180,
            );
          }),
          Obx(() {
            return SizedBox(height: controller.isKeyboardOpen.value ? 0 : 8);
          }),
          Obx(() {
            if (controller.hasDataLoaded.value) {
              return Text(
                controller.restaurantName ?? '',
                style: controller.fontStyles?.display.copyWith(
                  fontSize: 28.r,
                ),
              );
            }
            return LoadingItem(
              height: controller.textHeight(
                'Sample',
                controller.fontStyles?.display.copyWith(
                  fontSize: 28.r,
                ),
              ),
              width: 240,
            );
          })
        ],
      ),
    );
  }
}
