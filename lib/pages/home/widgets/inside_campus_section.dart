part of '../home.dart';

class _InsideCampusSection extends GetView<HomeController> {
  const _InsideCampusSection();

  final double cardHeight = 120;
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
          child: Obx(() => _SubHeader(text: controller.sectionOneHeader.value)),
        ).inGridArea('header'),
        Obx(() {
          if (!controller.hasInCampusDataLoaded.value) {
            return loading();
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: pagePadding),
              child: Row(
                children: List.generate(
                  controller.inCampusRestaurants!.length,
                  (i) {
                    return card(
                      id: controller.inCampusRestaurants![i]
                          [RestaurantFields.id],
                      name: controller.inCampusRestaurants![i]
                              [RestaurantFields.name] ??
                          '',
                      filePath:
                          '${controller.inCampusRestaurants![i]['cacheFilePath']}',
                    );
                  },
                ),
              ),
            ),
          );
        }).inGridArea('cards'),
      ],
    );
  }

  Widget card({String? id, required String name, required String filePath}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: cardPadding),
      child: GestureDetector(
        onTap: () => controller.navigateToRestaurant(restaurantId: id ?? ''),
        child: Column(
          children: [
            Container(
              width: 220,
              height: cardHeight,
              decoration: cardDecoration.copyWith(
                image: DecorationImage(
                  image: FileImage(File(filePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: gap),
            Text(
              name,
              style: controller.fontStyles!.cardHeader,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget loading() {
    double textHeight = controller.textHeight(
      'Sample',
      controller.fontStyles?.cardHeader,
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pagePadding),
      child: LoadingItem(
        enabled: !controller.hasInCampusDataLoaded.value,
        child: Row(
          children: List.generate(2, (idx) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: cardPadding),
                child: Column(
                  children: [
                    Container(height: cardHeight, decoration: cardDecoration),
                    SizedBox(height: gap),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      height: textHeight,
                      decoration: cardDecoration.copyWith(
                        borderRadius: BorderRadius.all(
                          Radius.circular(textHeight / 3),
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
