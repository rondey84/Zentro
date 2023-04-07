import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/theme/extensions/authentication_style.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/util/keyboard_helper.dart';

class LoginController extends SuperController {
  var style = Get.theme.extension<AuthenticationStyle>();
  var fontStyle = Get.theme.extension<CustomFontStyles>();
  final formKey = GlobalKey<FormState>();

  // ======= Screen Mode ======
  RxBool otpMode = false.obs;
  void setMode() {
    otpMode.value = true;
  }

  // ======= Screen Texts ========
  String get heading => otpMode.value
      ? 'Verify with OTP sent to ${controllerPhoneNumber.text}'
      : 'Enter your mobile number to get OTP';

  String get buttonText => otpMode.value ? 'Continue' : 'Get OTP';
  String get descriptionText => otpMode.value
      ? 'Did not receive OTP? Resend in 0:22'
      : 'By clicking, I accept the terms of service and privacy policy.';

  // ====== Country CODE =========
  final controllerOTP = TextEditingController();
  RxString phoneCode = '91'.obs;
  void countryCodeHandler() {
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: style!.underLineColor),
      borderRadius: BorderRadius.circular(22),
    );
    showCountryPicker(
      context: Get.context!,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
        inputDecoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: style!.inputBoxHintColor,
          ),
          prefixIcon: const Icon(Icons.search),
        ),
        backgroundColor: style!.modalBgColor,
        textStyle: style!.modalTextStyle,
        searchTextStyle: style!.modalSearchTextStyle,
      ),
      onSelect: (country) {
        phoneCode.value = country.phoneCode;
      },
    );
  }

  // ========= PHONE NUMBER =========
  final controllerPhoneNumber = TextEditingController();
  String phoneNumber = '';

  void onTapHandler() async {
    if (isLoading.value) return;
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
      setError();
      return;
    }

    if (otpMode.value) {
      var isVerified = await FirebaseService.instance.firebaseAuthHelper
          .verifyOTP(otp: controllerOTP.text);
      if (isVerified) {
        FirebaseService.instance.firebaseAuthHelper.navigateOnVerification();
      }
      return;
    }

    phoneNumber = '+${phoneCode.value} ${controllerPhoneNumber.text}';
    await FirebaseService.instance.firebaseAuthHelper.verifyPhoneNumber(
      phoneNumber.trim(),
      updateState: setMode,
      errorHandler: setError,
    );
    isLoading.value = false;
    // KeyboardHelper.closeKeyboard();
  }

  String? inputValidator(String? value) {
    if (otpMode.value) {
      // Handle Otp mode validator
    } else {
      if (value == null || value.isEmpty) {
        return 'Please enter a phone number';
      }
      if (value.length != 10) {
        return 'Invalid Phone Number';
      }
    }
    return null;
  }

  // ====== Loading State =======
  final isLoading = false.obs;

  // ======= ERROR ========
  final _hasError = false.obs;
  bool get hasError => _hasError.value;
  Future<void> setError() async {
    if (_hasError.value) return;
    _hasError.value = true;
    await Future.delayed(const Duration(seconds: 5), resetError);
  }

  void resetError() {
    if (_hasError.value) _hasError.value = false;
  }

  // ===== Animation =====
  final animDuration = const Duration(milliseconds: 175);

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
    KeyboardHelper.closeKeyboard();
  }
}
