part of '../user_profile.dart';

class _ListItems extends GetView<UserProfileController> {
  const _ListItems();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: ListView.separated(
        itemBuilder: (_, index) => listTile(controller.listItems[index]),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: controller.listItems.length,
        shrinkWrap: true,
        // physics: const ScrollPhysics(),
      ),
    );
  }

  Widget listTile(user_model.UserProfileItem profileItem) {
    return GestureDetector(
      onTap: profileItem.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(0.06),
          borderRadius: const BorderRadius.all(Radius.circular(22)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: Get.theme.primaryColor,
              child: Icon(
                profileItem.iconData,
                color: Get.theme.colorScheme.primaryContainer,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                profileItem.text,
                style: controller.fontStyle!.body2,
              ),
            ),
            const SizedBox(width: 14),
            Icon(
              Icons.chevron_right_rounded,
              color: Get.theme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
