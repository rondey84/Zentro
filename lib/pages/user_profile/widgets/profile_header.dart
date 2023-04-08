part of '../user_profile.dart';

class _ProfileHeader extends GetView<UserProfileController> {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ContainerCard(
        shadowStyle: ShadowStyle.style1,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 26,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.username,
                  style: controller.fontStyles!.header1,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                const SizedBox(height: 6),
                Text(
                  controller.email,
                  style: controller.fontStyles!.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  controller.phoneNumber,
                  style: controller.fontStyles!.caption,
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
