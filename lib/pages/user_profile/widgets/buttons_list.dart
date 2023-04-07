part of '../user_profile.dart';

class _ButtonsList extends GetView<UserProfileController> {
  const _ButtonsList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Row(
        children: [
          card(text: 'Likes', iconData: Icons.favorite_border_rounded),
          card(text: 'Ratings', iconData: Icons.star_border_rounded),
          card(text: 'Settings', iconData: Icons.settings),
        ],
      ),
    );
  }

  Widget card({
    required String text,
    required IconData iconData,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Get.theme.primaryColor,
                child: Icon(
                  iconData,
                  size: 40,
                  color: Get.theme.colorScheme.primaryContainer,
                ),
              ),
              const SizedBox(height: 4),
              Text(text, style: controller.fontStyles!.caption),
            ],
          ),
        ),
      ),
    );
  }
}
