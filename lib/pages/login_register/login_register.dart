import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/login_register/login_register_controller.dart';

class LoginScreen extends GetView<LoginRegisterController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Auth')),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _entryField('Email', controller.controllerEmail),
              _entryField('Password', controller.controllerPassword),
              _errorMessage(),
              _submitButton(),
              const Spacer(),
              _loginOrRegisterButton(),
            ],
          );
        }),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController textController) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(controller.errorMessage.value == ''
        ? ''
        : 'Oops!!! ${controller.errorMessage.value}');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: controller.handleSubmit,
      child: Text(controller.isLogin.value ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: controller.toggleLoginState,
      child:
          Text(controller.isLogin.value ? 'Register instead' : 'Login instead'),
    );
  }
}
