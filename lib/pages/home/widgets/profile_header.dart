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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                      style: controller.fontStyle!.header1),
                  Text(controller.address,
                      style: controller.fontStyle!.caption),
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
