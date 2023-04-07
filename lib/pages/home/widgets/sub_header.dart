part of '../home.dart';

class _SubHeader extends GetView<HomeController> {
  final String text;
  const _SubHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: controller.fontStyles!.header2,
      textAlign: TextAlign.left,
      maxLines: 1,
      overflow: TextOverflow.fade,
    );
  }
}
