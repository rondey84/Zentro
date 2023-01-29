import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/theme/extensions/authentication_style.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/gradient_border_button_style.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:email_validator/email_validator.dart';

class NewUserController extends GetxController {
  FirebaseService firebaseService = Get.find();
  var authStyle = Get.theme.extension<AuthenticationStyle>();
  var buttonStyle = Get.theme.extension<GradientBorderButtonStyle>();
  var fontStyle = Get.theme.extension<CustomFontStyles>();

  RxInt currentPage = 0.obs;

  Timer? timer;

  RxBool isEmailVerified = false.obs;

  RxBool canResendEmail = false.obs;

  List<Map<String, dynamic>> content = [
    {
      'header': "What is your name?",
      'image': SvgHelper.newUserName(primaryColor: Get.theme.primaryColor),
      'controller': TextEditingController(),
      'hintText': 'Full Name',
      'keyboardType': TextInputType.name,
    },
    {
      'header': "What is your email?",
      'image': SvgHelper.newUserEmail(primaryColor: Get.theme.primaryColor),
      'controller': TextEditingController(),
      'hintText': 'Email',
      'keyboardType': TextInputType.emailAddress,
    },
    {
      'header': "Verify Email",
      'image': SvgHelper.newUserEmail(primaryColor: Get.theme.primaryColor),
      'controller': TextEditingController(),
      'hintText': 'A verification email has been sent to your email',
    },
  ];

  String get header => content[currentPage.value]['header'];
  Widget get svgImage => content[currentPage.value]['image'];
  String get buttonText =>
      currentPage.value < content.length - 1 ? 'Next' : 'Continue';
  TextEditingController? get textController =>
      content[currentPage.value]['controller'];
  String get hintText => content[currentPage.value]['hintText'];
  TextInputType? get textInputType =>
      content[currentPage.value]['keyboardType'];
  bool get readOnly => currentPage.value == 2;

  void onTapHandler() {
    switch (currentPage.value) {
      case 0:
        _nameUpdating();
        break;
      case 1:
        _emailUpdating();
        break;
      case 2:
        _handleContinue();
        break;
      default:
        return;
    }
  }

  Future<void> _nameUpdating() async {
    if (currentPage.value != 0) return;

    var name = '';
    if (textController != null) name = textController!.text;
    if (name.isEmpty) {
      Get.snackbar('Error', "Please enter your name");
      return;
    }
    if (!RegExp('[a-zA-Z]').hasMatch(name)) {
      Get.snackbar('Error', "Please enter a valid name");
      return;
    }
    await firebaseService.firebaseAuthHelper.currentUser.value
        ?.updateDisplayName(name);
    await firebaseService.firebaseAuthHelper.currentUser.value?.reload();
    currentPage.value += 1;
  }

  Future<void> _emailUpdating() async {
    if (currentPage.value != 1) return;
    var email = '';
    if (textController != null) email = textController!.text;
    if (email.isEmpty) {
      Get.snackbar('Error', "Please enter your email");
      return;
    }
    if (!EmailValidator.validate(email)) {
      Get.snackbar('Error', "Please enter a valid email");
      return;
    }

    await firebaseService.firebaseAuthHelper.currentUser.value
        ?.updateEmail(email);
    await firebaseService.firebaseAuthHelper.currentUser.value?.reload();
    currentPage.value += 1;

    // Sending Verification Email
    await _checkEmailVerified();

    if (!isEmailVerified.value) {
      await sendEmailVerification();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => _checkEmailVerified(),
      );
    }
  }

  Future<void> _checkEmailVerified() async {
    await firebaseService.firebaseAuthHelper.currentUser.value?.reload();

    isEmailVerified.value =
        firebaseService.firebaseAuthHelper.currentUser.value?.emailVerified ??
            false;

    if (isEmailVerified.value) timer?.cancel();
  }

  Future<void> sendEmailVerification() async {
    try {
      await firebaseService.firebaseAuthHelper.currentUser.value
          ?.sendEmailVerification();

      canResendEmail.value = false;
      await Future.delayed(const Duration(seconds: 5));
      canResendEmail.value = true;
    } catch (e) {
      Get.snackbar('Error', "$e");
    }
  }

  Future<void> _handleContinue() async {
    if (currentPage.value != 2) return;
    if (isEmailVerified.value) {
      Get.offAllNamed(AppRoutes.HOME);
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
