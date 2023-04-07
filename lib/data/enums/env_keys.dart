enum EnvKeys {
  paymentDisplayName,
  razorpayTestKey,
  razorpayTestSecretKey,
  stripeTestKey,
  stripeTestSecretKey,
}

extension EnvKeysExtension on EnvKeys {
  String get key {
    switch (this) {
      case EnvKeys.paymentDisplayName:
        return 'PAYMENT_DISPLAY_NAME';
      case EnvKeys.razorpayTestKey:
        return 'RAZORPAY_TEST_KEY';
      case EnvKeys.razorpayTestSecretKey:
        return 'RAZORPAY_TEST_SECRET_KEY';
      case EnvKeys.stripeTestKey:
        return 'STRIPE_TEST_KEY';
      case EnvKeys.stripeTestSecretKey:
        return 'STRIPE_TEST_SECRET_KEY';
    }
  }
}
