import 'package:flutter/material.dart';

class UserProfileItem {
  final String text;
  final IconData iconData;
  final VoidCallback? onTap;

  UserProfileItem({
    required this.text,
    required this.iconData,
    this.onTap,
  });
}
