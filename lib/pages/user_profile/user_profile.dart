import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/hero_tags.dart';
import 'package:zentro/data/model/user_models.dart' as user_model;
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
          children: [
            Hero(
              tag: HeroTag.profileHeader.tag,
              child: const _ProfileHeader(),
            ),
            const _ButtonsList(),
            const Flexible(fit: FlexFit.loose, child: _ListItems()),
          ],
        ),
      ),
    );
  }
}
