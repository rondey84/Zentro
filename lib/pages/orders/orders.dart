import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/floating_cart_type.dart';
import 'package:zentro/data/model/menu_item.dart';
import 'package:zentro/pages/orders/orders_controller.dart';
import 'package:zentro/util/custom_painters/dashed_line_painter.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/widgets/cart/floating_cart_action.dart';
import 'package:zentro/widgets/container_card.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:zentro/widgets/fav_button.dart';
import 'package:zentro/widgets/loading_item.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header.dart';
import 'package:zentro/widgets/spaced_cards.dart';

part './widgets/tab_bar.dart';
part './widgets/detailed_bill.dart';
part './widgets/your_orders.dart';
part './widgets/orders_error.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  static const double _floatingActionButtonGap = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [
        Obx(() {
          if (controller.hasError || controller.isCartItemsEmpty) {
            return const SizedBox.shrink();
          }
          return FavButton(
            isFav: controller.isRestaurantFav.value,
            onTap: controller.favButtonHandler,
          );
        }),
      ]),
      body: SizedBox(
        height: 1.sh - kToolbarHeight,
        child: Obx(() {
          if (controller.hasError) {
            return const OrdersError();
          }
          if (controller.isCartItemsEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your Cart is Empty',
                  style: TextStyle(
                    fontSize: 0.075.sw,
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.055.sh, width: 1.sw),
                SvgHelper.emptyCart(width: 0.35.sh),
                SizedBox(height: 0.055.sh),
                Text(
                  'Add something from the menu',
                  style: TextStyle(
                    fontSize: 0.045.sw,
                    color: Get.theme.primaryColorLight,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 0.055.sh, width: 1.sw),
              ],
            );
          }
          return Column(
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
              Flexible(
                fit: FlexFit.loose,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: (controller.floatingCartController.cartStyle
                                  ?.cartHeight ??
                              0.0) +
                          _floatingActionButtonGap,
                    ),
                    child: GetBuilder<OrdersController>(
                      id: controller.pageViewTag,
                      builder: (_) {
                        return controller.selectedIndex.value == 0
                            ? const _YourOrders()
                            : const _DetailedBill();
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: Obx(() {
        if (controller.hasError || controller.isCartItemsEmpty) {
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
