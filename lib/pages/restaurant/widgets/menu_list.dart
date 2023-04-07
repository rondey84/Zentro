part of '../restaurant.dart';

class MenuList extends GetView<RestaurantController> {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(
      id: controller.menuListTag,
      builder: (_) {
        if (controller.hasMenuDataLoaded.value) {
          if (!controller.isUnknownFoodType &&
              controller.filteredCategories.isEmpty) {
            return emptyMenu();
          }
          return menuTabBarView();
        }
        return loadingMenu();
      },
    );
  }

  Widget emptyMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'No Menu Items Found',
          style: TextStyle(
            fontSize: 0.055.sw,
            color: Get.theme.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 0.035.sh, width: 1.sw),
        SvgHelper.cooking(
          width: 0.55.sw,
        ),
        SizedBox(height: 0.035.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'We apologize, but it seems that there are no menu items that match your search.',
            style: TextStyle(
              fontSize: 0.04.sw,
              color: Get.theme.primaryColorLight,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.055.sh, width: 1.sw),
      ],
    );
  }

  Widget loadingMenu() {
    return Column(
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: LoadingItem(
            enabled: !controller.hasMenuDataLoaded.value,
            height: 0.12.sh,
            width: 1.sw,
            borderRadius: 12,
          ),
        );
      }),
    );
  }

  Widget menuTabBarView() {
    return TabBarView(
      controller: controller.tabController,
      physics: const ScrollPhysics(parent: PageScrollPhysics()),
      children: List.generate(
        controller.isUnknownFoodType
            ? controller.categories.length
            : controller.filteredCategories.length,
        (index) {
          var menuItems = controller.menuItemsMap[(controller.isUnknownFoodType
              ? controller.categories
              : controller.filteredCategories)[index]]!;
          return Obx(() => ListView.builder(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: controller.floatingCartController.showCart
                      ? 16 +
                          (controller.floatingCartController.cartStyle
                                  ?.cartHeight ??
                              0.0)
                      : 0,
                ),
                itemCount: menuItems.length,
                itemBuilder: (_, idx) => _menuItem(menuItem: menuItems[idx]),
              ));
        },
      ),
    );
  }

  Widget _menuItem({required MenuItem menuItem}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, top: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(controller.menuItemStyle?.cardBR ?? 0)),
        color: Get.theme.cardColor,
        boxShadow: controller.shadowStyles?.cardShadow02,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Image
          Container(
            height: 116,
            decoration: BoxDecoration(
              image: menuItem.image != null
                  ? DecorationImage(
                      image: FileImage(File(menuItem.image!)),
                      fit: BoxFit.cover)
                  : null,
              borderRadius: BorderRadius.all(
                Radius.circular(controller.menuItemStyle?.cardBR ?? 0),
              ),
              color: Get.theme.cardColor,
            ),
          ),
          // Details
          Padding(
            padding:
                controller.menuItemStyle?.contentPadding ?? EdgeInsets.zero,
            child: Column(
              children: [
                // Name and Price
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        menuItem.name ?? '',
                        style: controller.menuItemStyle?.nameTS,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: controller.menuItemStyle?.contentSpacing),
                    Text(
                      '${controller.menuItemStyle?.priceSymbol ?? ''} ${menuItem.price?.floor() ?? ''}',
                      style: controller.menuItemStyle?.priceTS,
                      maxLines: 1,
                    ),
                  ],
                ),
                SizedBox(height: controller.menuItemStyle?.contentSpacing),
                // Ratings and Type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (menuItem.ratingsValue != 0)
                      RatingBar(
                        initialRating: 2.2,
                        itemCount: 5,
                        itemSize: controller.menuItemStyle?.iconSize ?? 24,
                        allowHalfRating: true,
                        ratingWidget: RatingWidget(
                          full: Icon(
                            Icons.star_rounded,
                            color: controller.menuItemStyle?.ratingsColor,
                          ),
                          half: Icon(
                            Icons.star_half_rounded,
                            color: controller.menuItemStyle?.ratingsColor,
                          ),
                          empty: Icon(
                            Icons.star_border_rounded,
                            color: controller.menuItemStyle?.ratingsColor,
                          ),
                        ),
                        onRatingUpdate: (_) {},
                        direction: Axis.horizontal,
                        ignoreGestures: true,
                      ),
                    if (menuItem.ratingsValue != 0)
                      SizedBox(width: controller.menuItemStyle?.contentSpacing),
                    Text(
                      menuItem.ratingsCount > 0
                          ? '${menuItem.ratingsCount}'
                          : 'No Ratings',
                      style: controller.menuItemStyle?.ratingsTS,
                      maxLines: 1,
                    ),
                    const Spacer(),
                    SizedBox(width: controller.menuItemStyle?.contentSpacing),
                    (menuItem.isVeg ? FoodType.veg : FoodType.nonVeg).icon(),
                  ],
                ),
                SizedBox(height: controller.menuItemStyle?.contentSpacing),
                // Description and Add to Cart
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        menuItem.description ?? '',
                        style: controller.menuItemStyle?.descriptionTS,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(width: controller.menuItemStyle?.contentSpacing),
                    _addToCartButton(menuItem: menuItem),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addToCartButton({required MenuItem menuItem}) {
    double widgetHeight = 30;

    Widget icon(IconData iconData, VoidCallback? onIconTap) {
      return GestureDetector(
        onTap: onIconTap,
        child: SizedBox(
          width: widgetHeight,
          height: widgetHeight,
          child: Icon(
            iconData,
            color: controller.fontStyles?.button.color,
          ),
        ),
      );
    }

    return GetBuilder<RestaurantController>(
      id: controller.addToCarButtonTag,
      builder: (_) {
        bool isAdded = controller.userCartService.isMenuItemInCart(menuItem);

        return GestureDetector(
          onTap: isAdded ? null : () => controller.addToCardHandler(menuItem),
          child: Container(
            width: widgetHeight * 2 + 30,
            decoration: ShapeDecoration(
              shape: StadiumBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignInside,
                  color:
                      controller.fontStyles?.button.color ?? Colors.transparent,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (isAdded)
                  icon(
                    Icons.remove_rounded,
                    () => controller.decrementCartQuantity(menuItem),
                  ),
                Expanded(
                  child: SizedBox(
                    height: widgetHeight,
                    child: Center(
                      child: Text(
                        isAdded
                            ? (controller.userCartService
                                        .menuItemQuantity(menuItem) ??
                                    0)
                                .toString()
                            : 'Add',
                        style: controller.fontStyles?.button.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                if (isAdded)
                  icon(
                    Icons.add_rounded,
                    () => controller.incrementCartQuantity(menuItem),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
