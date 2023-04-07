part of '../order_status.dart';

class _FloatingPaymentWidget extends GetView<OrderStatusController> {
  const _FloatingPaymentWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.paymentOnTapHandler,
      child: Container(
        height: controller.cartStyle?.cartHeight,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(controller.cartStyle?.borderRadius ?? 0.0)),
          color: controller.cartStyle?.cartColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  '₹${controller.order?.price ?? 0.0}',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.normal,
                    color: controller.cartStyle?.text01,
                  ),
                ),
              ),
            ),
            Text(
              'Pay Now',
              style: TextStyle(
                fontSize: 26,
                color: controller.cartStyle?.text00,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
