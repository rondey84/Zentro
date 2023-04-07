import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/order_enums.dart';
import 'package:zentro/pages/order_status/order_status_controller.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/widgets/container_card.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:zentro/widgets/fav_button.dart';
import 'package:zentro/widgets/loading_item.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header.dart';

part './widgets/status_card.dart';
part 'widgets/floating_payment_widget.dart';

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
