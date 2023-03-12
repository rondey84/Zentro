import 'package:flutter/material.dart';
import './back_button.dart' as custom;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.actions = const []});

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Center(
        child: custom.BackButton(),
      ),
      automaticallyImplyLeading: true,
      actions: [
        ...actions,
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
