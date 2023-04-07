import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zentro/data/constants/debug.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/theme/extensions/authentication_style.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/gradient_border_button_style.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:zentro/util/text_helper.dart';

class NewUserController extends SuperController {
  // ======== DESIGN =========
  final authStyle = Get.theme.extension<AuthenticationStyle>();
  final buttonStyle = Get.theme.extension<GradientBorderButtonStyle>();
  final fontStyle = Get.theme.extension<CustomFontStyles>();
  final animDuration = const Duration(milliseconds: 175);

  RxInt currentPage = 0.obs;

  Timer? timer;

  RxBool isEmailVerified = false.obs;

  RxBool canResendEmail = false.obs;

  List<Map<String, dynamic>> content = [
    {
      'header': 'What is your name?',
      'image': SvgHelper.newUserName(primaryColor: Get.theme.primaryColor),
      'controller': TextEditingController(),
      'hintText': 'Full Name',
      'keyboardType': TextInputType.name,
    },
    {
      'header': 'What is your email?',
      'image': SvgHelper.newUserEmail(primaryColor: Get.theme.primaryColor),
      'controller': TextEditingController(),
      'hintText': 'Email',
      'keyboardType': TextInputType.emailAddress,
    },
    {
      'header': 'Verify Email',
      'image': SvgHelper.newUserEmail(primaryColor: Get.theme.primaryColor),
      'controller': TextEditingController(),
      'hintText': 'A verification email has been sent to your email',
    },
  ];

  // ======== Getters =======
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

  // ===== State =====
  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  // ====== Loading State =======
  final isLoading = false.obs;

  // ===== Button Handlers =======
  Future<void> onTapHandler() async {
    if (isLoading.value) return;
    isLoading.value = true;
    switch (currentPage.value) {
      case 0:
        await _nameUpdating().then((_) => isLoading.value = false);
        break;
      case 1:
        await _emailUpdating().then((_) => isLoading.value = false);
        break;
      case 2:
        await _handleContinue().then((_) => isLoading.value = false);
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
      setError('Please enter your name');
      return;
    }
    if (!RegExp('[a-zA-Z]').hasMatch(name)) {
      setError('Please enter a valid name');
      return;
    }
    await FirebaseService.instance.firebaseAuthHelper.currentUser.value
        ?.updateDisplayName(name);
    await FirebaseService.instance.firebaseAuthHelper.currentUser.value
        ?.reload();
    currentPage.value += 1;
  }

  Future<void> _emailUpdating() async {
    if (currentPage.value != 1) return;
    var email = '';
    if (textController != null) email = textController!.text;
    if (email.isEmpty) {
      setError('Please enter your email');
      return;
    }
    if (!EmailValidator.validate(email)) {
      setError('Please enter a valid email');
      return;
    }

    await FirebaseService.instance.firebaseAuthHelper.currentUser.value
        ?.updateEmail(email);
    await FirebaseService.instance.firebaseAuthHelper.currentUser.value
        ?.reload();
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
    await FirebaseService.instance.firebaseAuthHelper.currentUser.value
        ?.reload();

    isEmailVerified.value = FirebaseService
            .instance.firebaseAuthHelper.currentUser.value?.emailVerified ??
        false;

    if (isEmailVerified.value) timer?.cancel();
  }

  Future<void> sendEmailVerification() async {
    try {
      await FirebaseService.instance.firebaseAuthHelper.currentUser.value
          ?.sendEmailVerification();

      canResendEmail.value = false;
      await Future.delayed(const Duration(seconds: 5));
      canResendEmail.value = true;
    } catch (e) {
      setError('Firebase error occurred');
      logPrint(e);
    }
  }

  Future<void> _handleContinue() async {
    if (currentPage.value != 2) return;
    if (isEmailVerified.value) {
      // Update Firestore Database
      await FirebaseService.instance.fireStoreHelper.updateNewUserData();
      Get.offAllNamed(AppRoutes.HOME);
    }
  }

  // ======= ERROR ========
  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(String val) => _errorMessage.value = val;
  final _hasError = false.obs;
  bool get hasError => _hasError.value;
  Future<void> setError(String message) async {
    if (_hasError.value) return;
    errorMessage = message;
    _hasError.value = true;
    await Future.delayed(const Duration(seconds: 5), resetError);
  }

  void resetError() {
    if (_hasError.value) {
      errorMessage = '';
      _hasError.value = false;
    }
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
