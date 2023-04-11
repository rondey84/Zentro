import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/data/constants/debug.dart';
import 'package:zentro/data/enums/order_enums.dart';
import 'package:zentro/pages/order_status/order_status_controller.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/widgets/container_card.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:zentro/widgets/custom_dialogs.dart';
import 'package:zentro/widgets/fav_button.dart';
import 'package:zentro/widgets/loading_item.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header.dart';
import 'package:collection/collection.dart';

part './widgets/status_card.dart';
part 'widgets/floating_payment_widget.dart';

// TODO: add debug button to update Order Status
class OrderStatusScreen extends GetView<OrderStatusController> {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          Obx(() {
            if (controller.hasError) {
              return const SizedBox.shrink();
            }
            if (!controller.hasRestaurantDataLoaded.value) {
              return loadingFav();
            }
            return FavButton(
              isFav: controller.isRestaurantFav.value,
              onTap: controller.favButtonHandler,
            );
          }),
        ],
      ),
      body: SizedBox(
        height: 1.sh - kToolbarHeight,
        child: Column(
          children: [
            RestaurantHeader(
              actions: {
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Getting your order ready',
                      style: controller.fontStyles?.restHeaderHead,
                    )
                  ],
                ): null,
                Icon(
                  Icons.location_on,
                  color: Get.theme.primaryColorLight,
                ): null,
              },
            ),
            const SizedBox(height: 12),
            const _OrderStatus(),
            const SizedBox(height: 12),
            Text(
              'Order changes must be requested before confirmation',
              style: controller.fontStyles?.caption.copyWith(
                fontStyle: FontStyle.italic,
                color: Get.theme.customColor()?.text03,
              ),
            ),
            if (DEBUG_MODE) const Spacer(),
            if (DEBUG_MODE)
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    // Update debug Order Status with actual status before showing dialog
                    controller.debugSelectedOrderStatus.value =
                        controller.orderStatus;
                    // deepCopy from the old list with completed status added
                    final debugOrderStatues = [
                      ...controller.visibleOrderStatuses
                    ]..add(OrderStatus.completed);
                    await CustomDialogs.animatedDialog(
                      removeDuplicateDialog: false,
                      barrierDismissible: true,
                      barrierLabel: 'Order Status Dialog',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'DEBUG MODE\nUpdate Order Status',
                              style: controller.fontStyles?.header1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'This will update you current order',
                              style: controller.fontStyles?.body2.copyWith(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ...List.generate(
                              debugOrderStatues.length,
                              (idx) {
                                return Obx(() {
                                  var isSelected = debugOrderStatues[idx] ==
                                      controller.debugSelectedOrderStatus.value;
                                  return GestureDetector(
                                    onTap: () {
                                      controller.debugSelectedOrderStatus
                                          .value = debugOrderStatues[idx];
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: 1.sw,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.transparent
                                              : Get.theme
                                                      .customColor()
                                                      ?.text04 ??
                                                  Colors.black,
                                        ),
                                        color: isSelected
                                            ? controller.extendedStyle
                                                ?.currentOrderCardColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Text(
                                        debugOrderStatues
                                                .elementAt(idx)
                                                .name
                                                .capitalize ??
                                            '',
                                        style: controller.fontStyles?.body2
                                            .copyWith(
                                          color: isSelected
                                              ? Get.theme.customColor()?.text00
                                              : Get.theme.customColor()?.text04,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              },
                              growable: true,
                            ),
                            GestureDetector(
                              onTap: controller.updateOrderStatus,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Get.theme.customColor()?.text07,
                                ),
                                child: Text(
                                  'CONFIRM',
                                  style: controller.fontStyles?.button.copyWith(
                                    color: Get.theme.customColor()?.text00,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('DEBUG', style: controller.fontStyles?.button),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        if (!controller.hasRestaurantDataLoaded.value) {
          return const SizedBox.shrink();
        }
        if (controller.isOrderPaid) {
          return const SizedBox.shrink();
        }
        return const _FloatingPaymentWidget();
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget loadingFav() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LoadingItem(
        enabled: !controller.hasRestaurantDataLoaded.value,
        height: 36,
        width: 36,
        borderRadius: 12,
      ),
    );
  }
}
