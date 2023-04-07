import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'widgets/new_user_dots.dart';
import 'widgets/resend_email_button.dart';
import './new_user_controller.dart';

part 'widgets/new_user_next_button.dart';

class NewUserScreen extends GetView<NewUserController> {
  const NewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(fontSize: 16.0)),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: 1.sh - Get.statusBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 270),
                  alignment: Alignment.topCenter,
                  child: Obx(() => Text(
                        controller.header,
                        style: controller.fontStyle!.display,
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              Obx(() => SizedBox(
                    height: controller.isKeyboardOpen.value ? 0.03.sh : 0.04.sh,
                  )),
              Obx(() {
                return AnimatedContainer(
                  duration: controller.animDuration,
                  height: controller.isKeyboardOpen.value ? 0.4.sw : 0.8.sw,
                  width: controller.isKeyboardOpen.value ? 0.4.sw : 0.8.sw,
                  child: controller.svgImage,
                );
              }),
              inputBox(),
              const SizedBox(height: 16),
              Container(
                constraints: const BoxConstraints(maxWidth: 350),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() {
                  return AnimatedSwitcher(
                    duration: controller.animDuration,
                    child: controller.isKeyboardOpen.value
                        ? Row(
                            key: const ValueKey(0),
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              NewUserDots(),
                              Spacer(),
                              _NewUserNextButton(),
                            ],
                          )
                        : Column(
                            key: const ValueKey(1),
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              _NewUserNextButton(),
                              SizedBox(height: 40),
                              NewUserDots(),
                            ],
                          ),
                  );
                }),
              ),
              const SizedBox(height: 14),
              Obx(() {
                return AnimatedSwitcher(
                  duration: controller.animDuration,
                  child: controller.isEmailVerified.value &&
                          controller.currentPage.value == 2
                      ? const ResendEmail(key: ValueKey(0))
                      : SizedBox(
                          key: const ValueKey(1),
                          height: controller.textHeight(
                            'Resend',
                            const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                );
              }),
              Container(height: Get.mediaQuery.viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputBox() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          return AnimatedContainer(
            duration: controller.animDuration,
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: controller.hasError
                    ? Get.theme.colorScheme.error
                    : controller.authStyle?.inputBoxColor ?? Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(26),
              color: controller.authStyle?.inputBoxColor,
              boxShadow: [
                BoxShadow(
                  color: controller.authStyle!.inputBoxShadowColor,
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            constraints: const BoxConstraints(maxWidth: 350, minHeight: 60),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Obx(() {
                return TextFormField(
                  readOnly: controller.readOnly,
                  controller: controller.textController,
                  onFieldSubmitted: (_) => controller.onTapHandler(),
                  style: TextStyle(
                    color: controller.authStyle!.inputBoxTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: controller.textInputType,
                  enableSuggestions: false,
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    hintText: controller.hintText,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: controller.authStyle!.inputBoxHintColor,
                    ),
                    counter: const Offstage(),
                  ),
                  textAlign: TextAlign.center,
                );
              }),
            ),
          );
        }),
        Obx(() => Text(
              controller.errorMessage,
              style: controller.fontStyle?.caption.copyWith(
                color: Get.theme.colorScheme.error.withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
            )),
        const SizedBox(height: 8),
      ],
    );
  }
}
