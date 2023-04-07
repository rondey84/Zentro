part of '../home.dart';

class _ProfileHeader extends GetView<HomeController> {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: controller.navigateToProfile,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          padding: const EdgeInsets.fromLTRB(18, 8, 10, 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.username,
                      style: controller.fontStyles!.header1),
                  const SizedBox(height: 4),
                  Obx(() {
                    return Text(
                      controller.address.value,
                      style: controller.fontStyles!.caption,
                    );
                  }),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 60,
                width: 60,
                child: controller.profilePicture,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
