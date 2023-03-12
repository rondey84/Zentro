import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zentro/widgets/spaced_cards.dart';

import 'restaurant_header_controller.dart';

class RestaurantHeader extends GetView<RestaurantHeaderController> {
  const RestaurantHeader({
    super.key,
    this.showRatings = false,
    this.actions = const {},
  });

  final bool showRatings;
  final Map<Widget, VoidCallback?> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: controller.shadowStyles?.cardShadow01,
          borderRadius:
              BorderRadius.all(Radius.circular(controller.outerRadius)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Obx(() {
              if (!controller.hasRestaurantDataLoaded.value) {
                return loadingHeader();
              }
              return heading();
            }),
            const SizedBox(height: 4),
            if (actions.isNotEmpty) actionsRow()
          ],
        ),
      ),
    );
  }

  Widget loadingHeader() {
    double calcHeight = controller.textHeight(
            'Sample', controller.fontStyles?.display) +
        4 +
        controller.textHeight('Sample' * 20, controller.fontStyles?.caption) +
        16 * 2;
    return Shimmer.fromColors(
      baseColor: controller.shimmerStyle!.baseColor,
      highlightColor: controller.shimmerStyle!.highlightColor,
      enabled: !controller.hasRestaurantDataLoaded.value,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(controller.innerRadius)),
        ),
        height: calcHeight,
        width: double.infinity,
      ),
    );
  }

  Widget heading() {
    return SpacedCards(
      padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
      borderRadius: controller.innerRadius,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.restaurant!.name!,
                  style: controller.fontStyles?.display,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  controller.restaurant!.shortDescription!,
                  style: controller.fontStyles?.caption,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (showRatings) const SizedBox(width: 4),
          if (showRatings)
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: LayoutGrid(
                  columnSizes: const [auto],
                  rowSizes: const [auto, auto],
                  rowGap: 2,
                  areas: '''
                    value 
                    text 
                  ''',
                  gridFit: GridFit.loose,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.stars_rounded,
                          size: 14,
                          color:
                              controller.extendedColorsStyle?.ratingsIconColor,
                        ),
                        const SizedBox(width: 6),
                        // TODO: Fetch Data from server
                        Text('4.5', style: controller.fontStyles?.body2)
                      ],
                    ).inGridArea('value'),
                    Center(
                      child: Text(
                        'Ratings',
                        style: controller.fontStyles?.caption,
                        textAlign: TextAlign.center,
                      ),
                    ).inGridArea('text')
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget actionsRow() {
    List<Widget> widgets = [];

    // Adding the first widget
    widgets.add(Expanded(
      child: SpacedCards(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        borderRadius: controller.innerRadius,
        onTap: actions.values.first,
        child: actions.keys.first,
      ),
    ));

    if (actions.length > 1) {
      for (var i = 1; i < actions.length; i++) {
        widgets.add(const SizedBox(width: 4));
        widgets.add(SpacedCards(
          borderRadius: controller.innerRadius,
          onTap: actions.values.toList()[i],
          child: actions.keys.toList()[i],
        ));
      }
    }

    return Row(children: widgets);
  }
}
