import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zentro/util/extensions/color_extension.dart';

part './svg_string_codes/new_user_name.dart';
part './svg_string_codes/new_user_email.dart';
part './svg_string_codes/current_location.dart';
part './svg_string_codes/profile_avatar.dart';

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
}
