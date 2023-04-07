part of '../order_status.dart';

class _OrderStatus extends GetView<OrderStatusController> {
  const _OrderStatus();

  @override
  Widget build(BuildContext context) {
    return ContainerCard(
      boxConstraints: const BoxConstraints(minWidth: 280, maxWidth: 280),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20)
          .copyWith(bottom: 0),
      child: Column(
        children: [
          // Order Status Header
          Obx(() {
            if (controller.hasOrderStatusLoaded.value) {
              return Text('Order Status', style: controller.cardHeaderTS);
            }
            return _loadingItem(
              height: controller.textHeight('Sample', controller.cardHeaderTS),
              width: 60,
              borderRadius: 18,
              enabled: controller.hasOrderStatusLoaded.value,
            );
          }),
          const SizedBox(height: 12),
          // Status body
          Obx(() {
            if (controller.hasOrderStatusLoaded.value) {
              return _statusWidget();
            }
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, __) =>
                  _loadingItem(borderRadius: 12, height: 16, width: 280),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: 8,
            );
          })
        ],
      ),
    );
  }

  Widget _statusWidget() {
    List<OrderStatus> visibleOS = [
      OrderStatus.initialized,
      OrderStatus.confirmed,
      OrderStatus.preparing,
      OrderStatus.ready,
    ];

    double rowSize = 72;
    double smallCircleSize = 24;
    double largeCircleSize = 48;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: List.generate(visibleOS.length, (index) {
          bool isSelected = controller.orderStatus == visibleOS[index];
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: largeCircleSize,
                height: rowSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: index == 0 ? rowSize / 2 : double.infinity,
                          width: smallCircleSize * 0.4,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 375),
                      height: isSelected ? largeCircleSize : smallCircleSize,
                      width: isSelected ? largeCircleSize : smallCircleSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Get.theme.customColor()?.text02
                            : Get.theme.primaryColor,
                        border: isSelected
                            ? Border.all(
                                width: 6,
                                color: Get.theme.primaryColor,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnimatedDefaultTextStyle(
                  style: isSelected
                      ? TextStyle(
                          color: Get.theme.customColor()?.text06,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )
                      : TextStyle(
                          color: Get.theme.customColor()?.text04,
                          fontSize: 14,
                        ),
                  duration: const Duration(milliseconds: 375),
                  child: Text(visibleOS[index].message, softWrap: false),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _loadingItem({
    double? height,
    double? width,
    double? borderRadius,
    bool enabled = true,
  }) {
    return LoadingItem(
      enabled: enabled,
      child: Align(
        child: Container(
          height: height ?? 40,
          width: width ?? 1.sw,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
        ),
      ),
    );
  }
}
