import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:zentro/data/enums/env_keys.dart';
import 'package:zentro/data/enums/payment_enums.dart';
import 'package:zentro/data/enums/remote_config_key.dart';
import 'package:zentro/services/local_storage_service.dart';

class RazorpayController extends GetxController {
  // Controller instance
  static final instance = Get.find<RazorpayController>();

  // Razorpay Instance
  final _razorpay = Razorpay();

  // Payment Options
  late final Map<String, dynamic> _options;

  @override
  void onInit() {
    _initListeners();
    _initPaymentOptions();
    super.onInit();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void _initListeners() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  void _initPaymentOptions() {
    // Load Public Key
    var publicKey =
        dotenv.maybeGet(EnvKeys.razorpayTestKey.key, fallback: null);
    if (publicKey == null) {
      throw Exception('Failed to make connection to Razorpay Gateway');
    }

    // Load Receiver Name
    var name = RemoteConfigKey.paymentDisplayName.value as String?;
    name ??= 'Zentro';

    // Transaction Timeout
    var timeout = RemoteConfigKey.paymentTimeout.value as int?;

    // User details
    var user = LocalStorageService.instance.getUserData();

    // NEED TO DO: Generate ORDER ID
    _options = {
      'key': publicKey,
      // Amount set in paisa 100paisa = 1rupees
      'amount': 100, //in the smallest currency sub-unit.
      'name': name,
      'order_id': 'Test Order', // Generate order_id using Orders API
      'description': '',
      'timeout': timeout ?? 60, // in seconds
      'prefill': {
        'contact': user.phoneNumber,
        'email': user.email,
        //   'name': user.name,
        //   'method': PaymentModes.upi.name,
      },
      // 'customer_id': user.uid,
    };
  }

  void _setPaymentOptions({
    double? amount, // Amount in rupees
    String? orderId,
    String? description,
    PaymentModes? paymentMode,
  }) {
    if (amount != null) {
      _options['amount'] = amount * 100; // Converting paisa to rupees
    }
    if (orderId != null) _options['order_id'] = orderId;
    if (description != null) _options['description'] = description;
    if (paymentMode != null) _options['prefill']['method'] = paymentMode.name;
  }

  /// Take input from app for amount and set it to options before calling this method
  void pay({
    required PaymentModes paymentMode,
    required double amount,
  }) {
    _setPaymentOptions(paymentMode: paymentMode, amount: amount);
    // print(_options);
    _razorpay.open(_options);
  }
}
