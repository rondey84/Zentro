part of '../restaurant.dart';

class MenuTypeFilter extends GetView<RestaurantController> {
  const MenuTypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 260),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: controller.shadowStyles?.cardShadow01,
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: filterButton(
                    text: 'Veg',
                    color: controller.extendedColorsStyle?.vegColor,
                    type: FoodType.veg,
                    onTap: controller.vegFilterHandler,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: filterButton(
                    text: 'Non-veg',
                    color: controller.extendedColorsStyle?.nonVegColor,
                    type: FoodType.nonVeg,
                    onTap: controller.nonVegFilterHandler,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterButton({
    required String text,
    required FoodType type,
    Color? color,
    VoidCallback? onTap,
  }) {
    return Obx(() {
      bool isSelected = controller.selectedFilterType.value == type;
      return SpacedCards(
        borderRadius: controller.innerRadius,
        isSelected: isSelected,
        selectedColor: color,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            type.icon(color: isSelected ? Colors.white : color),
            const SizedBox(width: 8),
            Text(
              text,
              style: controller.fontStyles?.chipTextStyle.copyWith(
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      );
    });
  }
}
