part of '../orders.dart';

class _YourOrders extends GetView<OrdersController> {
  const _YourOrders();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      id: controller.yourOrdersTag,
      builder: (_) {
        if (controller.hasDataLoaded.value) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: ContainerCard(
                  child: ListView.separated(
                    itemCount: controller.cartItems.length,
                    shrinkWrap: true,
                    itemBuilder: (_, idx) {
                      return orderItem(
                        controller.cartItems.keys.elementAt(idx),
                        idx,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                  ),
                ),
              ),
              _addMoreButton(),
            ],
          );
        }
        return loadingOrder();
      },
    );
  }

  Widget _addMoreButton() {
    return GestureDetector(
      onTap: controller.addMoreHandler,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 260, minWidth: 260),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(60),
            color: controller.fontStyles?.button.color ?? Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            child: Center(
              child: Text(
                'Add more',
                style: controller.fontStyles?.button.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingOrder() {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) {
        return LoadingItem(
          enabled: !controller.hasDataLoaded.value,
          height: 60,
          borderRadius: 12,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }

  Widget orderItem(MenuItem menuItem, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.primaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              menuItem.name ?? '',
              style: controller.fontStyles?.body1.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(width: 12),
          GetBuilder<OrdersController>(
            id: controller.itemPriceTag,
            builder: (_) {
              var quantity = controller.cartItems.values.elementAt(index);
              return Text(
                '₹${menuItem.price! * quantity}',
                style: controller.fontStyles?.body2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
              );
            },
          ),
          const SizedBox(width: 8),
          _itemQuantityButton(index),
        ],
      ),
    );
  }

  Widget _itemQuantityButton(int index) {
    var height = 32.0;

    Widget icon(IconData iconData, VoidCallback? onTap) {
      return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Icon(
            iconData,
            color: controller.fontStyles?.button.color,
          ),
        ),
      );
    }

    return GetBuilder<OrdersController>(
        id: controller.itemQuantityButtonTag,
        builder: (_) {
          var quantity = controller.cartItems.values.elementAt(index);

          return Container(
            width: height * 2 + 10,
            decoration: BoxDecoration(
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon(
                  Icons.remove_rounded,
                  () => controller.decrementCartQuantity(index),
                ),
                Expanded(
                  child: SizedBox(
                    height: height,
                    child: Center(
                      child: Text(
                        '$quantity',
                        style: controller.fontStyles?.button.copyWith(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                icon(
                  Icons.add_rounded,
                  () => controller.incrementCartQuantity(index),
                ),
              ],
            ),
          );
        });
  }
}
