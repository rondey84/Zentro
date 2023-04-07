import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zentro/data/enums/lottie_enums.dart';
import 'package:zentro/pages/splash/splash_controller.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                top: 0.08.sh,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.05,
                        child: Lottie.asset(
                          LottieAnimations.flowBg09.filePath,
                          // height: 1.sw,
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: const Alignment(0, 1),
                          child: Text(
                            controller.appName,
                            style: TextStyle(
                              color: Get.theme.customColor()?.text07,
                              fontSize: 0.25.sw,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: const Alignment(-0.6, 0),
                  child: Lottie.asset(
                    LottieAnimations.coffeeLoading.filePath,
                    height: 0.65.sw,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: const Alignment(0.4, 0.15),
                  child: Lottie.asset(
                    LottieAnimations.burgerLoading.filePath,
                    height: 0.35.sw,
                  ),
                ),
              ),
              Positioned.fill(
                bottom: 0.05.sh,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    controller.description,
                    style: TextStyle(
                      color: Get.theme.customColor()?.text04,
                      fontSize: 14.r,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
