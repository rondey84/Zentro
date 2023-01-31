import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/constants/hero_tags.dart';
import 'package:zentro/data/model/user_profile_items.dart';
import 'package:zentro/pages/user_profile/user_profile_controller.dart';

part './widgets/profile_header.dart';
part './widgets/buttons_list.dart';
part './widgets/list_items.dart';

class UserProfile extends GetView<UserProfileController> {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: const [
            Hero(
              tag: HeroTag.profileHeader,
              child: _ProfileHeader(),
            ),
            _ButtonsList(),
            Flexible(fit: FlexFit.loose, child: _ListItems()),
          ],
        ),
      ),
    );
  }
}
