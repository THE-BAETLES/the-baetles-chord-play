import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:the_baetles_chord_play/widget/atom/app_font_families.dart';

import '../atom/app_colors.dart';

class LikeCount extends StatelessWidget {
  final _widthPerHeight = 0.94083;

  final int count;
  final double width;
  final double space;
  final Color color;

  const LikeCount({
    Key? key,
    required this.count,
    required this.width,
    this.space = 10,
    this.color = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/ic_grey_heart.svg',
          width: width,
          height: width * _widthPerHeight,
          color: color,
        ),
        Container(
          height: space,
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
