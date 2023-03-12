part of '../restaurant.dart';

class MenuCategoryBar extends GetView<RestaurantController> {
  const MenuCategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: Center(
        child: GetBuilder<RestaurantController>(
          id: controller.categoryBarTag,
          builder: (_) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: controller.hasMenuDataLoaded.value
                  ? const ScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                child: Row(
                  children: List.generate(
                    controller.hasMenuDataLoaded.value
                        ? controller.tabController.length
                        : 4,
                    (idx) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: controller.hasMenuDataLoaded.value
                            ? GetBuilder<RestaurantController>(
                                key: UniqueKey(),
                                id: controller.categoryChipsTag,
                                builder: (_) => _MenuCategoryChip(
                                  label: controller.isUnknownFoodType
                                      ? controller.categories[idx]
                                      : controller.filteredCategories[idx],
                                  isSelected:
                                      controller.tabController.index == idx,
                                  onTap: () =>
                                      controller.categoryOnTapHandler(idx),
                                ),
                              )
                            : loadingChip(),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget loadingChip() {
    return Shimmer.fromColors(
      baseColor: controller.shimmerStyle!.baseColor,
      highlightColor: controller.shimmerStyle!.highlightColor,
      enabled: !controller.hasMenuDataLoaded.value,
      child: Container(
        height: 32,
        width: 0.25.sw,
        decoration: const ShapeDecoration(
          shape: StadiumBorder(),
          color: Colors.white,
        ),
      ),
    );
  }
}

class _MenuCategoryChip extends GetView<RestaurantController> {
  const _MenuCategoryChip({
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 32, minHeight: 32),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: isSelected
              ? controller.chipStyle?.selectedBgColor
              : controller.chipStyle?.unSelectedBgColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            label,
            style: controller.fontStyles?.chipTextStyle.copyWith(
              color: isSelected
                  ? controller.chipStyle?.selectedTextColor
                  : controller.chipStyle?.unSelectedTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuCategoryBarDelegate extends SliverPersistentHeaderDelegate {
  _MenuCategoryBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Align(child: child);
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  bool shouldRebuild(_MenuCategoryBarDelegate oldDelegate) {
    return true;
  }
}
