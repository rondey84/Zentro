part of '../orders.dart';

class _DetailedBill extends GetView<OrdersController> {
  const _DetailedBill();

  @override
  Widget build(BuildContext context) {
    return ContainerCard(
      child: ListView(
        shrinkWrap: true,
        children: [
          listItem(
            'Items',
            '${controller.cartItems.values.fold(0, (a, b) => a + b)}',
          ),
          listItem(
            'Item Total',
            '₹${controller.userCart != null ? controller.userCart?.priceWithoutTax : ""}',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CustomPaint(
              painter: DashedLinePainter(
                dashColor: Get.theme.primaryColorLight.withOpacity(0.4),
              ),
            ),
          ),
          tax(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CustomPaint(
              painter: DashedLinePainter(
                dashColor: Get.theme.primaryColorLight.withOpacity(0.4),
              ),
            ),
          ),
          const SizedBox(height: 8),
          listItem(
            'To Pay',
            '₹${controller.userCart != null ? controller.userCart?.priceWithTax : ""}',
            textStyle: controller.fontStyles?.button,
          ),
        ],
      ),
    );
  }

  Widget tax() {
    double tax = 0.0;

    if (controller.userCart != null) {
      var taxPrice = controller.userCart?.priceWithTax ?? 0.0;
      var price = controller.userCart?.priceWithoutTax ?? 0.0;
      tax = (taxPrice - price).abs();
    }

    return listItem(
      'Taxes',
      tax > 0 ? '₹$tax' : '-',
    );
  }

  Widget listItem(
    String text,
    String value, {
    TextStyle? textStyle,
    TextStyle? valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: textStyle ??
                controller.fontStyles?.body1.copyWith(
                  fontSize: 14.r,
                ),
          ),
          Text(
            value,
            style: valueStyle ?? controller.fontStyles?.button,
          ),
        ],
      ),
    );
  }
}
