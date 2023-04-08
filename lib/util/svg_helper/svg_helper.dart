import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zentro/util/extensions/color_extension.dart';

part './svg_string_codes/new_user_name.dart';
part './svg_string_codes/new_user_email.dart';
part './svg_string_codes/current_location.dart';
part './svg_string_codes/profile_avatar.dart';
part './svg_string_codes/error.dart';
part './svg_string_codes/happy_news.dart';
part './svg_string_codes/completed.dart';
part './svg_string_codes/ratings_faces.dart';
part './svg_string_codes/agree.dart';
part './svg_string_codes/empty_cart.dart';
part './svg_string_codes/cooking.dart';
part './svg_string_codes/onboarding_images.dart';
part './svg_string_codes/mobile_login.dart';
part 'svg_string_codes/user_profile_card_images.dart';

class SvgHelper {
  static SvgPicture getSvgPicture({
    required String code,
    Key? key,
    double? height,
    double? width,
    BoxFit? fit,
    Color? color,
  }) {
    return SvgPicture.string(
      code,
      key: key,
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
      color: color,
    );
  }

  static SvgPicture newUserName({required Color primaryColor}) {
    String code = NewUserName.getCode(
      primaryColor: primaryColor.toRGBACode(),
    );

    return getSvgPicture(code: code);
  }

  static SvgPicture newUserEmail({required Color primaryColor}) {
    String code = NewUserEmail.getCode(
      primaryColor: primaryColor.toRGBACode(),
    );

    return getSvgPicture(code: code);
  }

  static SvgPicture currentLocation({required Color primaryColor}) {
    String code = CurrentLocation.getCode(
      primaryColor: primaryColor.toRGBACode(),
    );
    return getSvgPicture(code: code);
  }

  static SvgPicture profileAvatar({required Color primaryColor}) {
    String code = ProfileAvatar.getCode(
      primaryColor: primaryColor.toRGBACode(),
    );
    return getSvgPicture(code: code);
  }

  static SvgPicture somethingWentWrong({
    required Color primaryColor,
    Color? secondaryColor,
    Color? detailsColor,
  }) {
    String code = SomethingWentWrong.getCode(
      primaryColor: primaryColor.toRGBACode(),
      secondaryColor: secondaryColor?.toRGBACode(),
      detailsColor: detailsColor?.toRGBACode(),
    );
    return getSvgPicture(code: code);
  }

  static SvgPicture happyNews({
    required Color primaryColor,
    Color? secondaryColor,
    Color? skinColor,
    Color? leafColor,
    Color? details1Color,
    Color? details2Color,
    Color? details3Color,
    Color? deviceFrameColor,
    Color? deviceBodyColor,
    double? height,
  }) {
    String code = HappyNews.getCode(
      primaryColor: primaryColor.toRGBACode(),
      secondaryColor: secondaryColor?.toRGBACode(),
      skinColor: skinColor?.toRGBACode(),
      leafColor: leafColor?.toRGBACode(),
      details1Color: details1Color?.toRGBACode(),
      details2Color: details2Color?.toRGBACode(),
      details3Color: details3Color?.toRGBACode(),
      deviceFrameColor: deviceFrameColor?.toRGBACode(),
      deviceBodyColor: deviceBodyColor?.toRGBACode(),
    );
    return getSvgPicture(code: code, height: height);
  }

  static SvgPicture completed({Color? primaryColor}) {
    String code = Completed.getCode(
      primaryColor: primaryColor?.toRGBACode(),
    );
    return getSvgPicture(code: code);
  }

  static SvgPicture ratingsFace({required RatingFaces faceType, Key? key}) {
    String code = faceType._getCode();
    return getSvgPicture(code: code, key: key);
  }

  static SvgPicture agree({
    required Color primaryColor,
    double? width,
    double? height,
  }) {
    String code = Agree.getCode(primaryColor: primaryColor.toRGBACode());
    return getSvgPicture(code: code, height: height, width: width);
  }

  static SvgPicture emptyCart({
    double? width,
    double? height,
  }) {
    String code = EmptyCart.getCode();
    return getSvgPicture(code: code, height: height, width: width);
  }

  static SvgPicture cooking({
    double? width,
    double? height,
  }) {
    String code = Cooking.getCode();
    return getSvgPicture(code: code, height: height, width: width);
  }

  static SvgPicture onboarding({
    required OnboardingImages onboard,
    required Color primaryColor,
    required Color accentColor,
    double? width,
    double? height,
    Key? key,
  }) {
    String code = onboard._getCode(
      primaryColor: primaryColor.toRGBACode(),
      accentColor: accentColor.toRGBACode(),
    );
    return getSvgPicture(key: key, code: code, height: height, width: width);
  }

  static SvgPicture mobileLogin({
    required Color primaryColor,
    double? width,
    double? height,
  }) {
    String code = MobileLogin.getCode(primaryColor: primaryColor.toRGBACode());
    return getSvgPicture(code: code, height: height, width: width);
  }

  static SvgPicture userProfileCard({
    required UserProfileCards type,
    double? width,
    double? height,
    Key? key,
  }) {
    String code = type._getCode();
    return getSvgPicture(key: key, code: code, height: height, width: width);
  }
}
