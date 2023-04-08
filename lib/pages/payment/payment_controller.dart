import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/controllers/razorpay_controller.dart';
import 'package:zentro/controllers/stripe_controller.dart';
import 'package:zentro/data/enums/payment_enums.dart';
import 'package:zentro/data/model/zentro_order.dart';
import 'package:zentro/data/model/payment.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/services/user_cart_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/shadows_styles.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/util/text_helper.dart';
import 'package:zentro/widgets/cart/floating_cart_controller.dart';

class PaymentController extends GetxController {
  late String _restaurantId;
  String? _orderId;

  RazorpayController get razorPay => Get.find<RazorpayController>();
  StripeController get stripe => Get.find<StripeController>();
  // Design Params
  final fontStyles = Get.theme.extension<CustomFontStyles>();
  final shadowStyles = Get.theme.extension<ShadowStyles>();
  final shimmerStyle = Get.theme.extension<ShimmerStyle>();
  TextStyle get cardHeaderTS => fontStyles!.header1.copyWith(fontSize: 16.r);

  // Getters
  double get priceWithTax {
    return UserCartService.instance.userCart?.priceWithTax ?? 0.0;
  }

  // Data
  late Map<String, List<PaymentListItem>> onlinePaymentModes;
  late Map<String, List<PaymentListItem>> offlinePaymentModes;

  final _isPaymentDataLoading = false.obs;
  bool get isPaymentDataLoading => _isPaymentDataLoading.value;
  set isPaymentDataLoading(bool val) => _isPaymentDataLoading.value = val;

  @override
  void onInit() async {
    _restaurantId = Get.parameters['restaurantId']!;
    _orderId = Get.parameters['orderId'];
    await _initPaymentModes();
    super.onInit();
  }

  Future<void> _initPaymentModes() async {
    onlinePaymentModes = {
      'Wallets': [
        PaymentListItem(name: ''),
        PaymentListItem(name: ''),
      ],
      'Cards': [
        PaymentListItem(name: ''),
      ],
    };
    offlinePaymentModes = {
      _orderId != null ? 'Cash Payment' : 'Pay After Pickup': [
        PaymentListItem(name: '')
      ],
    };

    isPaymentDataLoading = true;

    onlinePaymentModes['Wallets']?.clear();
    onlinePaymentModes['Wallets'] = [
      PaymentListItem(
        name: 'Google Pay',
      ),
    ];

    isPaymentDataLoading = false;

    onlinePaymentModes['Cards'] = [
      PaymentListItem.detailed(
        title: 'Enter Card',
        description: 'Add Card details to pay',
        onSelect: () async => await stripe.cardPayment(
          amount: priceWithTax,
          onPaymentComplete: () => _onPaymentComplete(PaymentModes.card),
        ),
      )
    ];

    offlinePaymentModes[
        _orderId != null ? 'Cash Payment' : 'Pay After Pickup'] = [
      PaymentListItem(
          name: _orderId != null ? 'Pay with cash' : 'Cash/Pay on Pickup',
          onSelect: () {
            _onPaymentComplete(_orderId != null
                ? PaymentModes.cash
                : PaymentModes.payOnPickup);
          })
    ];
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
    _onPaymentComplete(PaymentModes.wallet);
  }

  Future<void> _onPaymentComplete(PaymentModes paymentMode) async {
    // STEP 1 - Create Order - Firestore db
    var order = _orderId != null
        ? await _updateOrder(paymentMode)
        : await _createOrder(paymentMode);

    if (_orderId == null) {
      // Step 2 - Store Order in Local Storage
      _updateOrderLocally(order!);

      // Step 3 - Clear Cart
      UserCartService.instance.clearCart();

      // Step 4 - Handle Floating Cart
      Get.find<FloatingCartController>().resetAndHide();

      // Step 5 - Navigate to OrderStatus Page
      Get.offNamedUntil(
        AppRoutes.ORDER_STATUS,
        ModalRoute.withName(AppRoutes.HOME),
        parameters: {
          'orderId': order.orderId,
        },
      );
    } else {
      // Step 5 - Navigate to OrderStatus Page
      Get.back();
    }
  }

  Future<ZentroOrder?> _updateOrder(PaymentModes paymentMode) async {
    var order =
        await FirebaseService.instance.fireStoreHelper.getOrder(_orderId!);

    var updatedOrder = order?.copyWith(
      isPaid: true,
      paymentType: paymentMode.name,
    );

    await FirebaseService.instance.fireStoreHelper.updateOrder(updatedOrder!);

    return updatedOrder;
  }

  Future<ZentroOrder> _createOrder(PaymentModes paymentMode) async {
    final fireStoreHelper = FirebaseService.instance.fireStoreHelper;

    // Generate Order ID
    var uuid = const Uuid();
    var now = DateTime.now();
    var timeId = now.microsecondsSinceEpoch.toString();
    var orderId =
        '${paymentMode.name.substring(0, 2)}-${uuid.v5(Uuid.NAMESPACE_OID, timeId)}';

    // Users Identifier
    var phoneNumber = LocalStorageService.instance.getUserData().phoneNumber;

    // Order Info
    var userCart = UserCartService.instance.userCart;
    if (userCart == null) throw Exception('Failed To receive order details');

    Map<String, int> orderItems = userCart.cartItems.map((menu, quantity) {
      return MapEntry(menu.id, quantity);
    });

    print(
        'SELECTED OUTLET: ${LocalStorageService.instance.getRestaurantData(_restaurantId)?.selectedOutlet}');

    // Create the Order Class
    var order = ZentroOrder(
      orderId: orderId,
      paymentType: paymentMode.name,
      createdAt: now,
      userRef: fireStoreHelper.userDocRef(phoneNumber),
      restId: _restaurantId,
      items: orderItems,
      price: userCart.priceWithTax,
      isPaid: paymentMode.prePaid,
      outlet: LocalStorageService.instance
          .getRestaurantData(_restaurantId)
          ?.selectedOutlet,
    );

    // Store the order in firestore db
    await fireStoreHelper.createOrder(order);
    await fireStoreHelper.insertUsersOrder(orderId);
    await fireStoreHelper.updateUserCurrentOrder(orderId);

    return order;
  }

  void _updateOrderLocally(ZentroOrder order) {
    var localStorageService = LocalStorageService.instance;
    var userData = localStorageService.getUserData();
    // Store order Id in local Storage
    userData.ordersId.addIf(
      !userData.ordersId.contains(order.orderId),
      order.orderId,
    );
    userData.currentOrderId = order.orderId;

    localStorageService.insertUserData(userData);
  }

  /// Helpers
  double textHeight(String text, TextStyle? ts) {
    return TextHelper.textSize(text, ts).height;
  }
}
