import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zentro/data/api/api_endpoints.dart';
import 'package:zentro/data/enums/env_keys.dart';
import 'package:zentro/data/enums/remote_config_key.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';

class StripeController extends GetxController {
  // Stripe uses this to represent your intent to collect payment from a customer,
  // tracking your charge attempts and payment state changes throughout the process.
  Map<String, dynamic>? _paymentIntent;

  @override
  void onInit() {
    _initStripe();
    super.onInit();
  }

  void _initStripe() {
    var publicKey = dotenv.maybeGet(EnvKeys.stripeTestKey.key);
    if (publicKey != null) {
      Stripe.publishableKey = publicKey;
    }
  }

  Future<void> cardPayment(
      {required double amount, VoidCallback? onPaymentComplete}) async {
    // Step 1 - Payment Intent
    await _createPaymentIntent(amount);

    // Step 2 - Initializing payment sheet
    await _createPaymentSheet();

    // Step 3 Display Payment Sheet
    try {
      await Stripe.instance.presentPaymentSheet().then((_) {
        if (onPaymentComplete != null) {
          onPaymentComplete();
        }
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _createPaymentIntent(double amount) async {
    Map<String, dynamic> data = {
      'amount': (amount * 100).round().toString(),
      'currency': 'INR',
      'automatic_payment_methods[enabled]': 'true',
    };

    try {
      var secretKey = dotenv.maybeGet(EnvKeys.stripeTestSecretKey.key);
      if (secretKey == null) {
        throw Exception('Failed to get Authorization Key for Payment');
      }

      var url = ApiEndPoints.stripe(StripeEndPoint.createPaymentIntents);
      var response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          'authorization': 'Bearer $secretKey',
          'content-type': 'application/x-www-form-urlencoded'
        },
      );
      _paymentIntent = json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _createPaymentSheet() async {
    // Load Receiver Name
    var name = RemoteConfigKey.paymentDisplayName.value as String?;
    name ??= dotenv.maybeGet(EnvKeys.paymentDisplayName.key, fallback: null);

    // Sheet appearance
    var appearance = PaymentSheetAppearance(
      colors: PaymentSheetAppearanceColors(
        background: Get.theme.scaffoldBackgroundColor,
        primary: Get.theme.primaryColor,
        componentBackground: Get.theme.cardColor,
        componentBorder: Get.theme.colorScheme.outline.withOpacity(0.6),
        componentDivider: Get.theme.colorScheme.outline.withOpacity(0.3),
        componentText: Get.theme.customColor()?.text05,
        error: Colors.red,
        icon: Get.theme.primaryColorLight,
        placeholderText: Get.theme.customColor()?.text03,
        primaryText: Get.theme.customColor()?.text08,
        secondaryText: Get.theme.customColor()?.text07,
      ),
      primaryButton: PaymentSheetPrimaryButtonAppearance(
        colors: PaymentSheetPrimaryButtonTheme(
          light: PaymentSheetPrimaryButtonThemeColors(
            background: Get.theme.primaryColor,
            border: Colors.transparent,
            text: Get.theme.customColor()?.text00,
          ),
          dark: PaymentSheetPrimaryButtonThemeColors(
            background: Get.theme.primaryColor,
            border: Colors.transparent,
            text: Colors.white,
          ),
        ),
        shapes: const PaymentSheetPrimaryButtonShape(
          blurRadius: 2,
          borderWidth: 0,
        ),
      ),
      shapes: const PaymentSheetShape(borderRadius: 18, borderWidth: 0.5),
    );

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: _paymentIntent!['client_secret'],
        style: ThemeMode.light,
        merchantDisplayName: name ?? 'Zentro',
        appearance: appearance,
      ),
    );
  }
}
