part of '../home.dart';

class _CurrentOrderCard extends GetView<HomeController> {
  const _CurrentOrderCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.navigateToOrderStatus,
      child: AnimatedBuilder(
        animation: controller.animation,
        builder: (_, ch) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: controller.animation.value,
                radius: 0.35,
                colors: [
                  const Color(0xFF00FFA3),
                  Get.theme.scaffoldBackgroundColor.withOpacity(0.01),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: controller.extendedColor?.currentOrderCardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                                controller.currentOrderTitleText.value,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Get.theme.customColor()?.text00,
                                ),
                              )),
                          const SizedBox(height: 16),
                          Container(
                            decoration: ShapeDecoration(
                              shape: const StadiumBorder(),
                              color: Get.theme.customColor()?.text09,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 7,
                            ),
                            child: Obx(() => Text(
                                  controller.currentOrderButtonText.value,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Get.theme.customColor()?.text02,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: SvgHelper.happyNews(
                        primaryColor: Get.theme.primaryColor,
                        height: 140,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
