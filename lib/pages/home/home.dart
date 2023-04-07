import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/constants/debug.dart';
import 'package:zentro/data/enums/hero_tags.dart';
import 'package:zentro/data/enums/floating_cart_type.dart';
import 'package:zentro/pages/home/home_controller.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:zentro/services/firebase_helpers/fs_db_helper.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/widgets/cart/floating_cart_action.dart';
import 'package:zentro/widgets/custom_dialogs.dart';
import 'package:zentro/widgets/debug_content.dart';
import 'package:zentro/widgets/loading_item.dart';

part './widgets/profile_header.dart';
part './widgets/search_bar.dart';
part './widgets/sub_header.dart';
part './widgets/inside_campus_section.dart';
part './widgets/near_campus_section.dart';
part './widgets/current_order_card.dart';
part './widgets/debug_bar.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<HomeController>(
            id: controller.bodyTag,
            builder: (context) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Hero(
                      tag: HeroTag.profileHeader.tag,
                      child: const _ProfileHeader(),
                    ),
                  ),
                  if (DEBUG_MODE)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _DebugBarDelegate(
                        minHeight: 60,
                        maxHeight: 60,
                        child: const _DebugBar(),
                      ),
                    ),
                  if (controller.showSearch.value)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SearchBarDelegate(
                        minHeight: 60,
                        maxHeight: 60,
                        child: const _SearchBar(),
                      ),
                    ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 16),
                      const _InsideCampusSection(),
                      const SizedBox(height: 12),
                      Obx(() {
                        if (controller.currentActiveOrder.value.isNotEmpty) {
                          return Column(
                            children: const [
                              _CurrentOrderCard(),
                              SizedBox(height: 12)
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                      const _NearCampusSection(),
                      Obx(() {
                        if (controller.floatingCartController.showCart) {
                          return SizedBox(
                            height: (controller.floatingCartController.cartStyle
                                        ?.cartHeight ??
                                    0) +
                                24,
                          );
                        }
                        return const SizedBox(height: 24);
                      })
                    ]),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: Obx(() {
        if (controller.userDataHasLoaded.value) {
          return const FloatingCartActionWidget(
            cartType: FloatingCartType.home,
          );
        }
        return const SizedBox.shrink();
      }),
      floatingActionButtonLocation: controller.userDataHasLoaded.value
          ? controller.cartLocation
          : FloatingActionButtonLocation.centerFloat,
    );
  }
}
