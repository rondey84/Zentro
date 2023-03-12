import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/user_models.dart' as user_model;
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';

class UserProfileController extends GetxController {
  var fontStyle = Get.theme.extension<CustomFontStyles>();
  FirebaseService firebaseService = Get.find();
  LocalStorageService localStorageService = Get.find();

  User? get user => firebaseService.firebaseAuthHelper.currentUser.value;

  String get username {
    var name = 'Welcome';
    if (user != null) {
      if (user!.displayName != null) {
        if (user!.displayName!.isNotEmpty) {
          name = user!.displayName!;
        }
      }
    }
    return name.capitalize!;
  }

  String get email {
    var email = '';
    if (user != null) {
      if (user!.email != null) {
        if (user!.email!.isNotEmpty) {
          email = user!.email!;
        }
      }
    }
    return email;
  }

  String get phoneNumber {
    var phone = '';
    if (user != null) {
      if (user!.phoneNumber != null) {
        if (user!.phoneNumber!.isNotEmpty) {
          phone =
              '${user!.phoneNumber!.substring(0, 3)} - ${user!.phoneNumber!.substring(3)}';
        }
      }
    }
    return phone;
  }

  Widget get profilePicture {
    if (user != null) {
      if (user!.photoURL != null) {
        if (user!.photoURL!.isNotEmpty) {
          return Image.network(user!.photoURL!);
        }
      }
    }

    return SvgHelper.profileAvatar(primaryColor: Get.theme.primaryColor);
  }

  List<user_model.UserProfileItem> get listItems {
    return <user_model.UserProfileItem>[
      user_model.UserProfileItem(
        text: 'About',
        iconData: Icons.supervisor_account_rounded,
      ),
      user_model.UserProfileItem(
        text: 'Feedback',
        iconData: Icons.rss_feed_rounded,
      ),
      user_model.UserProfileItem(
        text: 'Rate Us',
        iconData: Icons.thumb_up_rounded,
      ),
      user_model.UserProfileItem(
        text: 'Log Out',
        iconData: Icons.logout_rounded,
        onTap: () async {
          // TODO: SHOW CONFIRMATION DIALOG
          FirebaseService firebaseService = Get.find();
          await firebaseService.firebaseAuthHelper.signOut();
          localStorageService.deleteUserData();
        },
      ),
    ];
  }
}
