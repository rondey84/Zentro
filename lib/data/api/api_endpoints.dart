import 'package:flutter/foundation.dart';

@immutable
class ApiEndPoints {
  const ApiEndPoints._();

  static String stripe(StripeEndPoint stripeEndPoint) {
    const baseUrl = 'https://api.stripe.com';
    return '$baseUrl${stripeEndPoint._endpoint}';
  }
}

enum StripeEndPoint {
  createPaymentIntents(paymentIntent: PaymentIntentsEndPoints.create);

  const StripeEndPoint({this.paymentIntent});
  final PaymentIntentsEndPoints? paymentIntent;

  String get _endpoint {
    if (paymentIntent != null) {
      switch (paymentIntent) {
        case PaymentIntentsEndPoints.create:
          // case PaymentIntentsEndPoints.retrieve:
          // case PaymentIntentsEndPoints.update:
          // case PaymentIntentsEndPoints.confirm:
          // case PaymentIntentsEndPoints.capture:
          // case PaymentIntentsEndPoints.cancel:
          // case PaymentIntentsEndPoints.getAll:
          // case PaymentIntentsEndPoints.incrementAuthorization:
          // case PaymentIntentsEndPoints.search:
          // case PaymentIntentsEndPoints.verifyMicroDeposits:
          // case PaymentIntentsEndPoints.applyCustomerBalance:
          return '${paymentIntent!._paymentEndPointVersion}${paymentIntent!._endPoint}';
        default:
          return '';
      }
    }
    return '';
  }
}

enum PaymentIntentsEndPoints {
  create('/payment_intents');
  // retrieve('/payment_intents/:id'),
  // update('/payment_intents/:id'),
  // confirm('/payment_intents/:id/confirm'),
  // capture('/payment_intents/:id/capture'),
  // cancel('/payment_intents/:id/cancel'),
  // getAll('/payment_intents'),
  // incrementAuthorization('/payment_intents/:id/increment_authorization'),
  // search('/payment_intents/search'),
  // verifyMicroDeposits('/payment_intents/:id/verify_mircodeposits'),
  // applyCustomerBalance('/payment_intents/:id/apply_customer_balance');

  const PaymentIntentsEndPoints(this._endPoint);
  final String _endPoint;
  final String _paymentEndPointVersion = '/v1';
}
