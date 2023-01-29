part of '../user_profile.dart';

class _ProfileHeader extends GetView<UserProfileController> {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(26)),
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.username,
                  style: controller.fontStyle!.header1,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                const SizedBox(height: 6),
                Text(
                  controller.email,
                  style: controller.fontStyle!.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  controller.phoneNumber,
                  style: controller.fontStyle!.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 110,
              width: 110,
              child: controller.profilePicture,
            ),
          ],
        ),
      ),
    );
  }
}
