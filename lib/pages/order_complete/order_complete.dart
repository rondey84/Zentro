import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/order_complete/order_complete_controller.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/widgets/container_card.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:zentro/widgets/loading_item.dart';

class OrderCompleteScreen extends GetView<OrderCompleteController> {
  const OrderCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              ContainerCard(
                boxConstraints: BoxConstraints(
                  minWidth: 1.sw,
                ),
                child: Column(
                  children: [
                    Obx(() {
                      if (controller.hasOrderDataLoaded.value) {
                        return Text(
                          'Thank You for Visiting',
                          style: controller.fontStyles?.button,
                        );
                      }
                      return LoadingItem(
                        height: controller.textHeight(
                          'Sample',
                          controller.fontStyles?.button,
                        ),
                        width: 180,
                      );
                    }),
                    const SizedBox(height: 12),
                    Obx(() {
                      if (controller.hasRestaurantDataLoaded.value) {
                        return Text(
                          controller.restaurant?.name ?? '',
                          style: controller.fontStyles?.display,
                        );
                      }
                      return LoadingItem(
                        height: controller.textHeight(
                          'Sample',
                          controller.fontStyles?.display,
                        ),
                        width: 240,
                      );
                    })
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Obx(() => controller.hasOrderDataLoaded.value
                    ? SvgHelper.completed()
                    : const LoadingItem(height: 275)),
              ),
              const SizedBox(height: 12),
              Obx(() {
                if (controller.hasOrderDataLoaded.value) {
                  return Text(
                    'Order Completed',
                    style: controller.fontStyles?.header1,
                  );
                }
                return LoadingItem(
                  height: controller.textHeight(
                    'Sample',
                    controller.fontStyles?.header1,
                  ),
                  width: 180,
                );
              }),
              const SizedBox(height: 30),
              Obx(() {
                if (controller.hasOrderDataLoaded.value) {
                  return GestureDetector(
                    onTap: controller.navigateToFeedback,
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(),
                        color: Get.theme.primaryColorDark,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 42,
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Enjoyed the service?',
                            style: controller.fontStyles?.caption.copyWith(
                              color: Get.theme.customColor()?.text04,
                            ),
                          ),
                          Text(
                            'Leave a Feedback',
                            style:
                                controller.fontStyles?.restHeaderHead.copyWith(
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
              })
            ],
          ),
        ),
      ),
    );
  }
}
