import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/data/constants/debug.dart';
import 'package:zentro/data/enums/order_enums.dart';
import 'package:zentro/data/model/zentro_order.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_helpers/fs_db_helper.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/extended_colors_style.dart';
import 'package:zentro/theme/extensions/floating_cart_style.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/util/text_helper.dart';

import '../../widgets/restaurant_header/restaurant_header_controller.dart';

class OrderStatusController extends GetxController {
  late String _orderId;
  late String _restaurantId;
  StreamSubscription<DocumentSnapshot<ZentroOrder>>? _streamSubscription;
  ZentroOrder? order;

  final _orderStatus = OrderStatus.initialized.obs;
  OrderStatus get orderStatus => _orderStatus.value;
  set orderStatus(OrderStatus status) => _orderStatus.value = status;

  final List<OrderStatus> visibleOrderStatuses = [
    OrderStatus.initialized,
    OrderStatus.confirmed,
    OrderStatus.preparing,
    OrderStatus.ready,
  ];

  final _isOrderPaid = false.obs;
  bool get isOrderPaid => _isOrderPaid.value;
  set isOrderPaid(bool val) => _isOrderPaid.value = val;

  // Data Loader
  final hasRestaurantDataLoaded = false.obs;
  final hasOrderStatusLoaded = false.obs;
  final hasFavDataLoaded = false.obs;
  final isRestaurantFav = false.obs;

  // Design
  final fontStyles = Get.theme.extension<CustomFontStyles>();
  var shimmerStyle = Get.theme.extension<ShimmerStyle>();
  final cartStyle = Get.theme.extension<FloatingCartStyle>();
  final extendedStyle = Get.theme.extension<ExtendedColorsStyle>();

  // Getters
  FirebaseFireStoreHelper get _firestoreHelper {
    return FirebaseService.instance.fireStoreHelper;
  }

  TextStyle get cardHeaderTS => fontStyles!.header1.copyWith(fontSize: 16.r);

  // ERROR
  final _hasError = false.obs;
  bool get hasError => _hasError.value;
  set hasError(bool val) => _hasError.value = val;

  @override
  void onInit() async {
    _orderId = Get.parameters['orderId']!;
    debounce(
      isRestaurantFav,
      (val) => _toggleFavRestaurant(val),
      time: const Duration(milliseconds: 500),
    );

    await loadData();

    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }

  void _orderStreamSubscription() {
    _streamSubscription =
        _firestoreHelper.orderDocRef(_orderId).snapshots().listen(
      (snapshot) {
        order = snapshot.data();
        if (order != null) {
          isOrderPaid = order!.isPaid;
          orderStatus = order!.orderStatus;

          if (orderStatus == OrderStatus.completed) {
            Get.offNamed(AppRoutes.ORDER_COMPLETE);
          }
        }
      },
      onError: (_) => hasError = true,
    );
  }

  Future<void> loadData() async {
    // 1. Get Order Data from orderId
    _orderStreamSubscription();

    order ??= await _firestoreHelper.getOrder(_orderId);

    if (order == null) {
      hasError = true;
      return;
    }
    orderStatus = order!.orderStatus;

    hasOrderStatusLoaded.value = true;

    // 2. Find Restaurant Id from Order
    _restaurantId = order!.restId;

    // 3. Load Restaurant Data with restaurantId
    final restaurant = await Get.find<RestaurantHeaderController>()
        .loadRestaurantData(_restaurantId);
    if (restaurant == null) {
      hasError = true;
      return;
    }
    hasRestaurantDataLoaded.value = true;

    // 4. Load Fav data
    final isResFav =
        LocalStorageService.instance.checkIsRestaurantFav(_restaurantId);
    if (isResFav != null) {
      isRestaurantFav.value = isResFav;
    } else {
      isRestaurantFav.value =
          await _firestoreHelper.checkIsRestaurantFav(_restaurantId);
    }

    hasFavDataLoaded.value = true;
    hasError = false;
  }

  // ======== Fav Handlers ========

  void favButtonHandler() {
    if (!hasFavDataLoaded.value) return;
    isRestaurantFav.value = !isRestaurantFav.value;
  }

  void _toggleFavRestaurant(bool isAdded) {
    var userData = LocalStorageService.instance.getUserData();
    if (isAdded) {
      _firestoreHelper.addFavRestaurant(_restaurantId);
      userData.favRestaurants.addIf(
        !userData.favRestaurants.contains(_restaurantId),
        _restaurantId,
      );
    } else {
      _firestoreHelper.removeFavRestaurant(_restaurantId);
      userData.favRestaurants.remove(_restaurantId);
    }

    LocalStorageService.instance.insertUserData(userData);
  }

  // ====== Floating Payment ========
  void paymentOnTapHandler() {
    if (!hasRestaurantDataLoaded.value) return;
    if (isOrderPaid) return;

    Get.toNamed(AppRoutes.PAYMENT, parameters: {
      'restaurantId': _restaurantId,
      'orderId': _orderId,
    });
  }

  /// Helpers
  double textHeight(String text, TextStyle? ts) {
    return TextHelper.textSize(text, ts).height;
  }

  // ======== DEBUG MODE =========
  final debugSelectedOrderStatus = OrderStatus.initialized.obs;
  Future<void> updateOrderStatus() async {
    if (!DEBUG_MODE) return;

    _firestoreHelper
        .orderDocRef(_orderId)
        .update({OrderFields.orderStatus: debugSelectedOrderStatus.value.name});
    Get.close(1);
  }
}
