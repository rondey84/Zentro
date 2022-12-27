import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/home/home_controller.dart';
import 'package:zentro/services/firebase_service.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HOME')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.find<FirebaseService>().signOut();
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
