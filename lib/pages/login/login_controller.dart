import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/theme/extensions/authentication_style.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';

class LoginController extends GetxController {
  var style = Get.theme.extension<AuthenticationStyle>();
  var fontStyle = Get.theme.extension<CustomFontStyles>();
  var firebaseService = Get.find<FirebaseService>();
  final formKey = GlobalKey<FormState>();
  var image = 'assets/images/login_food.png';

  RxBool isVerifying = false.obs;

  String get heading => isVerifying.value
      ? 'Verify with OTP sent to ${controllerPhoneNumber.text}'
      : 'Enter your mobile number to get OTP';

  String get buttonText => isVerifying.value ? 'Continue' : 'Get OTP';
  String get descriptionText => isVerifying.value
      ? 'Did not receive OTP? Resend in 0:22'
      : 'By clicking, I accept the terms of service and privacy policy.';

  final controllerPhoneNumber = TextEditingController();
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

  String phoneNumber = '';

  void onTapHandler() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (isVerifying.value) {
      var isVerified = await firebaseService.firebaseAuthHelper
          .verifyOTP(otp: controllerOTP.text);
      if (isVerified) {
        firebaseService.firebaseAuthHelper.navigateOnVerification();
      }
      return;
    }

    phoneNumber = '+${phoneCode.value} ${controllerPhoneNumber.text}';
    await firebaseService.firebaseAuthHelper.verifyPhoneNumber(
      phoneNumber.trim(),
      updateState: setVerifying,
    );
  }

  void setVerifying() {
    isVerifying.value = true;
  }
}
