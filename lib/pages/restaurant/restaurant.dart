import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zentro/data/enums/floating_cart_type.dart';
import 'package:zentro/data/enums/food_type_enum.dart';
import 'package:zentro/data/model/menu_item.dart';
import 'package:zentro/pages/restaurant/restaurant_controller.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/widgets/cart/floating_cart_action.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:zentro/widgets/fav_button.dart';
import 'package:zentro/widgets/spaced_cards.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:badges/badges.dart' as badges;

part 'widgets/menu_type_filter.dart';
part 'widgets/menu_category_bar.dart';
part 'widgets/menu_list.dart';
part 'widgets/menu_error.dart';

class RestaurantScreen extends GetView<RestaurantController> {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [
        Obx(() {
          if (controller.hasError) {
            return const SizedBox.shrink();
          }
          return FavButton(
            isFav: controller.isRestaurantFav.value,
            onTap: controller.favButtonHandler,
          );
        }),
      ]),
      body: Obx(() => controller.hasError
          ? const MenuError()
          : NestedScrollView(
              physics: const ScrollPhysics(parent: PageScrollPhysics()),
              headerSliverBuilder: (_, __) => [
                SliverToBoxAdapter(
                  child: RestaurantHeader(
                    showRatings: true,
                    actions: {
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: controller.theme.primaryColorLight,
                          ),
                          const SizedBox(width: 8),
                          Text('2.2 km away',
                              style: controller.fontStyles?.body2),
                        ],
                      ): controller.locationButtonHandler,
                      Obx(() => badges.Badge(
                            showBadge: controller.selectedFilterType.value !=
                                    FoodType.unknown &&
                                !controller.menuTypeFilterVisible.value,
                            child: Icon(
                              Icons.filter_list_rounded,
                              color: controller.theme.primaryColorLight,
                            ),
                          )): controller.filterButtonHandler,
                      Icon(
                        Icons.share,
                        color: controller.theme.primaryColorLight,
                      ): controller.shareButtonHandler,
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: GetBuilder<RestaurantController>(
                    id: controller.menuFilterTag,
                    builder: (_) {
                      if (controller.menuTypeFilterVisible.value) {
                        return TweenAnimationBuilder(
                          tween: Tween<Offset>(
                            begin: const Offset(0, -0.5),
                            end: Offset.zero,
                          ),
                          duration: const Duration(milliseconds: 250),
                          builder: (_, offset, __) {
                            return FractionalTranslation(
                              translation: offset,
                              child: const MenuTypeFilter(),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _MenuCategoryBarDelegate(
                    minHeight: 52,
                    maxHeight: 52,
                    child: const MenuCategoryBar(),
                  ),
                ),
              ],
              body: const MenuList(),
            )),
      floatingActionButton: Obx(() {
        if (controller.hasError) {
          return const SizedBox.shrink();
        } else {
          return const FloatingCartActionWidget(
            cartType: FloatingCartType.restaurant,
          );
        }
      }),
      floatingActionButtonLocation: controller.cartLocation,
    );
  }
}
