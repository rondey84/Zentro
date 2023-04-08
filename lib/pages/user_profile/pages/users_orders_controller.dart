part of '../user_profile.dart';

class UsersOrdersController extends GetxController {
  final _fireStore = FirebaseService.instance.fireStoreHelper;
  String header = 'Your Orders';

  final hasOrdersDataLoaded = false.obs;
  List<user_model.UsersOrderItem> usersOrders = [];

  final extendedColorsStyle = Get.theme.extension<ExtendedColorsStyle>();

  @override
  void onInit() {
    _fetchData();
    super.onInit();
  }

  Future<void> _fetchData() async {
    final ordersIds = await _fireStore.userOrdersData;
    final orders = await _fireStore.getOrders(
      ordersIds?.map((id) => id as String).toList() ?? [],
    );

    await Future.forEach(orders, (order) async {
      // Rest details
      final rest = await _fireStore.getRestaurantData(order.restId);
      //  Ratings info
      RestaurantRatings? rating;
      if (order.ratingId.isNotEmpty) {
        rating = await _fireStore.getRating(ratingId: order.ratingId);
      }

      Map<String, int> orderItems = {};
      await Future.forEach(order.items.entries, (orderItem) async {
        final menuItem = await _fireStore.getMenuItemData(
          menuItemId: orderItem.key,
          restaurantId: order.restId,
        );

        if (menuItem != null) {
          orderItems[menuItem.name ?? orderItem.key] = orderItem.value;
        }
      });

      final usersOrder = user_model.UsersOrderItem(
        orderId: order.orderId,
        isOrderPickedUp: order.orderStatus == OrderStatus.completed,
        totalPrice: order.price,
        orderDate: order.createdAt,
        orderItems: orderItems,
        restId: order.restId,
        restName: rest?.name ?? '',
        restOutlet: order.outlet,
        ratingId: rating?.ratingId,
        rating: rating?.rating,
      );

      usersOrders.add(usersOrder);
    });

    usersOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));

    hasOrdersDataLoaded.value = true;
  }
}
