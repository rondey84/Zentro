part of '../orders.dart';

class _TabBar extends GetView<OrdersController> {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
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
                Expanded(child: tabButton('Your Orders')),
                const SizedBox(width: 4),
                Expanded(child: tabButton('Detailed Bill')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tabButton(String text) {
    return SpacedCards(
      child: Center(child: Text(text)),
    );
  }
}
