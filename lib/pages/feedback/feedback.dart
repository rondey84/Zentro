import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/feedback/feedback_controller.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/widgets/container_card.dart';
import 'package:zentro/widgets/custom_app_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zentro/widgets/loading_item.dart';

part './widgets/header.dart';
part './widgets/ratings.dart';
part './widgets/submit_button.dart';
part './widgets/feedback_input.dart';

class FeedbackScreen extends GetView<FeedbackController> {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Obx(() {
          if (controller.isKeyboardOpen.value) {
            return Text(
              'Rate you experience with',
              style: controller.fontStyles?.cardHeader,
            );
          }
          return const SizedBox.shrink();
        }),
      ),
      body: SafeArea(
        child: SizedBox(
          height: 1.sh - Get.statusBarHeight,
          child: Column(
            children: [
              // Header
              const _FeedbackHeader(),
              // 2. Ratings
              const _FeedbackRatings(),
              // 3. Feedback input
              const Expanded(
                child: _FeedbackInput(),
              ),
              // 4. Submit Button
              const _SubmitButton(),
              Obx(() {
                if (controller.isKeyboardOpen.value) {
                  return const SizedBox(height: 8);
                }
                return const SizedBox(height: 40);
              })
            ],
          ),
        ),
      ),
    );
  }
}
