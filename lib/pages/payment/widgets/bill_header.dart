part of '../payment.dart';

class _BillHeader extends GetView<PaymentController> {
  const _BillHeader();

  @override
  Widget build(BuildContext context) {
    return SpacedCards(
      borderRadius: 12,
      boxShadow: controller.shadowStyles?.cardShadow01,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Bill Total',
            style: controller.fontStyles?.header1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Text(
              '₹${controller.priceWithTax}',
              style: controller.fontStyles?.cardTitle,
            ),
          )
        ],
      ),
    );
  }
}
