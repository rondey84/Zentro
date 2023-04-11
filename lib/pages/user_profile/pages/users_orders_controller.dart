part of '../user_profile.dart';

class UsersOrdersController extends GetxController {
  final _fireStore = FirebaseService.instance.fireStoreHelper;
  String header = 'Your Orders';

  final hasOrdersDataLoaded = false.obs;
  user_model.UsersOrderItem? currentOrder;
  List<user_model.UsersOrderItem> pastOrders = [];

  final extendedColorsStyle = Get.theme.extension<ExtendedColorsStyle>();
  final fontStyles = Get.theme.extension<CustomFontStyles>();

  @override
  void onInit() {
    _fetchData();
    super.onInit();
  }

  Future<void> _fetchData() async {
    final ordersIds = await _fireStore.userOrdersData;
    final orders = ordersIds == null || ordersIds.isEmpty
        ? <ZentroOrder>[]
        : await _fireStore.getOrders(
            // using List.from() to create a fixed-length list from the ordersIds iterable.
            // Using a fixed-length list with growable: false can save memory.
            List.from(ordersIds, growable: false).cast<String>(),
          );

    // Process orders
    for (final order in orders) {
      // Rest & Ratings parallel future fetch
      final restFuture = _fireStore.getRestaurantData(order.restId);
      final ratingFuture = order.ratingId.isNotEmpty
          ? _fireStore.getRating(ratingId: order.ratingId) as Future<dynamic>
          : null;
      final results = await Future.wait(<Future<dynamic>>[
        restFuture,
        if (ratingFuture != null) ratingFuture
      ]);
      final rest = results[0] as Restaurant?;
      final rating =
          results.length > 1 ? results[1] as RestaurantRatings? : null;

      // Menu Items details
      Map<MenuItem, int> orderItems = {};
      for (final orderItem in order.items.entries) {
        final menuItem = await _fireStore.getMenuItemData(
          menuItemId: orderItem.key,
          restaurantId: order.restId,
        );
        if (menuItem != null) {
          orderItems[menuItem] = orderItem.value;
        }
      }

      final usersOrder = user_model.UsersOrderItem(
        orderId: order.orderId,
        isOrderPickedUp: order.orderStatus == OrderStatus.completed,
        totalPrice: order.price,
        orderDate: order.createdAt,
        orderItems: orderItems,
        paymentType: order.paymentType,
        restId: order.restId,
        restName: rest?.name ?? '',
        restOutlet: order.outlet,
        rating: rating,
      );

      if (order.orderStatus == OrderStatus.completed ||
          order.orderStatus == OrderStatus.canceled) {
        pastOrders.add(usersOrder);
      } else {
        currentOrder = usersOrder;
      }
    }

    hasOrdersDataLoaded.value = true;
  }

  void viewOrderDetail(user_model.UsersOrderItem orderDetail) {
    Get.toNamed(
      AppRoutes.USER_PROFILE +
          AppRoutes.USERS_ORDERS +
          AppRoutes.USER_ORDER_DETAIL,
      arguments: orderDetail,
    );
  }

  void showCurrentOrder(user_model.UsersOrderItem orderDetail) {
    Get.offNamedUntil(
      AppRoutes.ORDER_STATUS,
      ModalRoute.withName(AppRoutes.HOME),
      parameters: {
        'orderId': orderDetail.orderId,
      },
    );
  }
}
