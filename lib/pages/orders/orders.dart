import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/floating_cart_type.dart';
import 'package:zentro/pages/orders/orders_controller.dart';
import 'package:zentro/widgets/cart/floating_cart_action.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:zentro/widgets/fav_button.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header.dart';
import 'package:zentro/widgets/spaced_cards.dart';

part './widgets/tab_bar.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  static const double _floatingActionButtonGap = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        actions: [FavButton()],
      ),
      body: SizedBox(
        height: 1.sh - kToolbarHeight,
        child: Obx(() => controller.hasError
            ? const Text('ERROR')
            : Column(
                children: [
                  RestaurantHeader(
                    actions: {
                      Center(
                        child: Text(
                          'Place Your Order',
                          style: controller.fontStyles?.restHeaderHead,
                        ),
                      ): null
                    },
                  ),
                  const _TabBar(),
                  Expanded(
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: (controller.floatingCartController.cartStyle
                                      ?.cartHeight ??
                                  0.0) +
                              _floatingActionButtonGap,
                        ),
                        child: Container(
                          color: Colors.blue.withOpacity(0.3),
                        ),
                      ),
                    ),
                  )
                ],
              )),
      ),
      floatingActionButton: Obx(() {
        if (controller.hasError) {
          return const SizedBox.shrink();
        } else {
          return const FloatingCartActionWidget(
            cartType: FloatingCartType.order,
          );
        }
      }),
      floatingActionButtonLocation: controller.cartLocation,
    );
  }
}
