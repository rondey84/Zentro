part of '../home.dart';

class _NearCampusSection extends GetView<HomeController> {
  const _NearCampusSection();

  final double cardHeight = 280;
  final BoxDecoration cardDecoration = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(24)),
    color: Colors.white,
  );
  final double gap = 4;
  final double pagePadding = 8;
  final double cardPadding = 8;

  @override
  Widget build(BuildContext context) {
    return LayoutGrid(
      areas: '''
        header
        cards
      ''',
      columnSizes: [1.fr],
      rowSizes: const [auto, auto],
      rowGap: 8,
      gridFit: GridFit.passthrough,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Obx(() => _SubHeader(text: controller.sectionTwoHeader.value)),
        ).inGridArea('header'),
        Obx(
          () {
            if (!controller.hasNearCampusDataLoaded.value) {
              return loading();
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: pagePadding),
                child: Row(
                  children: List.generate(
                    controller.nearCampusRestaurants!.length,
                    (i) => card(
                      id: controller.nearCampusRestaurants![i]
                          [RestaurantFields.id],
                      name: controller.nearCampusRestaurants![i]
                              [RestaurantFields.name] ??
                          '',
                      cacheImagePath: controller.nearCampusRestaurants![i]
                          ['cacheFilePath'],
                      rating: controller.nearCampusRestaurants![i]
                          [RatingFields.rating],
                      locality: controller.nearCampusRestaurants![i]
                          [RestaurantFields.inAppSubLocality],
                    ),
                  ),
                ),
              ),
            );
          },
        ).inGridArea('cards'),
      ],
    );
  }

  Widget card({
    String? id,
    required String name,
    String? rating,
    String? locality,
    required String? cacheImagePath,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: cardPadding),
      child: GestureDetector(
        onTap: () => controller.navigateToRestaurant(restaurantId: id ?? ''),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: cardHeight * 0.7,
              height: cardHeight,
              decoration: cardDecoration.copyWith(
                image: cacheImagePath != null
                    ? DecorationImage(
                        image: FileImage(File(cacheImagePath)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              margin: EdgeInsets.only(bottom: gap),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(name, style: controller.fontStyles?.cardTitle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (rating != null)
                    Icon(
                      Icons.star_rate_rounded,
                      size: 16,
                      color: controller.fontStyles?.body2.color,
                    ),
                  if (rating != null) const SizedBox(width: 4),
                  if (rating != null)
                    Text(rating, style: controller.fontStyles?.body2),
                  if (rating != null) const SizedBox(width: 16),
                  if (locality != null)
                    Text(locality, style: controller.fontStyles?.body2)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loading() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pagePadding),
      child: LoadingItem(
        enabled: !controller.hasNearCampusDataLoaded.value,
        child: Row(
          children: List.generate(2, (idx) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: cardHeight,
                      decoration: cardDecoration,
                      margin: EdgeInsets.only(bottom: gap),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 40, 2),
                      child: Container(
                        height: controller.textHeight(
                              'Sample',
                              controller.fontStyles?.cardTitle,
                            ) -
                            4,
                        decoration: cardDecoration.copyWith(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 80, 3),
                      child: Container(
                        height: controller.textHeight(
                              'Sample',
                              controller.fontStyles?.body2,
                            ) -
                            6,
                        decoration: cardDecoration.copyWith(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
