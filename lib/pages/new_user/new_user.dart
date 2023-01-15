import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/new_user/widgets/new_user_dots.dart';
import './new_user_controller.dart';
import 'widgets/new_user_next_button.dart';

class NewUserScreen extends GetView<NewUserController> {
  const NewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(fontSize: 16.0)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 270),
                  margin: const EdgeInsets.only(top: 16),
                  height: controller.style!.titleStyle.fontSize! * 3,
                  alignment: Alignment.topCenter,
                  child: Obx(() => Text(
                        controller.header,
                        style: controller.style!.titleStyle,
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => SizedBox(
                    height: 240,
                    width: 240,
                    child: controller.svgImage,
                  )),
              inputBox(),
              const SizedBox(height: 30),
              Container(
                constraints: const BoxConstraints(maxWidth: 350),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    NewUserDots(),
                    Spacer(),
                    NewUserNextButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputBox() {
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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      constraints: const BoxConstraints(maxWidth: 350, minHeight: 60),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Obx(() {
          return TextFormField(
            readOnly: controller.readOnly,
            controller: controller.textController,
            onFieldSubmitted: (_) => controller.onTapHandler(),
            style: TextStyle(
              color: controller.style!.inputBoxTextColor,
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
              fillColor: Colors.green,
              contentPadding: EdgeInsets.zero,
              hintText: controller.hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: controller.style!.inputBoxHintColor,
              ),
              counter: const Offstage(),
            ),
            textAlign: TextAlign.center,
          );
        }),
      ),
    );
  }
}
