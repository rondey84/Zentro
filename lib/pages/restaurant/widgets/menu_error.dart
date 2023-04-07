part of '../restaurant.dart';

class MenuError extends GetView<RestaurantController> {
  const MenuError({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.loadData,
      child: SizedBox(
        height: 1.sh - kToolbarHeight,
        width: 1.sw,
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgHelper.somethingWentWrong(
                  primaryColor: Get.theme.primaryColor,
                ),
                const SizedBox(height: 50),
                Text(
                  'Something Went Wrong',
                  style: TextStyle(
                    fontSize: 22.r,
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Scroll Down to Retry',
                  style: TextStyle(
                    fontSize: 16.r,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
