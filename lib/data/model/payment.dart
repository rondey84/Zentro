import 'package:flutter/material.dart';

class PaymentListItem {
  final String name;
  final String description;
  final Widget? icon;
  final VoidCallback? onSelect;
  final bool isNewTile;

  PaymentListItem({
    required this.name,
    this.icon,
    this.onSelect,
  })  : isNewTile = false,
        description = '';

  PaymentListItem.detailed({
    required String title,
    required this.description,
    this.onSelect,
  })  : isNewTile = true,
        name = title,
        icon = null;
}
