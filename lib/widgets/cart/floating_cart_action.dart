import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/hero_tags.dart';
import 'package:zentro/data/enums/floating_cart_type.dart';
import 'package:zentro/widgets/cart/floating_cart_controller.dart';

class FloatingCartActionWidget extends GetView<FloatingCartController> {
  final FloatingCartType cartType;
  const FloatingCartActionWidget({super.key, required this.cartType});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.showCart) {
        return GestureDetector(
          onTap: cartType == FloatingCartType.home
              ? null
              : () => controller.onTapHandler(cartType),
          child: Container(
            height: controller.cartStyle?.cartHeight,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: cartType == FloatingCartType.home
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(controller.cartStyle?.borderRadius ?? 0.0)),
              color: controller.cartStyle?.cartColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: cartType == FloatingCartType.restaurant
                  ? _restaurant()
                  : cartType == FloatingCartType.home
                      ? _home()
                      : cartType == FloatingCartType.order
                          ? []
                          : cartType == FloatingCartType.orderStatus
                              ? []
                              : [],
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }

  List<Widget> _home() {
    List<Widget> homeWidgets = [];

    var restImgUrl = controller.restaurantImageUrl;
    var restImgPath = controller.restaurantImagePath;
    var restName = controller.restaurantName;

    homeWidgets.add(Expanded(
      child: GestureDetector(
        onTap: cartType != FloatingCartType.home
            ? null
            : controller.restaurantNavigator,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (restImgUrl != null || restImgPath != null)
              Container(
                height: controller.cartStyle?.cartHeight,
                width: controller.cartStyle?.cartHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      controller.cartStyle?.borderRadius ?? 0.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: restImgPath != null
                    ? Image.file(File(restImgPath), fit: BoxFit.cover)
                    : Image.network(restImgUrl!, fit: BoxFit.cover),
              ),
            if (restImgUrl != null || restImgPath != null)
              const SizedBox(width: 10),
            if (restName != null)
              Expanded(
                child: Text(
                  restName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: controller.cartStyle?.restaurantNameTS,
                ),
              ),
            if (restName != null) const SizedBox(width: 10),
          ],
        ),
      ),
    ));

    homeWidgets.add(GestureDetector(
      onTap: cartType != FloatingCartType.home
          ? null
          : () => controller.onTapHandler(cartType),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: controller.cartStyle?.cartHeight,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(controller.cartStyle?.borderRadius ?? 0.0),
          color: controller.cartStyle?.miniBoxColor,
          border: Border.all(
            width: 1,
            color: Get.theme.primaryColor,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _heroWidget(
                  HeroTag.cartItemCount,
                  Text(
                    '${controller.itemQuantity} item${controller.itemQuantity > 1 ? "s" : ""}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: controller.cartStyle?.text02,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 12,
                  width: 1,
                  color: controller.cartStyle?.text02.withOpacity(0.4),
                ),
                const SizedBox(width: 8),
                _heroWidget(
                  HeroTag.cartPriceValue,
                  Text(
                    '₹${controller.priceWithoutTax}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: controller.cartStyle?.text02,
                    ),
                  ),
                ),
              ],
            ),
            _heroWidget(
              HeroTag.cartMainText,
              Text(
                'View Order',
                style: TextStyle(
                  fontSize: 22,
                  color: controller.cartStyle?.text00,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ));

    return homeWidgets;
  }

  List<Widget> _restaurant() {
    List<Widget> restaurantWidgets = [];

    restaurantWidgets.add(Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _heroWidget(
            HeroTag.cartItemCount,
            Text(
              '${controller.itemQuantity} item${controller.itemQuantity > 1 ? "s" : ""}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: controller.cartStyle?.text04,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              _heroWidget(
                HeroTag.cartPriceValue,
                Text(
                  '₹${controller.priceWithoutTax}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: controller.cartStyle?.text01,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                'plus taxes',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: controller.cartStyle?.text05,
                ),
              ),
            ],
          ),
        ],
      ),
    ));

    restaurantWidgets.add(
      _heroWidget(HeroTag.cartMainText, mainText('View Order')),
    );

    return restaurantWidgets;
  }

  Widget mainText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 26,
        color: controller.cartStyle?.text00,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _heroWidget(HeroTag tag, Widget child) {
    return Hero(
      tag: tag.tag,
      child: Material(
        type: MaterialType.transparency,
        child: child,
      ),
    );
  }
}
