part of '../home.dart';

class _NearBySection extends GetView<HomeController> {
  const _NearBySection();

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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: _SubHeader(text: 'Near You'),
        ).inGridArea('header'),
        Obx(() {
          if (!controller.hasResDataLoaded.value) {
            return loading();
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: pagePadding),
              child: Row(
                children: List.generate(
                  controller.nearbyRestaurants!.length,
                  (i) => card('${controller.nearbyRestaurants![i]['name']}',
                      '${controller.nearbyRestaurants![i]['cacheFilePath']}'),
                ),
              ),
            ),
          );
        }).inGridArea('cards'),
      ],
    );
  }

  Widget card(String name, String filePath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: cardPadding),
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
            style: controller.fontStyle!.cardHeader,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget loading() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pagePadding),
      child: Shimmer.fromColors(
        baseColor: controller.shimmerStyle!.baseColor,
        highlightColor: controller.shimmerStyle!.highlightColor,
        enabled: !controller.hasResDataLoaded.value,
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
                      height: controller.textHeight,
                      decoration: cardDecoration.copyWith(
                        borderRadius: BorderRadius.all(
                          Radius.circular(controller.textHeight / 3),
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
