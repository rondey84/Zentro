import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/login/login_controller.dart';
import 'package:pinput/pinput.dart';

class LoginInputBox extends GetView<LoginController> {
  const LoginInputBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: controller.style!.inputBoxColor,
        boxShadow: [
          BoxShadow(
            color: controller.style!.inputBoxShadowColor,
            blurRadius: 20,
            offset: const Offset(0, 5),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      constraints: const BoxConstraints(maxWidth: 350),
      child: Obx(() {
        return controller.isVerifying.value ? buildPinPut() : mobileInput();
      }),
    );
  }

  Widget mobileInput() {
    var borderStyle = InputBorder.none;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            controller: controller.controllerPhoneNumber,
            onFieldSubmitted: (_) => controller.onTapHandler(),
            style: TextStyle(
              color: controller.style!.inputBoxTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
            maxLength: 10,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            enableSuggestions: false,
            autocorrect: false,
            autofocus: true,
            decoration: InputDecoration(
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
              border: borderStyle,
              isDense: true,
              fillColor: Colors.green,
              contentPadding: EdgeInsets.zero,
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: controller.countryCodeHandler,
                    child: Text(
                      '+ ${controller.phoneCode}',
                      style: TextStyle(
                        color: controller.style!.inputBoxTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              hintText: 'Enter 10 Digit Mobile Number',
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: controller.style!.inputBoxHintColor,
                letterSpacing: 1,
                overflow: TextOverflow.ellipsis,
              ),
              counter: const Offstage(),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: controller.style!.underLineColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPinPut() {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        color: controller.style!.inputBoxTextColor,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: controller.style!.underLineColor,
            borderRadius: BorderRadius.circular(8),
          ),
        )
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: controller.style!.inputBoxHintColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    return Pinput(
      length: 6,
      controller: controller.controllerOTP,
      pinAnimationType: PinAnimationType.slide,
      defaultPinTheme: defaultPinTheme,
      showCursor: true,
      cursor: cursor,
      preFilledWidget: preFilledWidget,
    );
  }
}
