part of '../user_profile.dart';

class UsersFavRestaurant extends GetView<UsersFavRestController> {
  const UsersFavRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text(controller.header)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            if (controller.hasOrdersDataLoaded.value) {
              return AnimatedList(
                key: controller.listKey,
                shrinkWrap: true,
                initialItemCount: controller.favRestaurants.length,
                itemBuilder: _buildItem,
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              itemBuilder: (_, __) => const LoadingItem(),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: 6,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRemovedItem(BuildContext context, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: ContainerCard(
        borderRadius: 22,
        padding: const EdgeInsets.all(16),
        shadowStyle: ShadowStyle.noShadow,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Removed',
                style: TextStyle(
                  fontSize: 18.r,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.customColor()?.text06,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(width: 8),
            const FavButton(isFav: false),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    final restDetail = controller.favRestaurants[index];
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: ContainerCard(
        borderRadius: 22,
        padding: const EdgeInsets.all(16),
        shadowStyle: ShadowStyle.noShadow,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                restDetail.name ?? '',
                style: TextStyle(
                  fontSize: 18.r,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.customColor()?.text06,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(width: 8),
            FavButton(
              isFav: true,
              onTap: () async {
                await controller.removeFavRestaurant(index);
                controller.favRestaurants
                    .removeAt(controller.removeIndex.value);
                controller.listKey.currentState?.removeItem(
                  controller.removeIndex.value,
                  (_, ani) {
                    return _buildRemovedItem(context, ani);
                  },
                  duration: const Duration(milliseconds: 350),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
