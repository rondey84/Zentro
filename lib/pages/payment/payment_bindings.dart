import 'package:get/get.dart';
import 'package:zentro/controllers/razorpay_controller.dart';
import 'package:zentro/controllers/stripe_controller.dart';
import 'package:zentro/pages/payment/payment_controller.dart';

class PaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
    Get.lazyPut<RazorpayController>(() => RazorpayController());
    Get.lazyPut<StripeController>(() => StripeController());
  }
}
