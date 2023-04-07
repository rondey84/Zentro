import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:zentro/data/constants/google_pay_config.dart';
import 'package:zentro/data/model/payment.dart';
import 'package:zentro/pages/payment/payment_controller.dart';
import 'package:zentro/widgets/container_card.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:zentro/widgets/loading_item.dart';
import 'package:zentro/widgets/spaced_cards.dart';

part './widgets/bill_header.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: _BillHeader(), titleSpacing: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _subHeader('Go Cashless (Recommended)'),
              const SizedBox(height: 12),
              Obx(() {
                return Column(
                  children: List.generate(
                    controller.onlinePaymentModes.length,
                    (idx) {
                      var paymentMode =
                          controller.onlinePaymentModes.keys.elementAt(idx);
                      var paymentItems =
                          controller.onlinePaymentModes[paymentMode];
                      return ContainerCard(
                        shadowStyle: ShadowStyle.style1,
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                        child: Column(
                          children: [
                            controller.isPaymentDataLoading
                                ? _loadingHeader()
                                : _cardHeader(paymentMode),
                            const SizedBox(height: 4),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: paymentItems!.length,
                              itemBuilder: (_, index) {
                                if (controller.isPaymentDataLoading) {
                                  return _loadingItem();
                                }
                                if (paymentMode == 'Wallets') {
                                  return googlePayButton();
                                }
                                return _paymentItem(paymentItems[index]);
                              },
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 6),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 4),
              _subHeader('Pay Offline'),
              const SizedBox(height: 12),
              Obx(() {
                return Column(
                  children: List.generate(
                    controller.offlinePaymentModes.length,
                    (idx) {
                      var paymentMode =
                          controller.offlinePaymentModes.keys.elementAt(idx);
                      var paymentItems =
                          controller.offlinePaymentModes[paymentMode];
                      return ContainerCard(
                        shadowStyle: ShadowStyle.style1,
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                        child: Column(
                          children: [
                            controller.isPaymentDataLoading
                                ? _loadingHeader()
                                : _cardHeader(paymentMode),
                            const SizedBox(height: 4),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: paymentItems!.length,
                              itemBuilder: (_, index) {
                                if (controller.isPaymentDataLoading) {
                                  return _loadingItem();
                                }
                                return _paymentItem(paymentItems[index]);
                              },
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 6),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget googlePayButton() {
    return GooglePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(
        DEFAULT_GOOGLE_PAY_CONFIG,
      ),
      onPaymentResult: controller.onGooglePayResult,
      paymentItems: [
        PaymentItem(
          amount: controller.priceWithTax.toString(),
          label: 'Total',
          status: PaymentItemStatus.final_price,
          type: PaymentItemType.total,
        )
      ],
      width: double.infinity,
      type: GooglePayButtonType.pay,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _loadingHeader() {
    return LoadingItem(
      enabled: controller.isPaymentDataLoading,
      height: controller.textHeight('Sample', controller.cardHeaderTS),
      width: 60,
    );
  }

  Widget _loadingItem() {
    return LoadingItem(
      enabled: controller.isPaymentDataLoading,
      height: 48,
    );
  }

  Widget _subHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        text,
        style: controller.fontStyles!.header2.copyWith(
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    );
  }

  Widget _cardHeader(String text) {
    return Text(text, style: controller.cardHeaderTS);
  }

  Widget _paymentItem(PaymentListItem item) {
    return GestureDetector(
      onTap: item.onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.fromLTRB(12, 8, 6, 8),
        child: Row(
          children: [
            // Icon
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.isNewTile ? null : Get.theme.primaryColorLight,
                border: item.isNewTile
                    ? Border.all(
                        width: 1,
                        color: Get.theme.primaryColorLight,
                      )
                    : null,
              ),
              height: 36,
              width: 36,
              clipBehavior: Clip.antiAlias,
              child: item.isNewTile
                  ? Icon(
                      Icons.add_rounded,
                      color: Get.theme.primaryColorLight,
                    )
                  : item.icon,
            ),
            // Text and Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: controller.fontStyles?.body1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                  if (item.description.isNotEmpty)
                    Text(
                      item.description,
                      style: controller.fontStyles?.caption,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                ],
              ),
            ),
            // Right Chevron
            if (!item.isNewTile)
              Icon(
                Icons.chevron_right_rounded,
                color: Get.theme.primaryColorLight,
              ),
          ],
        ),
      ),
    );
  }
}
