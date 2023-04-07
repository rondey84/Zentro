import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:zentro/data/model/restaurant_ratings.dart';
import 'package:zentro/data/model/zentro_order.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/util/text_helper.dart';
import 'package:zentro/widgets/custom_dialogs.dart';

class FeedbackController extends SuperController {
  // ====== Order ======
  late String _orderId;
  late ZentroOrder? order;

  // ====== Restaurant =====
  String? restaurantName;

  // ======= Design Parameters ======
  final fontStyles = Get.theme.extension<CustomFontStyles>();
  final shimmerStyle = Get.theme.extension<ShimmerStyle>();

  //  ======= Data ======
  final hasDataLoaded = false.obs;
  final rating = 3.0.obs;

  // ------ Feedback Input ------
  final inputController = TextEditingController();

  @override
  void onInit() {
    _orderId = Get.parameters['orderId']!;
    _loadData();
    super.onInit();
  }

  Future<void> _loadData() async {
    final fireStoreHelper = FirebaseService.instance.fireStoreHelper;
    order = await fireStoreHelper.getOrder(_orderId);
    restaurantName =
        (await fireStoreHelper.getRestaurantData(order!.restId))?.name;

    hasDataLoaded.value = true;
  }

  // ========== Feedback Submit Handler ==========
  Future<void> onSubmitHandler() async {
    if (order == null) return;

    final fireStoreHelper = FirebaseService.instance.fireStoreHelper;
    // Create Ratings
    var uuid = const Uuid();
    var now = DateTime.now();
    var timeId = now.microsecondsSinceEpoch.toString();
    var ratingId = uuid.v5(Uuid.NAMESPACE_DNS, timeId);

    // Users Identifier
    var phoneNumber = LocalStorageService.instance.getUserData().phoneNumber;

    var restRating = RestaurantRatings(
      ratingId: ratingId,
      orderId: _orderId,
      userId: phoneNumber,
      restId: order!.restId,
      rating: rating.value,
      feedback: inputController.text,
      createdAt: now,
    );

    await fireStoreHelper.createRating(restRating);

    // Update Orders with rating id
    var updatedOrder = order!.copyWith(ratingId: ratingId);
    await fireStoreHelper.updateOrder(updatedOrder);

    CustomDialogs.animatedDialog(
      barrierDismissible: true,
      barrierLabel: 'Feedback submit dialog',
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Feedback received',
              style: fontStyles?.header1,
            ),
            SvgHelper.agree(
              primaryColor: Get.theme.primaryColor,
              width: 1.sw,
            ),
            Text(
              'Thankyou for your feedback',
              style: fontStyles?.body1,
            ),
          ],
        ),
      ),
    ).then((_) => Get.offNamedUntil(
          AppRoutes.HOME,
          ModalRoute.withName(AppRoutes.HOME),
        ));
  }

  // ===== Keyboard Open State Handler =====
  var isKeyboardOpen = false.obs;

  @override
  void didChangeMetrics() {
    final isKeyboardOpenValue = GetPlatform.isIOS ||
        GetPlatform.isAndroid &&
            MediaQuery.of(Get.context!).viewInsets.bottom > 0;
    isKeyboardOpen.value = isKeyboardOpenValue;
    super.didChangeMetrics();
  }

  // ===== MISC =====
  double textHeight(String text, TextStyle? ts) {
    return TextHelper.textSize(text, ts).height;
  }

  @override
  void onDetached() {
    // onDetached
  }

  @override
  void onInactive() {
    // onInactive
  }

  @override
  void onPaused() {
    // onPaused
  }

  @override
  void onResumed() {
    // onResumed
  }
}
