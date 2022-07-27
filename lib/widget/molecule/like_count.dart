import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import '../atom/app_colors.dart';

class LikeCount extends StatelessWidget {
  final int count;

  const LikeCount({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/ic_grey_heart.svg',
          width: 12,
          height: 11.19,
        ),
        Container(
          width: 4,
        ),
        Text(
          NumberFormat.compact().format(count),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            fontFamily: AppFontFamilies.pretendard,
            color: AppColors.gray80,
          ),
        ),
      ],
    );
  }
}
