import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/restaurant_map/restaurant_map_controller.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:zentro/widgets/spaced_cards.dart';

class RestaurantMapScreen extends GetView<RestaurantMapController> {
  const RestaurantMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    border: Border.all(width: 4, color: Get.theme.cardColor),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: _mapWidget(),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  boxShadow: controller
                      .restaurantController.shadowStyles?.cardShadow01,
                  borderRadius: BorderRadius.all(Radius.circular(
                      controller.restaurantController.outerRadius)),
                ),
                clipBehavior: Clip.antiAlias,
                child: SpacedCards(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      FittedBox(
                        child: Text(
                          controller.restaurantController.restaurant!.name!,
                          style: controller
                              .restaurantController.fontStyles?.display,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('in 2 km'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mapWidget() {
    return const SizedBox.expand(child: Center(child: Text('Show Map here')));
  }
}
