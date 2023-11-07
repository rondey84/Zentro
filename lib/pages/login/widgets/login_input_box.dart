part of '../login.dart';

class _LoginInputBox extends GetView<LoginController> {
  const _LoginInputBox();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedContainer(
        duration: controller.animDuration,
        decoration: BoxDecoration(
          border: Border.all(
            width: 4,
            color: controller.hasError
                ? Get.theme.colorScheme.error
                : controller.style?.inputBoxColor ?? Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(26),
          color: controller.style?.inputBoxColor,
          boxShadow: [
            BoxShadow(
              color: controller.style!.inputBoxShadowColor,
              blurRadius: 20,
              offset: const Offset(0, 5),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        margin: EdgeInsets.fromLTRB(
          20,
          controller.isKeyboardOpen.value ? 20 : 30,
          20,
          controller.isKeyboardOpen.value ? 15 : 30,
        ),
        constraints: const BoxConstraints(maxWidth: 350),
        child: Obx(() {
          return controller.otpMode.value ? buildPinPut() : mobileInput();
        }),
      );
    });
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
            autofocus: true,
            validator: controller.inputValidator,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
              border: borderStyle,
              isDense: true,
              fillColor: Colors.green,
              contentPadding: EdgeInsets.zero,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: controller.countryCodeHandler,
                    child: Text(
                      '+ ${controller.phoneCode}',
                      style: TextStyle(
                        color: controller.style!.inputBoxTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
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
              errorText: '',
              errorMaxLines: 1,
              errorStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 0,
              ),
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
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
    );
  }
}
