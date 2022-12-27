import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/splash/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(title: Text(controller.pageName)),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
