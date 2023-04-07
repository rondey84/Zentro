import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/user_models.dart' as user_model;
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/widgets/custom_dialogs.dart';

class UserProfileController extends GetxController {
  final fontStyles = Get.theme.extension<CustomFontStyles>();

  User? get user {
    return FirebaseService.instance.firebaseAuthHelper.currentUser.value;
  }

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
          await CustomDialogs.animatedDialog(
            barrierDismissible: true,
            barrierLabel: 'Logout confirm dialog',
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Log out',
                    style: fontStyles?.header1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Are you sure you want to log out?',
                    style:
                        fontStyles?.body2.copyWith(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _dialogButton(
                          buttonColor: Get.theme.primaryColor.withOpacity(0.2),
                          text: 'Cancel',
                          textColor: Get.theme.customColor()?.text06,
                          onTap: () => Get.back(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _dialogButton(
                          buttonColor: Get.theme.primaryColor,
                          text: 'Log Out',
                          textColor: Get.theme.customColor()?.text00,
                          onTap: () async {
                            LocalStorageService.instance.deleteUserData();
                            await FirebaseService.instance.firebaseAuthHelper
                                .signOut();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ];
  }

  Widget _dialogButton({
    required Color buttonColor,
    required String text,
    required textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: buttonColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          text,
          style: fontStyles?.button.copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
