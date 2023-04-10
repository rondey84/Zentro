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
    if (ordersIds == null || ordersIds.isEmpty) {
      hasOrdersDataLoaded.value = true;
      return;
    }
    final orders = await _fireStore.getOrders(
      ordersIds.map((id) => id as String).toList(),
    );

    await Future.forEach(orders, (order) async {
      // Rest details
      final rest = await _fireStore.getRestaurantData(order.restId);
      //  Ratings info
      RestaurantRatings? rating;
      if (order.ratingId.isNotEmpty) {
        rating = await _fireStore.getRating(ratingId: order.ratingId);
      }
      // Menu Items details
      Map<MenuItem, int> orderItems = {};
      await Future.forEach(order.items.entries, (orderItem) async {
        final menuItem = await _fireStore.getMenuItemData(
          menuItemId: orderItem.key,
          restaurantId: order.restId,
        );

        if (menuItem != null) {
          orderItems[menuItem] = orderItem.value;
        }
      });

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
    });

    pastOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));

    hasOrdersDataLoaded.value = true;
  }

  void viewOrderDetail(UsersOrderItem orderDetail) {
    Get.toNamed(
      AppRoutes.USER_PROFILE +
          AppRoutes.USERS_ORDERS +
          AppRoutes.USER_ORDER_DETAIL,
      arguments: orderDetail,
    );
  }

  void showCurrentOrder(UsersOrderItem orderDetail) {
    Get.offNamedUntil(
      AppRoutes.ORDER_STATUS,
      ModalRoute.withName(AppRoutes.HOME),
      parameters: {
        'orderId': orderDetail.orderId,
      },
    );
  }
}
