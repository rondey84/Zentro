import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './back_button.dart' as custom;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final Widget? title;
  final double? titleSpacing;

  const CustomAppBar({
    super.key,
    this.actions = const [],
    this.title,
    this.titleSpacing,
  }) : _isSliverAppBar = false;

  const CustomAppBar.sliver({
    super.key,
    this.actions = const [],
    this.title,
    this.titleSpacing,
  }) : _isSliverAppBar = true;

  final bool _isSliverAppBar;

  @override
  Widget build(BuildContext context) {
    if (_isSliverAppBar) {
      return SliverAppBar(
        leading: const Center(child: custom.BackButton()),
        title: title,
        actions: [
          ...actions,
          const SizedBox(width: 16),
        ],
        pinned: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
      );
    }

    return AppBar(
      leading: const Center(
        child: custom.BackButton(),
      ),
      automaticallyImplyLeading: true,
      title: title,
      titleSpacing: titleSpacing,
      actions: [
        ...actions,
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
