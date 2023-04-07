part of '../orders.dart';

class _TabBar extends GetView<OrdersController> {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: controller.shadowStyles?.cardShadow01,
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: tabButton(controller.tabData[0], 0)),
                const SizedBox(width: 4),
                Expanded(child: tabButton(controller.tabData[1], 1)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tabButton(String text, int index) {
    return GetBuilder<OrdersController>(
      key: ValueKey(index),
      id: controller.tabsTag,
      builder: (_) {
        return SpacedCards(
          isSelected: controller.selectedIndex.value == index,
          selectedColor: Get.theme.primaryColor,
          onTap: () => controller.tabOnPressed(index),
          child: Center(
            child: Text(
              text,
              style: controller.fontStyles?.chipTextStyle.copyWith(
                color: controller.selectedIndex.value == index
                    ? Colors.white
                    : controller.fontStyles?.chipTextStyle.color,
              ),
            ),
          ),
        );
      },
    );
  }
}
