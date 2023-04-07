part of '../home.dart';

class _DebugBar extends GetView<HomeController> {
  const _DebugBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: GestureDetector(
        onTap: () async {
          await CustomDialogs.animatedDialog(
            barrierDismissible: true,
            barrierLabel: 'Debug Dialog',
            child: const DebugContent(),
          );
        },
        child: Container(
          constraints: const BoxConstraints(maxWidth: 360),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 42, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.settings_rounded,
                color: controller.fontStyles?.button.color,
              ),
              const SizedBox(width: 8),
              Text('Debug Button', style: controller.fontStyles?.button),
            ],
          ),
        ),
      ),
    );
  }
}

class _DebugBarDelegate extends SliverPersistentHeaderDelegate {
  _DebugBarDelegate({
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
  bool shouldRebuild(_DebugBarDelegate oldDelegate) {
    return true;
  }
}
