part of '../user_profile.dart';

class UsersOrders extends GetView<UsersOrdersController> {
  const UsersOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text(controller.header)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            if (controller.hasOrdersDataLoaded.value) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.usersOrders.length,
                itemBuilder: (_, idx) {
                  final orderDetail = controller.usersOrders[idx];
                  return ContainerCard(
                    borderRadius: 22,
                    padding: const EdgeInsets.all(16),
                    shadowStyle: ShadowStyle.noShadow,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderDetail.restName,
                                    style: TextStyle(
                                      fontSize: 18.r,
                                      fontWeight: FontWeight.bold,
                                      color: Get.theme.customColor()?.text07,
                                    ),
                                  ),
                                  if (orderDetail.restOutlet != null)
                                    const SizedBox(height: 2),
                                  if (orderDetail.restOutlet != null)
                                    Text(
                                      orderDetail.restOutlet!,
                                      style: TextStyle(
                                        fontSize: 12.r,
                                        fontWeight: FontWeight.normal,
                                        color: Get.theme.customColor()?.text04,
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '₹${orderDetail.totalPrice.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      fontSize: 16.r,
                                      fontWeight: FontWeight.bold,
                                      color: Get.theme.customColor()?.text06,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      orderDetail.isOrderPickedUp
                                          ? Icons.check_circle_rounded
                                          : Icons.question_mark_rounded,
                                      size: 12,
                                      color: orderDetail.isOrderPickedUp
                                          ? controller.extendedColorsStyle
                                              ?.currentOrderCardColor
                                          : controller.extendedColorsStyle
                                              ?.ratingsIconColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Picked Up',
                                      style: TextStyle(
                                        fontSize: 12.r,
                                        fontWeight: FontWeight.w500,
                                        color: Get.theme.customColor()?.text04,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (orderDetail.rating == null)
                                  Text(
                                    'No Rating',
                                    style: TextStyle(
                                      fontSize: 14.r,
                                      fontWeight: FontWeight.w400,
                                      color: Get.theme.customColor()?.text04,
                                    ),
                                  )
                                else
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.stars_rounded,
                                        size: 14,
                                        color: controller.extendedColorsStyle
                                            ?.ratingsIconColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${orderDetail.rating?.round()} Rating',
                                        style: TextStyle(
                                          fontSize: 14.r,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Get.theme.customColor()?.text05,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomPaint(
                            painter: DashedLinePainter(
                              dashColor:
                                  Get.theme.primaryColorLight.withOpacity(0.4),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderDetail.orderItems.entries
                                  .map((e) => '${e.key} (${e.value})')
                                  .join(', '),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.r,
                                fontWeight: FontWeight.normal,
                                color: Get.theme
                                    .customColor()
                                    ?.text05
                                    ?.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              DateFormat('MMMM d, h:mm a')
                                  .format(orderDetail.orderDate),
                              style: TextStyle(
                                fontSize: 12.r,
                                fontWeight: FontWeight.normal,
                                color: Get.theme
                                    .customColor()
                                    ?.text05
                                    ?.withOpacity(0.6),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              itemBuilder: (_, __) => const LoadingItem(),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: 6,
            );
          }),
        ),
      ),
    );
  }
}
