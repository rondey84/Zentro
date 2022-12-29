import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zentro/data/model/onboard.dart';

class OnBoardContent extends StatelessWidget {
  final Onboard content;

  const OnBoardContent(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          content.image,
          height: 0.3.sh,
        ),
        const Spacer(),
        Text(content.title),
        const SizedBox(height: 16),
        Text(content.description),
        const Spacer(),
      ],
    );
  }
}
