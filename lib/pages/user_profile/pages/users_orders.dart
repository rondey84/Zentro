part of '../user_profile.dart';

class UsersOrdersScreen extends GetView<UsersOrdersController> {
  const UsersOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text(controller.header)),
      body: SafeArea(
        child: Obx(() {
          if (controller.hasOrdersDataLoaded.value) {
            List<Widget> widgets = [];
            if (controller.currentOrder != null) {
              widgets.addAll([
                _header('Current Order'),
                _orderItemCard(controller.currentOrder!, isCurrentOrder: true),
              ]);
            }
            widgets.add(_header('Past Orders'));
            if (controller.pastOrders.isEmpty) {
              widgets.add(Text(
                'No past orders available',
                style: TextStyle(
                  fontSize: 14.r,
                  fontWeight: FontWeight.normal,
                  color: Get.theme.customColor()?.text07,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ));
            } else {
              for (var pastOrder in controller.pastOrders) {
                widgets.add(_orderItemCard(pastOrder));
              }
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: widgets.length,
              itemBuilder: (_, idx) {
                return widgets[idx];
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
    );
  }

  Widget _header(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Text(
        text,
        style: controller.fontStyles!.header2,
        textAlign: TextAlign.left,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
    );
  }

  Widget _orderItemCard(
    UsersOrderItem orderDetail, {
    bool isCurrentOrder = false,
  }) {
    return GestureDetector(
      onTap: () => isCurrentOrder
          ? controller.showCurrentOrder(orderDetail)
          : controller.viewOrderDetail(orderDetail),
      child: ContainerCard(
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
                if (isCurrentOrder)
                  Text(
                    'Ongoing Order',
                    style: TextStyle(
                      fontSize: 12.r,
                      fontWeight: FontWeight.w500,
                      color: Get.theme.customColor()?.text04,
                    ),
                  )
                else
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
                                ? controller
                                    .extendedColorsStyle?.currentOrderCardColor
                                : controller.extendedColorsStyle?.nonVegColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            orderDetail.isOrderPickedUp
                                ? 'Picked Up'
                                : 'Canceled',
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.stars_rounded,
                              size: 14,
                              color: controller
                                  .extendedColorsStyle?.ratingsIconColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${orderDetail.rating?.rating.round()} Rating',
                              style: TextStyle(
                                fontSize: 14.r,
                                fontWeight: FontWeight.w500,
                                color: Get.theme.customColor()?.text05,
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
                  dashColor: Get.theme.primaryColorLight.withOpacity(0.4),
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
                      .map((e) => '${e.key.name} (${e.value})')
                      .join(', '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.r,
                    fontWeight: FontWeight.normal,
                    color: Get.theme.customColor()?.text05?.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  DateFormat('MMMM d, h:mm a').format(orderDetail.orderDate),
                  style: TextStyle(
                    fontSize: 12.r,
                    fontWeight: FontWeight.normal,
                    color: Get.theme.customColor()?.text05?.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            if (!isCurrentOrder && orderDetail.rating == null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomPaint(
                  painter: DashedLinePainter(
                    dashColor: Get.theme.primaryColorLight.withOpacity(0.4),
                  ),
                ),
              ),
            if (!isCurrentOrder && orderDetail.rating == null)
              Row(
                children: [
                  Text(
                    "You haven't rated this order yet",
                    style: TextStyle(
                      fontSize: 12.r,
                      fontWeight: FontWeight.normal,
                      color: Get.theme.customColor()?.text03,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.FEEDBACK, parameters: {
                          'orderId': orderDetail.orderId,
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Get.theme.primaryColorDark),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        child: Text(
                          'Rate order',
                          style: TextStyle(
                            fontSize: 14.r,
                            fontWeight: FontWeight.normal,
                            color: Get.theme.primaryColorDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
